# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.1-r2.ebuild,v 1.2 2001/10/07 22:15:58 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The GNOME control-center"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext ) 
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/gnome-vfs-1.0.2-r1
        >=media-libs/gdk-pixbuf-0.11.0-r1"

RDEPEND=">=gnome-base/gnome-vfs-1.0.2-r1
         >=media-libs/gdk-pixbuf-0.11.0-r1"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    ${myconf} || die

	emake || die
}

src_install() {                               
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}






