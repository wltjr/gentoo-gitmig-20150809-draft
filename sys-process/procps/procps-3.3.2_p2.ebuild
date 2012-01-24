# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/procps/procps-3.3.2_p2.ebuild,v 1.1 2012/01/24 06:20:13 vapier Exp $

EAPI="4"

inherit flag-o-matic eutils toolchain-funcs multilib

DEB_VER=${PV#*_p}
MY_PV=${PV%_p*}
DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="http://procps.sourceforge.net/ http://gitorious.org/procps http://packages.debian.org/sid/procps"
SRC_URI="mirror://debian/pool/main/p/procps/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/p/procps/${PN}_${MY_PV}-${DEB_VER}.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs unicode"

RDEPEND=">=sys-libs/ncurses-5.2-r2[unicode?]"

S=${WORKDIR}/${PN}-ng-${MY_PV}

src_prepare() {
	local d="${WORKDIR}"/debian/patches
	EPATCH_SOURCE="${d}" epatch $(<"${d}"/series)

	epatch "${FILESDIR}"/${PN}-3.3.2-noproc.patch
	epatch "${FILESDIR}"/${PN}-3.3.2-headers.patch
}

src_configure() {
	econf \
		--exec-prefix="${EPREFIX}/" \
		--docdir='$(datarootdir)'/doc/${PF} \
		$(use_enable static-libs static)
}

src_install() {
	default

	# Baselayout takes care of this file
	dodoc "${ED}"/etc/sysctl.conf
	rm "${ED}"/etc/sysctl.conf || die

	# The configure script is completely whacked in the head
	mv "${ED}"/lib* "${ED}"/usr/ || die
	gen_usr_ldscript -a procps
	find "${ED}" -name '*.la' -delete
}
