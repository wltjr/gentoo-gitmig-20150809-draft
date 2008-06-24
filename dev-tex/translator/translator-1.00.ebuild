# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/translator/translator-1.00.ebuild,v 1.2 2008/06/24 18:12:14 fmccor Exp $

inherit latex-package

DESCRIPTION="A package for translating words in TeX"
HOMEPAGE="http://latex-beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/latex-beamer/${P}.tar.gz"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86-fbsd"
IUSE="doc"

TEXMF="/usr/share/texmf-site"

src_install() {
	insinto ${TEXMF}/tex/latex/${PN}
	doins base/* || die "Failed to install the package"
	doins -r dicts/* || die "Failed to install dictonaries"
	dodoc ChangeLog README || die "dodoc failed"
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r doc/* || die "Failed to install documentation"
	fi
}
