# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/endpoint/endpoint-0.1.0.ebuild,v 1.2 2006/02/27 20:31:23 swegener Exp $

DESCRIPTION="Endpoint turns a Linux machine with one or more firewire cards into an SBP-2 device."
HOMEPAGE="http://oss.oracle.com/projects/endpoint/"
SRC_URI="http://oss.oracle.com/projects/endpoint/dist/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc
		>=sys-libs/libraw1394-0.9
		>=dev-libs/glib-2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-errormessages.patch
}

src_install() {
	emake -j1 install DESTDIR="${D}"
	insinto /etc
	newins docs/sample-endpoint.conf endpoint.conf
	dodoc README AUTHORS ChangeLog
}
