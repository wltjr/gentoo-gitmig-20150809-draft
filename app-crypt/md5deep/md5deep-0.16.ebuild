# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md5deep/md5deep-0.16.ebuild,v 1.6 2004/06/24 21:34:32 agriffis Exp $

DESCRIPTION="Expanded md5sum program that has recursive and comparison options"
HOMEPAGE="http://md5deep.sourceforge.net"
SRC_URI="http://md5deep.sourceforge.net/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""

DEPEND=""

src_unpack () {
	unpack ${A} ; cd ${S}
	patch ${S}/md5deep.c ${FILESDIR}/md5deep-0.16-gentoo.diff
}

src_compile () {
	make CFLAGS="${CFLAGS}" linux || die
}

src_install() {
	dobin md5deep || die
	dodoc README CHANGES TODO
	doman md5deep.1
}
