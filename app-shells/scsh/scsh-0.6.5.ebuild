# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/scsh/scsh-0.6.5.ebuild,v 1.3 2004/06/29 03:59:24 vapier Exp $

DESCRIPTION="Unix shell embedded in Scheme"
HOMEPAGE="http://www.scsh.net/"
SRC_URI="ftp://ftp.scsh.net/pub/scsh/0.6/${P}.tar.gz"

LICENSE="as-is | BSD | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND=""

src_compile() {
	econf --prefix=/usr	--libdir=/usr/lib --includedir=/usr/include || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc RELEASE
	# Let Scsh install the documentation and then clean up afterwards
	dosed "s:${D}::" /usr/share/man/man1/scsh.1
	dodir /usr/share/doc/${PF}
	mv ${D}/usr/lib/scsh/doc/* ${D}/usr/share/doc/${PF}
	rmdir ${D}/usr/lib/scsh/doc
}
