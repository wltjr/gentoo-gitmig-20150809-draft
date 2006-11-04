# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/trigger/trigger-0.5.2.1.ebuild,v 1.3 2006/11/04 13:53:54 kugelfang Exp $

inherit eutils games

DATA_V=0.5.2
DESCRIPTION="Free OpenGL rally car racing game"
HOMEPAGE="http://www.positro.net/trigger/"
SRC_URI="mirror://sourceforge/${PN}-rally/${P}-src.tar.bz2
	mirror://sourceforge/${PN}-rally/${PN}-${DATA_V}-data.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXt
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/openal
	media-libs/freealut
	dev-games/physfs"
DEPEND="${RDEPEND}
	x11-proto/xproto
	dev-util/jam"

S=${WORKDIR}/${P}-src

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR}/${PN}" || die
	jam -qa || die "jam failed"
}

src_install() {
	dogamesbin trigger || die "dogamesbin failed"

	cd ../${PN}-${DATA_V}-data
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r events maps plugins sounds textures vehicles trigger.config.defs \
		|| die "doins failed"

	dodoc README.txt README-stereo.txt
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "After running ${PN} for the first time, a config file is"
	elog "available in ~/.trigger/trigger.config"
	echo
}
