# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fc/xmms-fc-0.5.4.ebuild,v 1.2 2004/09/02 23:31:30 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Amiga Future Composer plug-in for XMMS"
HOMEPAGE="http://xmms-fc.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-fc/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc amd64 sparc"

DEPEND="media-sound/xmms"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc COPYING ChangeLog INSTALL README
}
