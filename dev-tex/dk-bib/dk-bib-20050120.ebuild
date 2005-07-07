# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/dk-bib/dk-bib-20050120.ebuild,v 1.3 2005/07/07 10:00:39 brix Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="Danish translation of the standard BibTeX style files"
HOMEPAGE="http://www.tug.org/tex-archive/biblio/bibtex/contrib/dk-bib/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""
RDEPEND="dev-tex/xkeyval"

src_install() {
	cd ${S}
	latex-package_src_install

	dodoc README
}
