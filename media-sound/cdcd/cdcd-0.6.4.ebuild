# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdcd/cdcd-0.6.4.ebuild,v 1.5 2002/12/07 06:47:21 jmorgan Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a simple yet powerful command line cd player"
SRC_URI="mirror://sourceforge/libcdaudio/${P}.tar.gz"
HOMEPAGE="http://cdcd.undergrid.net/"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.0
	>=sys-libs/readline-4.0
	>=media-libs/libcdaudio-0.99.4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

src_compile() {

	econf || die
	make || die
}

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
