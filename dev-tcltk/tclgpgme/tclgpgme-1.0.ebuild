# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclgpgme/tclgpgme-1.0.ebuild,v 1.3 2003/03/02 03:28:12 agenkin Exp $

DESCRIPTION="Tcl/Tk libraries to gpgme."
HOMEPAGE="http://beepcore-tcl.sourceforge.net/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	=app-crypt/gpgme-0.3*"

LICENSE="BSD"
KEYWORDS="x86"

SLOT="0"
SRC_URI="http://beepcore-tcl.sourceforge.net/${P}.tgz"
S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${S}

	patch -p 0 < ${FILESDIR}/${PV}-Makefile.in.diff || die

}

src_compile() {

	econf --with-tcl=/usr/lib --with-tk=/usr/lib || die
	make || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL LICENSE README TODO

}
