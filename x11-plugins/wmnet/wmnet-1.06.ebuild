# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnet/wmnet-1.06.ebuild,v 1.16 2005/01/26 13:40:22 s4t4n Exp $

inherit eutils

IUSE=""
DESCRIPTION="WMnet is a dock.app network monitor"
SRC_URI="http://www.digitalkaos.net/linux/wmnet/download/${P}.tar.gz"
HOMEPAGE="http://www.digitalkaos.net/linux/wmnet/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha amd64 ppc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-nonx86.patch
}

src_compile() {
	xmkmf || die "xmkmf failed"

	emake CDEBUGFLAGS="${CFLAGS}" || die "parallel make failed"
}

src_install() {
	dobin wmnet
	dohtml wmnet.1x.html
	newman wmnet.man wmnet.1
	dodoc README Changelog
}
