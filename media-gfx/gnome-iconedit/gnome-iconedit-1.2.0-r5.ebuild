# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-iconedit/gnome-iconedit-1.2.0-r5.ebuild,v 1.1 2002/05/02 04:28:47 mkennedy Exp $

LICENSE="GPL-2"

S=${WORKDIR}/${P}
DESCRIPTION="Edits icons, what more can you say?"
SRC_URI="http://210.77.60.218/ftp/ftp.debian.org/pool/main/g/gnome-iconedit/gnome-iconedit_${PV}.orig.tar.gz"
HOMEPAGE="www.advogato.org/proj/GNOME-Iconedit/"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/gdk-pixbuf-0.11.0-r1
	media-libs/libpng
	gnome-base/ORBit"
# Gnome-Print support is broken
#	>=gnome-base/gnome-print-0.30
# Bonobo support is broken
#	bonobo? ( gnome-base/bonobo )"



src_unpack() {

	unpack ${A}

	# Fix some compile / #include errors
	cd ${S}
	patch -p1 <${FILESDIR}/gnome-iconedit.diff || die

	# Update the Makefiles.
	export WANT_AUTOMAKE_1_4=1
	export WANT_AUTOCONF_2_1=1
	automake --add-missing
	autoconf
}

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
	
	CFLAGS="${CFLAGS} `gnome-config --cflags print` -I/usr/include/gdk-pixbuf-1.0"	

	./configure --host=${CHOST} 					\
		--prefix=/usr					\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info				\
		--with-sysconfdir=/etc				\
		--without-gnome-print				\
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
		mandir=${D}/usr/share/man					\
		infodir=${D}/usr/share/info				\
		sysconfdir=${D}/etc install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
