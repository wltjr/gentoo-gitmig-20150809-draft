# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.2.0.ebuild,v 1.6 2003/02/22 00:08:13 agriffis Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a CORBA framework "
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ~ppc alpha"
LICENSE="LGPL-2.1 GPL-2"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.6 )"
MAKEOPTS="-j1"
DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"
