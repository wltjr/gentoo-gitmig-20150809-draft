# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.19.ebuild,v 1.5 2000/10/23 11:27:15 achim Exp $

P=esound-0.2.19
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="esound"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/esound/"${A}
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"


src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr \
		  --sysconfdir=/etc/esd --with-libwrap
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr sysconfdir=${D}/etc/esd install
  dodoc AUTHORS COPYING* ChangeLog README TODO
  dodoc NEWS TIPS
  dodoc docs/esound.ps
  docinto html
  dodoc docs/html/*.html docs/html/*.css
  docinto html/stylesheet-images
  dodoc docs/html/stylesheet-images/*.gif
}





