# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/espresso-ab/espresso-ab-1.0.ebuild,v 1.1 2004/12/27 18:59:35 ribosome Exp $

IUSE=""

DESCRIPTION="POSIX compliant version of the espresso logic minimization tool"
HOMEPAGE="http://www.cs.man.ac.uk/apt/projects/balsa/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/balsa/other-software/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"

DEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall || die "make install failed"

	dodoc COPYING README
}

