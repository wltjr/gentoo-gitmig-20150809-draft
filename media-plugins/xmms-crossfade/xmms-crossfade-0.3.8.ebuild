# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-crossfade/xmms-crossfade-0.3.8.ebuild,v 1.2 2004/11/11 09:50:58 eradicator Exp $

IUSE=""

DESCRIPTION="XMMS Plugin for crossfading, and continuous output."
SRC_URI="http://www.eisenlohr.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.eisenlohr.org/${PN}/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="media-sound/xmms"

src_compile() {
	econf --libdir=`xmms-config --output-plugin-dir` || die
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
