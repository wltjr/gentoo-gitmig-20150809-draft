# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/xdrawchem/xdrawchem-1.6.ebuild,v 1.1 2002/11/29 03:34:13 george Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="XDrawChem--a molecular structure drawing program."
SRC_URI="http://www.prism.gatech.edu/~gte067k/${PN}/${P}.tgz"
HOMEPAGE="http://www.prism.gatech.edu/~gte067k/${PN}"

KEYWORDS="~x86 ~ppc ~sparc ~sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="qt? ( >=qt-3.0.0 )"

#the app requires babel at run time to be able to perform various file type conversions
RDEPEND="${DEPEND}
	app-sci/babel"

src_compile() {
	./configure --prefix=/usr || die
	emake -f Makefile INSTRING=/usr/share/xdrawchem || die
}

src_install () {
	dodir /usr/bin
	dobin xdrawchem/xdrawchem

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ring/*

	dodoc README.txt TODO.txt COPYRIGHT.txt HISTORY.txt
}

