# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-1.0_pre1.ebuild,v 1.1 2001/11/11 12:10:24 azarah Exp $

MY_P="${PN}-`echo ${PV} |sed -e 's:_:-:'`"
S=${WORKDIR}/${MY_P}
DESCRIPTION="CD ripping/mastering"
SRC_URI="http://ogre.rocky-road.net/files/${MY_P}.tar.bz2"
HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"

#todo: add blade encoder
DEPEND="sys-devel/gcc media-sound/mad app-cdr/cdrtools app-cdr/cdrdao 
	media-sound/cdparanoia media-sound/lame media-libs/libogg
	media-sound/mpg123 virtual/x11 >=x11-libs/gtk+-1.2.10-r4 \
	dev-libs/glib media-libs/libvorbis
	media-libs/libao"
		
RDEPEND="media-sound/mad app-cdr/cdrtools app-cdr/cdrdao 
	media-sound/cdparanoia media-sound/lame media-libs/libogg
	media-sound/mpg123 virtual/x11 >=x11-libs/gtk+-1.2.10-r4 \
	dev-libs/glib media-libs/libvorbis
	media-libs/libao"


src_compile() {

	cp src/main.c src/main.c.orig
	sed -e 's:/usr/local/share:/usr/share:g' \
		src/main.c.orig >src/main.c || die

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		|| die
    
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die


	# Add the Gnome menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/simplecdrx.png
		insinto /usr/share/gnome/apps/Applications/
		doins ${FILESDIR}/simplecdrx.desktop
	fi

	doman man/simplecdr-x.1

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}

