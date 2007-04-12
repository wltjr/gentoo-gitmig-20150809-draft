# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyparsing/pyparsing-1.4.6.ebuild,v 1.1 2007/04/12 18:04:20 pythonhead Exp $

inherit distutils

DESCRIPTION="pyparsing is an easy-to-use Python module for text parsing"
SRC_URI="mirror://sourceforge/pyparsing/${P}.tar.gz"
HOMEPAGE="http://pyparsing.wikispaces.com"
LICENSE="MIT"
SLOT="0"
DEPEND=">=dev-lang/python-2.3.2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

src_install() {
	dohtml HowToUsePyparsing.html
	dohtml -r htmldoc/*

	docinto examples
	dodoc examples/*
	docinto /
	dodoc CHANGES

	distutils_src_install
}
