# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomecanvas/libgnomecanvas-2.0.1.ebuild,v 1.9 2003/02/13 12:12:46 vapier Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Canvas library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2 LGPL-2.1" 


RDEPEND=">=gnome-base/libglade-2.0.0
	>=x11-libs/gtk+-2.0.2
	>=dev-libs/glib-2.0.0
	>=x11-libs/pango-1.0.0
	>=media-libs/libart_lgpl-2.3.8
	>=dev-libs/libxslt-1.0.16
	=media-libs/freetype-2.0*
	>=sys-devel/gettext-0.10.40
	>=sys-devel/perl-5.6.1
	>=sys-apps/gawk-3.1.0
	>=sys-devel/bison-1.28-r3"
												


DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"





