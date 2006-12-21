# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lde/lde-2.6.1.ebuild,v 1.2 2006/12/21 16:56:13 vapier Exp $

inherit eutils

DESCRIPTION="ext2fs and minix disk editor for linux"
HOMEPAGE="http://lde.sourceforge.net/"
SRC_URI="mirror://sourceforge/lde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	dev-util/yacc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-shadowing.patch #141881
}

src_install() {
	into /
	dosbin lde || die
	newman doc/lde.man lde.8
	dodoc WARNING README TODO
}
