# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gofish/gofish-1.0.ebuild,v 1.1 2005/09/03 01:36:16 vanquirius Exp $

inherit eutils

DESCRIPTION="Gofish gopher server"
HOMEPAGE="http://gofish.sourceforge.net"
SRC_URI="mirror://sourceforge/gofish/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND=""

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup gopher 30
	enewuser gopher 30 -1 -1 gopher
}

src_compile() {
	econf --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--disable-http || die "econf failed"
	emake || die
}

src_install () {
	sed -i s/';uid = -1'/'uid = 30'/ ${S}/gofish.conf
	sed -i s/';gid = -1'/'uid = 30'/ ${S}/gofish.conf
	make DESTDIR="${D}" install || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/gofish.rc gofish
	insinto /etc/conf.d ; newins ${FILESDIR}/gofish.confd gofish
}

pkg_postinst() {
	einfo "Please edit /etc/${PN}.conf before using."
}
