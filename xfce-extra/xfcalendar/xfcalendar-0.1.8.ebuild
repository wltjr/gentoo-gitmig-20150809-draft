# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfcalendar/xfcalendar-0.1.8.ebuild,v 1.2 2004/04/27 15:57:47 pvdabeel Exp $

IUSE=""

DESCRIPTION="Xfce4 panel calendar plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://hannelore.f1.fhtw-berlin.de/mirrors/xfce4/xfce-4.0.5/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86 ppc ~alpha ~sparc ~amd64 ~hppa ~mips"

RDEPEND=">=x11-libs/gtk+-2.0.6
	dev-libs/libxml2
	>=xfce-base/xfce4-base-4.0.3
	>=xfce-base/libxfce4util-4.0.3
	>=xfce-base/libxfcegui4-4.0.3
	>=xfce-base/libxfce4mcs-4.0.3
	>=xfce-base/xfce-mcs-manager-4.0.3
	>=dev-libs/dbh-1.0.18"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL COPYING README ChangeLog
}
