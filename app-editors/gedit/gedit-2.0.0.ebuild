# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.0.0.ebuild,v 1.2 2002/07/11 06:30:11 drobbins Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A text editor for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/pango-1.0.3
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.4
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/libgnomeprintui-1.115.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

	
DOCS="AUTHORS BUGS ChangeLog COPYING FAQ INSTALL NEWS  README*  THANKS TODO"



SCHEMAS="gedit.schemas"

