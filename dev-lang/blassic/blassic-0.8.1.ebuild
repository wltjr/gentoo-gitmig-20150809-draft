# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/blassic/blassic-0.8.1.ebuild,v 1.6 2005/02/12 19:54:56 mr_bones_ Exp $

DESCRIPTION="classic Basic interpreter"
HOMEPAGE="http://www.arrakis.es/~ninsesabe/blassic/index.html"
SRC_URI="http://www.arrakis.es/~ninsesabe/blassic/${P}.tgz"

KEYWORDS="x86 ~ppc hppa"
LICENSE="GPL-2"
SLOT="0"
IUSE="svga"

DEPEND="virtual/x11
	sys-libs/ncurses
	svga? ( media-libs/svgalib )"

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable svga svgalib) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS README THANKS TODO
}
