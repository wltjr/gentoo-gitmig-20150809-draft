# Copyright 1999-2003 Gentoo Technologies, Inc. and Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/koth/koth-0.7.7.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit eutils

DESCRIPTION="Multiplayer, networked game of little tanks with really big weapons"
HOMEPAGE="http://www.nongnu.org/koth/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/default.pkg/${PV}/${P}.tar.bz2"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="media-libs/libggi"

src_install () {
	dodir /usr/bin
	make DESTDIR=${D} install || die "make install failed"
	insinto /etc/koth
	doins src/koth.cfg
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README doc/*.txt
}
