# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.07.ebuild,v 1.2 2003/10/21 22:52:59 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM2/tools/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-libs/device-mapper-1"
RDEPEND="${DEPEND}
	!sys-apps/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_compile() {
	econf

	# parallel build doesn't work
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin"
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
