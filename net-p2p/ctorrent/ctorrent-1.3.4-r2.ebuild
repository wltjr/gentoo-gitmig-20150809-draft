# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ctorrent/ctorrent-1.3.4-r2.ebuild,v 1.1 2005/10/29 11:35:55 sekretarz Exp $

inherit eutils

DESCRIPTION="CTorrent is a BitTorrent console client written in C."
HOMEPAGE="http://ctorrent.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	http://www.rahul.net/dholmes/ctorrent/patchset-${P}-dnh1.diff"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4
	dev-libs/openssl"

src_unpack()
{
	unpack ${A}
	cd ${S}

	epatch ${DISTDIR}/patchset-${P}-dnh1.diff
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README NEWS
}
