# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomeprint/libgnomeprint-2.4.0.ebuild,v 1.7 2003/11/15 02:51:33 agriffis Exp $

inherit gnome2

DESCRIPTION="Printer handling for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.2"
KEYWORDS="x86 ppc alpha sparc ~hppa amd64 ia64"
IUSE="cups doc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/pango-1
	>=media-libs/fontconfig-1
	>=media-libs/libart_lgpl-2.3.7
	>=dev-libs/libxml2-2.4.23
	>=media-libs/freetype-2.0.5
	cups? ( >=net-print/cups-1.1 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

use cups \
	&& G2CONF="${G2CONF} --with-cups" \
	|| G2CONF="${G2CONF} --without-cups"

DOCS="AUTHORS COPYING* ChangeLog* INSTALL NEWS README"
