# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.5.ebuild,v 1.4 2004/03/02 16:45:33 iggy Exp $

DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="mirror://gnu/cpio/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"

KEYWORDS="x86 amd64 ppc sparc alpha hppa mips ia64 ppc64 s390"
SLOT="0"
LICENSE="GPL-2 LGPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "78d" rmt.c
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	#our official mt is now the mt in app-arch/mt-st (supports Linux 2.4, unlike this one)
	dobin cpio
	doman cpio.1
	dodoc COPYING* ChangeLog NEWS README INSTALL
}
