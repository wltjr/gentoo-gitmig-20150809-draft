# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/euses/euses-2.5.0_pre1.ebuild,v 1.2 2006/11/08 01:49:55 jer Exp $

WANT_AUTOMAKE="1.9"

inherit toolchain-funcs autotools

DESCRIPTION="A small utility in C that quickly displays USE and LANG flag descriptions"
HOMEPAGE="http://www.xs4all.nl/~rooversj/gentoo"
SRC_URI="http://www.xs4all.nl/~rooversj/gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="sys-devel/autoconf
	sys-devel/autoconf-wrapper"

S="${WORKDIR}"

src_compile() {
	eautoreconf
	econf || die
	emake || die
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1 || die
	dodoc Changelog ${PN}.php || die
}
