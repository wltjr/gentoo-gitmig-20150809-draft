# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httptunnel/httptunnel-3.0.5.ebuild,v 1.5 2003/02/13 14:53:21 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="httptunnel can create IP tunnels through firewalls/proxies using HTTP"
HOMEPAGE="http://www.nocrew.org/software/httptunnel.html"
LICENSE="GPL"
DEPEND=""
KEYWORDS="x86 sparc "
SLOT="0"
#RDEPEND=""
SRC_URI="http://www.nocrew.org/software/httptunnel/httptunnel-3.0.5.tar.gz"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
