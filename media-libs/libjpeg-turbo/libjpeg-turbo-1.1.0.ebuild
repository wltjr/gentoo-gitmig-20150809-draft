# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjpeg-turbo/libjpeg-turbo-1.1.0.ebuild,v 1.5 2011/03/27 19:26:17 angelos Exp $

EAPI=3
inherit libtool toolchain-funcs

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="http://libjpeg-turbo.virtualgl.org/ http://sourceforge.net/projects/libjpeg-turbo/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://debian/pool/main/libj/libjpeg8/libjpeg8_8c-1.debian.tar.gz"

LICENSE="as-is LGPL-2.1 wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND="!media-libs/jpeg:0"
DEPEND="${RDEPEND}
	dev-lang/nasm"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--with-jpeg8
}

src_compile() {
	emake || die

	cd ../debian/extra || die
	emake CC="$(tc-getCC)" CFLAGS="${LDFLAGS} ${CFLAGS}" || die
}

src_test() {
	emake test || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUILDING.txt ChangeLog.txt example.c README-turbo.txt
	find "${D}" -name '*.la' -exec rm -f {} +

	cd ../debian/extra || die
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" \
		INSTALL="install -m755" INSTALLDIR="install -d -m755" \
		install || die
}
