# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.97.ebuild,v 1.1 2008/11/02 09:08:32 matsuu Exp $

inherit distutils

IUSE=""

DESCRIPTION="Python binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/mecab/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}"

DOCS="test.py"

src_install() {

	distutils_src_install
	dohtml bindings.html || die

}
