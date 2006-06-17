# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-1.0.3.ebuild,v 1.20 2006/06/17 05:12:03 mr_bones_ Exp $

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc sparc arm"
IUSE=""

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=media-libs/freetype-2.0.1
	>=dev-libs/libxml-1.8
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=dev-libs/popt-1.5"


src_compile() {

	./configure --host=${CHOST} 					\
		    --prefix=/usr	 				\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib || die

	emake || die

}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README*
}
