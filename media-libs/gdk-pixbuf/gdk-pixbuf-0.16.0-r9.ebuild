# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.16.0-r9.ebuild,v 1.2 2002/05/21 18:14:10 danarmak Exp $

#provide Xmake and Xemake

inherit virtualx

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"

DEPEND="media-libs/jpeg
	media-libs/tiff
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/libpng-1.2.1
	>=gnome-base/gnome-libs-1.4.1.2-r1"
# We need gnome-libs here, else gnome support do not get compiled into
# gdk-pixbuf (the GnomeCanvasPixbuf library )

src_unpack() {

	unpack ${A}

	cp ${S}/demo/Makefile.in ${S}/demo/Makefile.in.orig
	sed -e 's:LDADD = :LDADD = $(LIBJPEG) $(LIBTIFF) $(LIBPNG) :' \
		${S}/demo/Makefile.in.orig > ${S}/demo/Makefile.in
}

src_compile() {

	#update libtool, else we get the "relink bug"
	libtoolize --copy --force

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/X11/gdk-pixbuf || die

	#build needs to be able to
	#connect to an X display.
	Xemake || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/gdk-pixbuf \
		install || die

	#fix permissions on the loaders
	chmod a+rx ${D}/usr/lib/gdk-pixbuf/loaders
	chmod a+r ${D}/usr/lib/gdk-pixbuf/loaders/*

	dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}

