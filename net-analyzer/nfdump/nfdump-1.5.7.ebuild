# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nfdump/nfdump-1.5.7.ebuild,v 1.1 2008/11/01 01:04:57 robbat2 Exp $

inherit eutils

DESCRIPTION="A set of tools to collect and process netflow data"
HOMEPAGE="http://nfdump.sourceforge.net/"
SRC_URI="mirror://sourceforge/nfdump/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_compile() {
	econf || die "econf failed"
	# Parallel make issue, see bug #240746
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
