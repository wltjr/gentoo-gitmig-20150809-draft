# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.34.ebuild,v 1.2 2001/12/17 16:53:48 azarah Exp $


S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	 >=gnome-base/libglade-0.17-r1
	 >=media-libs/freetype-2.0.1"

DEPEND="${RDEPEND}
	sys-devel/gettext
        sys-devel/perl
	tex? ( app-text/tetex )
        >=app-text/ghostscript-6.50-r2"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc 					\
		    --localstatedir=/var/lib
	assert

	emake || die
}

src_install() {
	make DESTDIR=${D} 						\
		sysconfdir=${D}/etc					\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
