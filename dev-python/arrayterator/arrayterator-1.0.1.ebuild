# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/arrayterator/arrayterator-1.0.1.ebuild,v 1.3 2010/07/09 22:20:03 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="This class creates a buffered iterator for reading big arrays in small contiguous blocks."
HOMEPAGE="http://pypi.python.org/pypi/arrayterator"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/numpy-1.0_rc1"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="arrayterator.py"

src_test() {
	cd tests

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" -c "import test_stochastic; test_stochastic.test()"
	}
	python_execute_function testing
}
