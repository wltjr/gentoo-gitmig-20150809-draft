# Copyright 2001-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.2.15-r1.ebuild,v 1.3 2002/06/11 10:41:21 seemant Exp $

DESCRIPTION="Doxygen is a documentation system for C++, Java, IDL (Corba, Microsoft and KDE-DCOP flavors) and C"
HOMEPAGE="http://www.doxygen.org"
LICENSE="GPL-2"

RDEPEND="qt? ( =x11-libs/qt-* )
	media-gfx/graphviz"
DEPEND="$RDEPEND"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"

src_unpack() {

    unpack ${A}
    cd ${S}/addon/doxywizard
    patch -p0 < ${FILESDIR}/${P}-gentoo.diff
    
}

src_compile()
{

	use qt && CONFIGURE_OPTIONS="--with-doxywizard"

	./configure  --install install --prefix ${D}/usr ${CONFIGURE_OPTIONS} || die
	make all || die

}

src_install()
{

	make install || die
	dodoc README VERSION LICENSE LANGUAGE.HOWTO PLATFORMS

}
