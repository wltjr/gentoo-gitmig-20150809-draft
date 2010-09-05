# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cuegen/cuegen-1.2.0.ebuild,v 1.3 2010/09/05 11:08:15 sbriesen Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="CUEgen is a FLAC-compatible cuesheet generator for Linux"
HOMEPAGE="http://www.cs.man.ac.uk/~slavinp/cuegen.html"
SRC_URI="http://www.cs.man.ac.uk/~slavinp/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e 's:\(\${CFLAGS}\):\1 \${LDFLAGS}:g' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin cuegen || die "install failed"
	dodoc README
}
