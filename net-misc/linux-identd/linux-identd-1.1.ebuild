# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/linux-identd/linux-identd-1.1.ebuild,v 1.10 2003/02/13 14:58:42 vapier Exp $

# This identd is nearly perfect for a NAT box. It runs in one
# process (doesn't fork()) and isnt very susceptible to DOS attack.

DESCRIPTION="A real IDENT daemon for linux."
HOMEPAGE="http://www.fukt.bth.se/~per/identd"
S=${WORKDIR}/${P}
SRC_URI="http://www.fukt.bth.se/~per/identd/linux-identd-1.1.tar.gz"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
        emake || die
}

src_install () {
	dodir /etc/init.d /usr/sbin /usr/share/man/man8
	dodoc README COPYING ChangeLog
	make install DESTDIR=${D} MANDIR=/usr/share/man || die
	cp ${FILESDIR}/identd ${D}/etc/init.d
}
