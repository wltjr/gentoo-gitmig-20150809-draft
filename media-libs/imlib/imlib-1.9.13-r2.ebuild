# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.13-r2.ebuild,v 1.2 2002/05/23 06:50:13 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Imlib is a general Image loading and rendering library."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
	 http://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz
	 ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	>=media-libs/tiff-3.5.5
	gif? ( >=media-libs/giflib-4.1.0 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b )"

src_compile() {
	
	#update libtool to fix "relink" bug
	libtoolize --copy --force

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc/imlib || die
		
	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		sysconfdir=${D}/etc/imlib \
		install || die

	preplib /usr

	dodoc AUTHORS COPYING* ChangeLog README
	dodoc NEWS
	dohtml -r doc
}

