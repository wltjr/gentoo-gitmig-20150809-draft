# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwox/netwox-5.28.0.ebuild,v 1.1 2005/01/13 05:51:50 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="Toolbox of over 400 utilities for testing Ethernet/IP networks"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwox/"
SRC_URI="http://www.laurentconstantin.com/common/netw/${PN}/download/v${PV/.*}/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="~net-libs/netwib-${PV}"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}/src

	sed -i \
		-e 's:/usr/local:/usr:g' \
		-e "s:-O2:${CFLAGS}:" \
		genemake config.dat
}

src_compile() {
	cd src
	./genemake NETWOXDEF_PROGCC=$(tc-getCC) || die "problem creating Makefile"
	emake -j1 CC=$(tc-getCC) || die "compile problem"
}

src_install() {
	dodoc README.TXT doc/*.txt
	cd src
	make install CC=$(tc-getCC) DESTDIR=${D} || die
}
