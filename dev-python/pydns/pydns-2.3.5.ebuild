# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydns/pydns-2.3.5.ebuild,v 1.1 2011/07/10 00:51:10 sbriesen Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python module for DNS (Domain Name Service)"
HOMEPAGE="http://pydns.sourceforge.net/ http://pypi.python.org/pypi/pydns"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${P}/${P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="virtual/libiconv"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CREDITS.txt"
PYTHON_MODNAME="DNS"

src_prepare() {
	# Fix encodings (should be utf-8 but is latin1).
	for i in "${PYTHON_MODNAME}"/{Lib,Type}.py; do
		iconv -f ISO-8859-1 -t UTF-8 < "${i}" > "${i}~" && mv -f "${i}~" "${i}" || rm -f "${i}~"
	done

	# Don't compile bytecode.
	sed -i -e 's:^\(compile\).*:\1 = 0:g' -e 's:^\(optimize\).*:\1 = 0:g' setup.cfg

	# Fix Python shebangs in examples.
	sed -i -e 's:#!/.*\(python\).*/*$:#!/usr/bin/\12:g' {tests,tools}/*.py
}

src_install(){
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins tests/*.py tools/*.py
	fi
}
