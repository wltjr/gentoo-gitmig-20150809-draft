# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki/emacs-wiki-2.40.ebuild,v 1.5 2005/01/01 13:44:29 eradicator Exp $

inherit elisp

IUSE=""

# SRC_URI Note: tar.gz is constructed by downloading the ChangeLog and
# emacs-wiki.el.gz 

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://repose.cx/emacs/wiki/
	http://www.emacswiki.org/cgi-bin/wiki.pl?EmacsWikiMode"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/emacs"

SITEFILE=50emacs-wiki-gentoo.el

src_compile() {
	emacs --batch -f batch-byte-compile --no-site-file --no-init-file *.el
}

src_install() {
	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
