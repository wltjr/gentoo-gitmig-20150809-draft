# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-2.1.3.ebuild,v 1.8 2008/02/10 09:43:50 dertobi123 Exp $

inherit eutils

DESCRIPTION="a portable programmer's library designed to allow a developer to create robust portable software."
HOMEPAGE="http://www.s-lang.org"
SRC_URI="ftp://ftp.fu-berlin.de/pub/unix/misc/slang/v${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="pcre png"

RDEPEND="pcre? ( dev-libs/libpcre )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	!=sys-libs/slang-2.1.2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.1.2-slsh-libs.patch
}

src_compile() {
	econf $(use_with pcre) $(use_with png)
	emake all || die "emake all failed."
	cd slsh
	emake slsh || die "emake slsh failed."
}

src_install() {
	emake -j1 DESTDIR="${D}" install install-static || die "emake install failed."

	rm -rf "${D}"/usr/share/doc/{slang,slsh}

	dodoc NEWS README *.txt doc/{,internal,text}/*.txt
	dohtml doc/slangdoc.html slsh/doc/html/*.html
}
