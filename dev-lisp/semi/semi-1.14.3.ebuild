# Copyright 2002 moto kawasaki <kawasaki@kawasaki3.org>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/semi/semi-1.14.3.ebuild,v 1.2 2002/06/29 03:14:17 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a library to provide MIME feature for GNU Emacs -- SEMI"
SRC_URI="ftp://ftp.m17n.org/pub/mule/semi/semi-1.14-for-flim-1.14/${P}.tar.gz"
HOMEPAGE="http://www.m17n.org/semi/"

DEPEND=">=app-editors/emacs-20.4
		>=dev-lisp/apel-9.22
		>=dev-lisp/flim-1.14.2"
RDEPEND="${depend}"

SLOT="0"
LICENSE="GPL-2"

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc ChangeLog NEWS README* SEMI* TODO VERSION
}
