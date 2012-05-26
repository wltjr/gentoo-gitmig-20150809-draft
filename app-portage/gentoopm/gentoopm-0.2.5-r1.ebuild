# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gentoopm/gentoopm-0.2.5-r1.ebuild,v 1.1 2012/05/26 10:11:21 mgorny Exp $

EAPI=4
PYTHON_COMPAT='python2_6 python2_7 python3_1 python3_2'

inherit base python-distutils-ng

DESCRIPTION="A common interface to Gentoo package managers"
HOMEPAGE="https://github.com/mgorny/gentoopm/"
SRC_URI="mirror://github/mgorny/${PN}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="|| ( >=sys-apps/portage-2.1.10.3
		sys-apps/pkgcore
		>=sys-apps/paludis-0.64.2[python-bindings] )"
DEPEND="doc? ( dev-python/epydoc )"
PDEPEND="app-admin/eselect-package-manager"

python_prepare_all() {
	base_src_prepare
}

src_compile() {
	python-distutils-ng_src_compile

	if use doc; then
		"${PYTHON}" setup.py doc || die
	fi
}

python_install_all() {
	if use doc; then
		dohtml -r doc/*
	fi
}
