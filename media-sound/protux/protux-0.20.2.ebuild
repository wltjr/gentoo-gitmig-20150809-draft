# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/protux/protux-0.20.2.ebuild,v 1.2 2004/07/13 05:36:55 eradicator Exp $

inherit kde-functions

DESCRIPTION="Professional Audio Tools for GNU/Linux"
HOMEPAGE="http://www.nongnu.org/protux"
SRC_URI="http://vt.shuis.tudelft.nl/~remon/protux/stable/version-${PV}/${P}.tar.gz"

IUSE="static"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="virtual/x11
	>=x11-libs/qt-3
	>=media-libs/libmustux-0.20.2"

set-qtdir 3

src_compile() {
	export QT_MOC=${QTDIR}/bin/moc
	local myconf
	myconf="--with-gnu-ld"
	use static || myconf="${myconf} --enable-static=no"
	econf ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYRIGHT ChangeLog FAQ README TODO
}
