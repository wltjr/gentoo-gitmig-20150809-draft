# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/acctail/acctail-2.0.ebuild,v 1.3 2009/09/23 21:05:44 patrick Exp $

inherit eutils toolchain-funcs
DESCRIPTION="shows all processes as they exit, along with the accounting information"
HOMEPAGE="http://www.vanheusden.com/acctail/"
SRC_URI="${HOMEPAGE}${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
DEPEND="sys-process/acct"

src_unpack() {
	unpack ${A}
	sed -i '/^CPPFLAGS+=/s:-O2::' "${S}"/Makefile || die "sed Makefile failed"
}

src_compile() {
	tc-export CC LD AR
	emake CC="${CC}" LD="${LD}" AR="${AR}" CFLAGS="${CFLAGS} -Wall" || die
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
