# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/pipebench/pipebench-0.40.ebuild,v 1.9 2008/03/27 15:56:38 corsair Exp $

DESCRIPTION="Measures the speed of stdin/stdout communication"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=pipebench"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}" || die "Manual configure failed"
	cp Makefile Makefile.orig
	sed \
		-e "s:CFLAGS=-Wall:CFLAGS=${CFLAGS} -Wall:" \
		-e "s:/usr/local/bin/:${D}/usr/bin:" \
		-e "s:/usr/local/man/man1/:${D}/usr/share/man/man1:" \
		Makefile.orig > Makefile
}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/{bin,share/man/man1}
	make install || die
	dodoc README
}
