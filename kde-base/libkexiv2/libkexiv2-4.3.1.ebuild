# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.3.1.ebuild,v 1.2 2009/10/10 10:29:24 ssuominen Exp $

EAPI="2"

KMNAME="kdegraphics"
KMMODULE="libs/libkexiv2"
inherit kde4-meta

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
HOMEPAGE="http://www.kipi-plugins.org"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.18
	media-libs/jpeg
	media-libs/lcms
"
RDEPEND="${DEPEND}"
