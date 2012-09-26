# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pymc/pymc-9999.ebuild,v 1.2 2012/09/26 17:22:56 heroxbd Exp $

EAPI=4

inherit distutils git-2

EGIT_REPO_URI="http://github.com/${PN}-devs/${PN}.git"
DESCRIPTION="Markov chain Monte Carlo for Python."
HOMEPAGE="http://github.com/${PN}-devs/${PN} http://pypi.python.org/pypi/${PN}"

SLOT=0
KEYWORDS=""
LICENSE=AFL-3.0
IUSE=""

DEPEND="dev-python/setuptools
	dev-python/pytables
	dev-python/numpy"

src_compile() {
	distutils_src_compile --fcompiler=gnu95
}
