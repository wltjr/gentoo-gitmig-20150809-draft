# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/gltron/gltron-0.62.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

DESCRIPTION="3d tron, just like the movie"
SRC_URI="mirror://sourceforge/gltron/${P}-source.tar.gz"
HOMEPAGE="http://gltron.sourceforge.net/"

KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	sys-libs/zlib
	media-libs/libpng"
RDEPEND="${DEPEND}
	media-libs/sdl-sound"

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc CREDITS ChangeLog FAQ README TODO
	dohtml *.html
	prepgamesdirs
}
