# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtar/libtar-1.2.11-r1.ebuild,v 1.1 2005/03/01 00:00:33 vapier Exp $

inherit eutils

DESCRIPTION="C library for manipulating POSIX tar files"
HOMEPAGE="http://www.feep.net/libtar/"
SRC_URI="ftp://ftp.feep.net/pub/software/libtar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-memleak.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog README TODO
}
