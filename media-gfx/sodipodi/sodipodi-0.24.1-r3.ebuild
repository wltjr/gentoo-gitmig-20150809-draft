# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.24.1-r3.ebuild,v 1.1 2002/01/15 06:34:26 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="http://prdownloads.sourceforge.net/${PN}/${A}"
HOMEPAGE="http://sodipodi.sourceforge.net/"

RDEPEND=">=gnome-base/gnome-print-0.30
         >=gnome-extra/gal-0.13-r1
	 bonobo? ( >=gnome-base/bonobo-1.0.9 )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-compile.patch
	automake
}

src_compile() {
	local myconf

	myconf=""

	# Bonobo support doesn't seem to work.
	if [ "`use bonobo`" ] ; then
		myconf="$myconf --with-bonobo"
	else
		myconf="$myconf --without-bonobo"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="$myconf --disable-nls"
	fi

	CFLAGS="${CFLAGS} `gnome-config --cflags gdk_pixbuf`"

	./configure 	--host=${CHOST} \
		    	--prefix=/usr \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--sysconfdir=/etc \
			--enable-gnome \
			--enable-gnome-print \
			${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
