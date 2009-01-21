# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.34.ebuild,v 1.2 2009/01/21 15:49:06 fmccor Exp $

IUSE=""

DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/type/#t1utils"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/libc"

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS README
}
