# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gradio/gradio-1.0.1.ebuild,v 1.11 2004/07/13 07:26:32 eradicator Exp $

IUSE=""

DESCRIPTION="GTK based app for radio tuner cards"
SRC_URI="ftp://ftp.foobazco.org/pub/gradio/${P}.tar.gz"
HOMEPAGE="http://foobazco.org/projects/gradio/"

SLOT="0"
LICENSE="GPL-2"
# ~sparc, ~amd64: 1.0.1: Compiles cleanly and appears to work, but I don't have
# a radio device to test.  Therefore, it will remain in ~arch until I get
# positive user feedback on these archs.  Please email me if you have
# success.  -- eradicator

KEYWORDS="x86 ~sparc ~amd64"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 || die

	dodoc Changes COPYING README
}
