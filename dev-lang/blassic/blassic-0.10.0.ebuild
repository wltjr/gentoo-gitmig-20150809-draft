# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/blassic/blassic-0.10.0.ebuild,v 1.1 2005/02/12 19:54:56 mr_bones_ Exp $

DESCRIPTION="classic Basic interpreter"
HOMEPAGE="http://www.blassic.org"
SRC_URI="http://www.blassic.org/bin/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~hppa ~ppc ~x86"
SLOT="0"
IUSE="svga X"

DEPEND="virtual/libc
	X? ( virtual/x11 )
	sys-libs/ncurses
	svga? ( media-libs/svgalib )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_with X x) \
		$(use_enable svga svgalib) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README THANKS TODO
}
