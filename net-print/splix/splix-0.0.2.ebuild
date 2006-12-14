# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/splix/splix-0.0.2.ebuild,v 1.1 2006/12/14 21:29:13 wschlich Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A set of CUPS printer drivers for SPL (Samsung Printer Language) printers"
HOMEPAGE="http://splix.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/fixMakefile.patch
}

src_compile() {
	emake CXX="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	CUPSFILTERDIR="$(cups-config --serverbin)/filter"
	CUPSPPDDIR="$(cups-config --datadir)/model"

	dodir "${CUPSFILTERDIR}"
	dodir "${CUPSPPDDIR}"
	emake DESTDIR="${D}" install || die "emake install failed"
}
