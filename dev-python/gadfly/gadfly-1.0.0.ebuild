# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/gadfly/gadfly-1.0.0.ebuild,v 1.1 2002/12/17 21:18:25 blauwers Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gadfly is a relational database system implemented in Python."
SRC_URI="mirror://sourceforge/gadfly/${P}.tar.gz"
HOMEPAGE="http://gadfly.sourceforge.net/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="~x86"
LICENSE="BSD"

src_compile() {
	python setup.py build || die "gadfly compilation failed"
	cd kjbuckets
	python setup.py build || die "kjbuckets compilation failed"
	cd ..
}

src_install() {
	python setup.py install --root=${D} || die
	cd kjbuckets
	python setup.py install --root=${D} || die
	cd ..
	dodoc *.txt doc/*.txt
}
