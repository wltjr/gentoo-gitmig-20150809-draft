# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/psyco/psyco-1.5.2.ebuild,v 1.1 2007/06/27 09:49:35 hawking Exp $

inherit distutils

DESCRIPTION="Python extension module which can massively speed up the execution of any Python code."
HOMEPAGE="http://psyco.sourceforge.net/"
SRC_URI="mirror://sourceforge/psyco/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=">=dev-lang/python-2.1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# whrandom is deprecated in python-2.4
	# and removed in 2.5
	sed -i \
		-e "s/whrandom/random/g" \
		test/life.py test/life-psyco.py || die "sed failed"
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/bpnn.py test/life.py test/life-psyco.py test/pystone.py
	fi
}

src_test() {
	cd "${S}/test"
	PYTHONPATH="$(ls -d ../build/lib.*)" ${python} test_base.py || die "tests failed"
}
