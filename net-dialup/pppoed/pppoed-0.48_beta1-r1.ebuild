# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pppoed/pppoed-0.48_beta1-r1.ebuild,v 1.9 2003/02/13 13:54:59 vapier Exp $

S=${WORKDIR}/pppoed-0.48b1/pppoed
DESCRIPTION="PPP over Ethernet"
SRC_URI="http://www.davin.ottawa.on.ca/pppoe/pppoed-0.48b1.tgz"
HOMEPAGE="http://www.davin.ottawa.on.ca/pppoe/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_compile() {													 
	econf \
		--sysconfdir=/etc/ppp/pppoed || die
	make || die
}

src_install() {															 

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING NEWS README*

	cd ..
	docinto docs
	dodoc docs/*
	docinto contrib
	dodoc contribs/*
}
