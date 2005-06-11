# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyxml/pyxml-0.8.3.ebuild,v 1.16 2005/06/11 06:41:28 pythonhead Exp $

inherit distutils

MY_P=${P/pyxml/PyXML}

DESCRIPTION="A collection of libraries to process XML with Python"
HOMEPAGE="http://pyxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyxml/${MY_P}.tar.gz"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="<dev-lang/python-2.4
	>=dev-libs/expat-1.95.6"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf

	# if you want to use 4Suite, then their XSLT/XPATH is
	# better according to the docs
	if has_version "dev-python/4suite"; then
		myconf="--without-xslt --without-xpath"
	fi

	distutils_src_compile ${myconf}
}

src_install() {
	mydoc="ANNOUNCE CREDITS PKG-INFO"
	distutils_src_install

	dohtml -r doc/*
}
