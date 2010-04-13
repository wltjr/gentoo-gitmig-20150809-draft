# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libinklevel/libinklevel-0.8.0-r1.ebuild,v 1.1 2010/04/13 17:17:35 serkan Exp $

EAPI="2"

inherit autotools

MY_P="${P/_/}"
DESCRIPTION="A library to get the ink level of your printer"
HOMEPAGE="http://libinklevel.sourceforge.net/"
SRC_URI="mirror://sourceforge/libinklevel/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"
IUSE="debug"

DEPEND=">=sys-libs/libieee1284-0.2.11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagicdebug.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	rm "${D}"/usr/lib/libinklevel.la
}
