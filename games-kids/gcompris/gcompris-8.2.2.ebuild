# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gcompris/gcompris-8.2.2.ebuild,v 1.1 2007/03/10 10:54:19 nyhm Exp $

inherit autotools eutils python games

DESCRIPTION="full featured educational application for children from 2 to 10"
HOMEPAGE="http://gcompris.net/"
SRC_URI="mirror://sourceforge/gcompris/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug gnet python sqlite"

RDEPEND="=x11-libs/gtk+-2*
	gnome-base/libgnomecanvas
	media-libs/sdl-mixer
	media-libs/libsdl
	dev-libs/libxml2
	dev-libs/popt
	virtual/libintl
	games-board/gnuchess
	gnet? ( >=net-libs/gnet-2 )
	python? (
		dev-python/gnome-python
		dev-python/pygtk
		dev-python/pyxml
		>=dev-python/pysqlite-2
	)
	sqlite? ( dev-db/sqlite )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	sys-apps/texinfo
	app-text/texi2html
	dev-util/pkgconfig"
RDEPEND="${RDEPEND}
	media-gfx/tuxpaint
	sci-electronics/gnucap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	cp /usr/share/gettext/config.rpath .
	eautoreconf
}

src_compile() {
	python_version
	GNUCHESS=${GAMES_BINDIR}/gnuchess \
	egamesconf \
		--disable-dependency-tracking \
		--enable-xf86vidmode \
		--disable-cairo \
		$(use_with python python /usr/bin/python${PYVER}) \
		$(use_enable debug) \
		$(use_enable gnet) \
		$(use_enable sqlite) \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	prepgamesdirs
}
