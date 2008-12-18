# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/updatedd/updatedd-2.5.ebuild,v 1.6 2008/12/18 04:15:31 serkan Exp $

DESCRIPTION="Dynamic DNS client with plugins for several dynamic dns services"
HOMEPAGE="http://savannah.nongnu.org/projects/updatedd/"
SRC_URI="http://savannah.nongnu.org/download/updatedd/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="virtual/libc"

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/updatedd "${D}"/usr/share/doc/${PF}
	dodoc AUTHORS
}
