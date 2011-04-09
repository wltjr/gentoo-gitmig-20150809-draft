# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy-plus/synergy-plus-1.3.4.ebuild,v 1.6 2011/04/09 07:55:38 xarthisius Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="http://code.google.com/p/synergy-plus/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
#SRC_URI="mirror://google/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE=""

CDEPEND="x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama"
RDEPEND="${CDEPEND}
	!x11-misc/synergy"
DEPEND="${CDEPEND}
	x11-proto/xextproto
	x11-proto/xproto
	x11-proto/kbproto
	x11-proto/xineramaproto
	x11-libs/libXt"

src_prepare() {
	sed -i -e '/ACX_CXX_WARNINGS_ARE_ERRORS/d' configure.in || die #362675

	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
	insinto /etc
	doins examples/synergy.conf || die
}

pkg_postinst() {
	echo ''
	elog "${PN} can also be used to connect to computers running Windows or Mac OS X."
	elog "Visit ${HOMEPAGE} to find the Windows client and Mac OS X client."
	echo ''
}
