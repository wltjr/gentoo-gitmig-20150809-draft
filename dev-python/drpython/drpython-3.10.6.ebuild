# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/drpython/drpython-3.10.6.ebuild,v 1.1 2005/02/19 13:36:26 radek Exp $

inherit eutils distutils

DESCRIPTION="A powerful cross-platform IDE for Python"
HOMEPAGE="http://drpython.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="virtual/python
	>=dev-python/wxpython-2.5.3.1"
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/drpython.py-${PV}.patch
}

src_install() {
	distutils_src_install
	distutils_python_version
	echo -e "#!/bin/sh\n\npython /usr/lib/python${PYVER}/site-packages/drpython/drpython.py \$@" > drpython
	dobin drpython
}

