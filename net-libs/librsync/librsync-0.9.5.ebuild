# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Author Justin <justin@skiingyac.com>
# $Header: /var/cvsroot/gentoo-x86/net-libs/librsync/librsync-0.9.5.ebuild,v 1.1 2002/04/29 08:59:14 bangert Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Flexible remote checksum-based differencing"
SRC_URI="http://prdownloads.sourceforge.net/rproxy/${P}.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/rproxy/"

DEPEND="virtual/glibc"


src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install  || die

	dodoc COPYING NEWS INSTALL AUTHORS THANKS README TODO
}
