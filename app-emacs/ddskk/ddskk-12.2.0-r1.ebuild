# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ddskk/ddskk-12.2.0-r1.ebuild,v 1.4 2005/01/01 13:42:18 eradicator Exp $

inherit elisp

IUSE=""

MY_P=${PN}-${PV/_/}

DESCRIPTION="SKK is one of Japanese input methods on Emacs"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/${MY_P}.tar.bz2"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"

LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc ppc ~ppc-macos"
SLOT="0"

DEPEND=">=sys-apps/sed-4
	>=app-emacs/apel-10.6"
RDEPEND=">=app-emacs/apel-10.6
	|| ( virtual/skkserv app-i18n/skk-jisyo )"

SITEFILE=50ddskk-gentoo.el

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}
	find . -type f | xargs sed -i -e 's%/usr/local%/usr%g'
}

src_compile() {

	make < /dev/null || die
	make info < /dev/null || die
}

src_install () {

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	insinto /usr/share/skk
	doins etc/*SKK.tut* etc/skk.xpm

	dodoc READMEs/* ChangeLog*
	doinfo doc/skk.info*
}
