# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/iceiconcvt/iceiconcvt-0.9.ebuild,v 1.3 2003/05/19 14:29:22 phosphan Exp $

DESCRIPTION="IceWM icons' converter"
SRC_URI="mirror://sourceforge/icecc/${P}.tar.bz2"
HOMEPAGE="http://icecc.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="x86"
RESTRICT="nostrip"

DEPEND="PyQt"

SLOT="0"

src_compile () {
	einfo "No compilation necessary"
}

src_install () {
	exeinto /usr/bin
	doexe iceiconcvt.py
	dodoc ChangeLog BUGS README.iceiconcvt TODO
}
