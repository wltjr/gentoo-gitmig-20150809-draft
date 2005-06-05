# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.10.0.ebuild,v 1.4 2005/06/05 18:57:46 foser Exp $

inherit gnome2 eutils

DESCRIPTION="The Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ~ppc64"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-2
	>=x11-libs/libwnck-2.5
	>=gnome-base/libgtop-2.9.5
	>=x11-libs/gtk+-2.5
	>=gnome-base/gnome-vfs-2.6"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29
	${RDEPEND}"

DOCS="AUTHORS ChangeLog HACKING README NEWS TODO"
USE_DESTDIR="1"

src_unpack() {

	unpack ${A}

	cd ${S}
	# remove warnings
	epatch ${FILESDIR}/${PN}-2.10.1-icon_warning.patch

}
