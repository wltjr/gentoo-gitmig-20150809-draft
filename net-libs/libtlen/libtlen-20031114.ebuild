# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libtlen/libtlen-20031114.ebuild,v 1.3 2004/02/22 23:06:49 agriffis Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Support library for Tlen IMS"
HOMEPAGE="http://libtlen.eu.org/"
SRC_URI="http://libtlen.eu.org/snapshots/archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND="virtual/glibc"

src_compile() {
	econf \
		--enable-shared || die
	emake CFLAGS="${CFLAGS}" all || die
}

src_install() {
	einstall || die
	dodoc ChangeLog
}
