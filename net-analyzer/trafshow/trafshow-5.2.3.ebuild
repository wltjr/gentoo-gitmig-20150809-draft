# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafshow/trafshow-5.2.3.ebuild,v 1.1 2006/03/21 23:16:10 jokey Exp $

inherit eutils gnuconfig

DESCRIPTION="Full screen visualization of the network traffic"
HOMEPAGE="http://soft.risp.ru/trafshow/index_en.shtml"
SRC_URI="ftp://ftp.nsk.su/pub/RinetSoftware/${P}.tgz"
LICENSE="as-is"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="slang"

DEPEND="net-libs/libpcap
	sys-libs/ncurses
	slang? ( >=sys-libs/slang-1.4.2 )"

src_unpack() {
	unpack ${A}; cd "${S}"
	epatch "${FILESDIR}/${PN}-5.2.1-gentoo.patch"
	use ppc64 && gnuconfig_update
}

src_compile() {
	if ! use slang; then
		# No command-line option so pre-cache instead
		export ac_cv_have_curses=ncurses
		export LIBS=-lncurses
	fi

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
