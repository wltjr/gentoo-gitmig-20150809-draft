# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/korilla/korilla-1.3.3.ebuild,v 1.1 2003/11/12 08:39:31 tad Exp $

inherit kde # not kde-base since we don't need c++ deps

need-kde 3

DESCRIPTION="Kool Gorilla Icon Set for KDE"
SRC_URI="http://www.starsurvivor.net/linux/gorilla/Korilla-v${PV}.tar.bz2"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="as-is"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_unpack() {
	unpack Korilla-v${PV}.tar.bz2
	mv "Kool.Gorilla" "${P}"
}

src_compile() {
	return 1
}

src_install(){
	dodir $PREFIX/share/icons/
	cp -r ${S} ${D}/${PREFIX}/share/icons/
}
