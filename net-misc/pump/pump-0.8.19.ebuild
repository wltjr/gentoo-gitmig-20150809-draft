# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pump/pump-0.8.19.ebuild,v 1.1 2003/09/14 16:11:48 iggy Exp $

DESCRIPTION="This is the DHCP/BOOTP client written by RedHat"
SRC_URI="http://ftp.debian.org/debian/pool/main/p/${PN}/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://ftp.debian.org/debian/pool/main/p/pump/"

KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/popt-1.5"

src_compile() {
	make pump || die
}

src_install () {
	exeinto /sbin
	doexe pump

	insinto /etc
	doins ${FILESDIR}/pump.conf

	doman pump.8
	dodoc COPYING CREDITS
}
