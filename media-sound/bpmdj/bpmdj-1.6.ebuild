# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdj/bpmdj-1.6.ebuild,v 1.2 2003/07/14 18:18:26 pvdabeel Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Bpmdj, software for measuring the BPM of music and mixing"
HOMEPAGE="http://bpmdj.strokemusic.org"

SRC_URI="ftp://progpc26.vub.ac.be/pub/bpmdj/1.6/bpmdj-1.6.source.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

DEPEND="x11-libs/qt*"

RDEPEND="mpg123"

src_compile() {
	cp defines.gentoo defines
	make || die
}

src_install () {
	make DESTDIR=${D} deb-install || die
}
