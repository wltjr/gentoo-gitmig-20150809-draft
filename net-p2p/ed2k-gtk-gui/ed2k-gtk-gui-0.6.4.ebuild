# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k-gtk-gui/ed2k-gtk-gui-0.6.4.ebuild,v 1.2 2005/06/20 00:47:01 vapier Exp $

inherit libtool

DESCRIPTION="GTK+ Client for overnet"
HOMEPAGE="http://ed2k-gtk-gui.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=net-libs/gnet-1.1"

src_compile() {
	econf || die "configure failed"
	sed -i -e "s:-DG_DISABLE_DEPRECATED -DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED::g" ed2k_gui/Makefile
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
}

pkg_postinst() {
	echo
	einfo "Please refer to ${HOMEPAGE} if you are"
	einfo "unable to set up the client."
	echo
	ewarn "ed2k-gtk-gui requires access to an overnet/edonkey core. If you"
	ewarn "do not have access to a core, you can install net-p2p/overnet."
	echo
}
