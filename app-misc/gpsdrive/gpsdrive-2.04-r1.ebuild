# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.04-r1.ebuild,v 1.1 2003/12/30 06:51:52 latexer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="displays GPS position on a map"
HOMEPAGE="http://gpsdrive.kraftvoll.at"
SRC_URI="http://gpsdrive.kraftvoll.at/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="nls"
DEPEND="sys-devel/gettext
	>=x11-libs/gtk+-2.0
	>=dev-libs/libpcre-4.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	# allow higher serial port speeds, Mina Naguib <webmaster@topfx.com>
	epatch ${FILESDIR}/gpsd.higher_serial_speeds.patch
}

src_compile() {
	econf `use_enable nls`
	emake || die "compile failed"

}

src_install() {
	make DESTDIR=${D} install || die
}
