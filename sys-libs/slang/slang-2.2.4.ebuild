# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-2.2.4.ebuild,v 1.7 2012/02/14 21:24:41 jer Exp $

EAPI=4
inherit eutils

DESCRIPTION="A multi-platform programmer's library designed to allow a developer to create robust software"
HOMEPAGE="http://www.jedsoft.org/slang/"
SRC_URI="mirror://slang/v${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="cjk pcre png readline static-libs zlib"

# ncurses for ncurses5-config to get terminfo directory
RDEPEND="sys-libs/ncurses
	pcre? ( dev-libs/libpcre )
	png? ( >=media-libs/libpng-1.4 )
	cjk? ( dev-libs/oniguruma )
	readline? ( sys-libs/readline )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2.3-slsh-libs.patch

	# avoid linking to -ltermcap race with some systems
	sed -i -e '/^TERMCAP=/s:=.*:=:' configure || die
}

src_configure() {
	local myconf=slang
	use readline && myconf=gnu

	econf \
		--with-readline=${myconf} \
		$(use_with pcre) \
		$(use_with cjk onig) \
		$(use_with png) \
		$(use_with zlib z)
}

src_compile() {
	emake elf $(use static-libs && echo static)

	pushd slsh >/dev/null
	emake slsh
	popd
}

src_install() {
	emake DESTDIR="${D}" install-elf $(use static-libs && echo install-static)

	rm -rf "${D}"/usr/share/doc/{slang,slsh}

	dodoc NEWS README *.txt doc/{,internal,text}/*.txt
	dohtml doc/slangdoc.html slsh/doc/html/*.html
}
