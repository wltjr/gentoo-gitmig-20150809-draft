# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/scribus-svg/scribus-svg-0.2.ebuild,v 1.1 2002/11/26 09:03:49 hanno Exp $

S=${WORKDIR}/svgexplugin-${PV}
DESCRIPTION="SVG export plugin for Scribus"
HOMEPAGE="http://web2.altmuehlnet.de/fschmid"
SRC_URI="http://web2.altmuehlnet.de/fschmid/svgexplugin-${PV}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND="app-office/scribus"

src_compile() {
	econf || die
	emake CXXFLAGS="${CXXFLAGS} -I/usr/include/lcms" || die
}

src_install () {
	einstall destdir=${D} || die
}
