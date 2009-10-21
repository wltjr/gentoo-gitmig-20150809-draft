# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/xsim/xsim-0.3.9.4-r5.ebuild,v 1.3 2009/10/21 15:11:40 ssuominen Exp $

EAPI=2
inherit db-use eutils flag-o-matic multilib

DESCRIPTION="A simple and fast GB and BIG5 Chinese XIM server"
HOMEPAGE="http://developer.berlios.de/projects/xsim/"
SRC_URI="mirror://berlios/xsim/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=sys-libs/db-4.1"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_prepare() {
	local dbver

	epatch "${FILESDIR}"/${P}-compile-fix.patch
	epatch "${FILESDIR}"/${P}-gcc-3.4.patch
	epatch "${FILESDIR}"/${P}-64bit.patch
	# bug 227117
	epatch "${FILESDIR}"/${P}-gcc-4.3.patch

	append-flags -DPIC -fPIC -fno-strict-aliasing

	dbver="$(db_findver sys-libs/db)"
	sed -i -e "s/\(CFLAGS.*\)-O2/\1${CFLAGS}/" \
		-e "s/libdb_cxx.so/libdb_cxx-${dbver}.so/" \
		-e "s/bdblib=\"db_cxx\"/bdblib=\"db_cxx-${dbver}\"/" configure* || die

	find . -name '*.in' | xargs sed -i \
		-e "s#\(@prefix@/\)\(dat\|plugins\)#\1$(get_libdir)/xsim/\2#" \
		-e "s#@prefix@/etc#/etc#" || die
}

src_configure() {
	local myconf=""

	use debug && myconf="--enable-debug"

	econf \
		--with-bdb-includes=$(db_includedir) \
		--without-qt3 \
		--without-kde3 \
		${myconf}
}

src_install() {
	emake \
		xsim_datp="${D}"/usr/$(get_libdir)/xsim/dat \
		xsim_libp="${D}"usr/$(get_libdir)/xsim/plugins \
		xsim_binp="${D}"/usr/bin \
		xsim_etcp="${D}"/etc \
		install-data install || die

	dodoc ChangeLog KNOWNBUG README* TODO
}

pkg_postinst() {
	elog "XSIM needs write access to /usr/$(get_libdir)/xsim/dat/chardb, so if you"
	elog "not running it as root, you need to do the following:"
	elog
	elog "	cp -r /usr/$(get_libdir)/xsim/dat \${HOME}/.xsim"
	elog "	sed -i \"s#DICT_LOCAL.*#DICT_LOCAL \${HOME}/.xsim#\" > \${HOME}/.xsim/xsimrc"
	echo
}
