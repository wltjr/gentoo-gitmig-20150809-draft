# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.6.ebuild,v 1.2 2005/04/30 02:05:43 dragonheart Exp $

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others. Also includes PhotoRec to recover pictures from digital camera memory."
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="static"
DEPEND=">=sys-libs/ncurses-5.2
	>=sys-fs/ntfsprogs-1.9.0
	>=sys-fs/e2fsprogs-1.35
	>=sys-fs/progsreiserfs-0.3.1_rc8"

src_compile() {
	econf || die
	if use static;
	then
		emake smallstatic || die
	else
		emake || die
	fi
}

src_install() {
	emake DESTDIR=${D} install || die
}

