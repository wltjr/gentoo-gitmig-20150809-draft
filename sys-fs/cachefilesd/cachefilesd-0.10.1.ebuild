# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cachefilesd/cachefilesd-0.10.1.ebuild,v 1.1 2010/09/19 08:08:16 jlec Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Provides a caching directory on an already mounted filesystem"
HOMEPAGE="http://people.redhat.com/~dhowells/fscache/"
SRC_URI="http://people.redhat.com/~dhowells/fscache/${P}.tar.bz2"

IUSE="doc selinux"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-makefile.patch
	tc-export CC
	if ! use selinux; then
	 sed -e '/^secctx/s:^:#:g' -i cachefilesd.conf || die
	fi
}
src_install() {
	emake DESTDIR="${D}"  install || die "install failed"

	if use selinux; then
		insinto /usr/share/doc/${P}
		doins -r selinux || die
	fi

	dodoc README howto.txt || die

	newconfd "${FILESDIR}"/cachefilesd.conf cachefilesd || die
	newinitd "${FILESDIR}"/cachefilesd.init cachefilesd || die

	keepdir /var/cache/cachefilesd
}

pkg_postinst() {
	[[ -d /var/fscache ]] && return
	elog "Before CacheFiles can be used, a directory for local storage"
	elog "must be created.  The default configuration of /etc/cachefilesd.conf"
	elog "uses /var/fscache.  The filesystem mounted there must support"
	elog "extended attributes (mount -o user_xattr)."
	elog ""
	elog "Once that is taken care of, start the daemon, add -o ...,fsc"
	elog "to the mount options of your network mounts, and let it fly!"
}
