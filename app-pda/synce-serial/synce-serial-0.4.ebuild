# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-serial/synce-serial-0.4.ebuild,v 1.7 2004/06/24 21:47:08 agriffis Exp $

DESCRIPTION="Synchronize Windows CE devices with computers running GNU/Linux, like MS ActiveSync."
HOMEPAGE="http://sourceforge.net/projects/synce/"
SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D%/}" install || die
}
