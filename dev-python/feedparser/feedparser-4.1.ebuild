# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/feedparser/feedparser-4.1.ebuild,v 1.5 2006/06/12 23:51:25 weeve Exp $

inherit distutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://www.feedparser.org/"
SRC_URI="mirror://sourceforge/feedparser/${P}.zip"
LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="app-arch/unzip"

S=${WORKDIR}
DOCS="LICENSE"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r docs
}
