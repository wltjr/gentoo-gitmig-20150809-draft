# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.1.4.ebuild,v 1.1 2009/01/13 23:15:34 alexxy Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE=libs/libkexiv2

inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="
	!<=media-libs/libkexiv2-0.1.7
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/lcms
"
RDEPEND="${DEPEND}"
