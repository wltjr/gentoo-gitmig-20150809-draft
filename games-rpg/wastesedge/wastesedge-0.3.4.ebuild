# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/wastesedge/wastesedge-0.3.4.ebuild,v 1.8 2009/09/14 01:08:33 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="role playing game to showcase the adonthell engine"
HOMEPAGE="http://adonthell.linuxgames.com/"
SRC_URI="http://savannah.nongnu.org/download/adonthell/${PN}-src-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="vorbis doc nls"
RESTRICT="userpriv"

RDEPEND=">=dev-lang/python-2.0
	>=games-rpg/adonthell-0.3.3
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	doc? ( >=app-doc/doxygen-1.2 )"

src_configure(){
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable doc) \
		--with-adonthell-binary="${GAMES_BINDIR}/adonthell"
}

src_install(){
	emake DESTDIR="${D}" pixmapdir=/usr/share/pixmaps install \
		|| die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS PLAYING README
	make_desktop_entry adonthell-wastesedge "Waste's Edge" wastesedge_32x32
	prepgamesdirs
}
