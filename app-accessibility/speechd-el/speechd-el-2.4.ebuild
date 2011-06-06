# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speechd-el/speechd-el-2.4.ebuild,v 1.1 2011/06/06 20:01:12 cbrannon Exp $

EAPI="4"
NEED_EMACS=23
inherit elisp

DESCRIPTION="Emacs speech support"
HOMEPAGE="http://www.freebsoft.org/speechd-el"
SRC_URI="http://www.freebsoft.org/pub/projects/speechd-el/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="brltty"

DEPEND=""
RDEPEND=">=app-accessibility/speech-dispatcher-0.7
	brltty? ( app-accessibility/brltty )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-emacs23.patch
}

src_compile() {
	emake
}

src_install() {
	elisp-install ${PN} *.el *.elc
	dobin speechd-log-extractor
	dodoc ANNOUNCE NEWS README speechd-speak.pdf
	doinfo speechd-el.info
}

pkg_postinst() {
	elog "Execute the following commands from within emacs to get it to speak:"
	elog "  M-x load-library RET speechd-speak RET"
	elog "  M-x speechd-speak RET"
	elog
	elog "or add the following to your ~/.emacs file:"
	elog
	elog "(autoload 'speechd-speak \"speechd-speak\" nil t)"
	elog '(speechd-speak)'
}
