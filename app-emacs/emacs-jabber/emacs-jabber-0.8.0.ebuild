# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-jabber/emacs-jabber-0.8.0.ebuild,v 1.1 2009/09/13 15:21:38 fauli Exp $

inherit elisp

DESCRIPTION="A Jabber client for Emacs"
HOMEPAGE="http://emacs-jabber.sourceforge.net/
	http://emacswiki.org/cgi-bin/wiki/JabberEl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

# emacs-jabber depends on >= gnus-5.10 which is available in
# app-emacs/gnus or bundled with app-editors/emacs-cvs.	 emacs 21.4a
# includes gnus-5.9

DEPEND=">=virtual/gnus-5.10
	virtual/flim"
RDEPEND="${DEPEND}"

SITEFILE=70${PN}-gentoo.el

src_compile() {
	elisp-compile *.el || die
	makeinfo jabber.texi || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo jabber.info
	dohtml html/*
	dodoc AUTHORS NEWS README || die
}
