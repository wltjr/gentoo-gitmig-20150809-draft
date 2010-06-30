# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyyaml/pyyaml-3.09.ebuild,v 1.6 2010/06/30 00:13:50 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P="PyYAML-${PV}"

DESCRIPTION="YAML parser and emitter for Python"
HOMEPAGE="http://pyyaml.org/wiki/PyYAML http://pypi.python.org/pypi/PyYAML"
SRC_URI="http://pyyaml.org/download/${PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-linux ~x86-macos"
IUSE="examples libyaml"

DEPEND="libyaml? ( dev-libs/libyaml dev-python/pyrex )"
RDEPEND="libyaml? ( dev-libs/libyaml )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="yaml"

pkg_setup() {
	DISTUTILS_GLOBAL_OPTIONS=($(use_with libyaml))
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/.
	fi
}
