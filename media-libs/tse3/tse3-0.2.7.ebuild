# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tse3/tse3-0.2.7.ebuild,v 1.9 2004/07/13 06:10:55 eradicator Exp $

IUSE="alsa oss arts"

inherit eutils

DESCRIPTION="TSE3 Sequencer library"
HOMEPAGE="http://TSE3.sourceforge.net/"
SRC_URI="mirror://sourceforge/tse3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

DEPEND="alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# size_t patch for 64bit machines
	epatch ${FILESDIR}/${P}-size_t-64bit.patch
}

src_compile() {
	local myconf=""

	use arts || myconf="$myconf --without-arts"
	use alsa || myconf="$myconf --without-alsa"
	use oss || myconf="$myconf --without-oss"
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
	$myconf || die "./configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO Version
}
