# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-5.08.ebuild,v 1.2 2011/02/27 22:05:51 hwoarang Exp $

EAPI=2
inherit flag-o-matic games

DESCRIPTION="Console based chess interface"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"

KEYWORDS="~alpha amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline )"

src_configure() {
	strip-flags # bug #199097
	egamesconf \
		--disable-dependency-tracking \
		$(use_with readline)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS TODO doc/README
	prepgamesdirs
}
