# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.1.9.ebuild,v 1.3 2000/09/15 16:18:48 drobbins Exp $

P=audiofile-0.1.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An elegant API for accessing audio files"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/audiofile/"${A}
HOMEPAGE="http://www.68k.org./~michael/audiofile/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc ACKNOWLEDGEMENTS AUTHORS COPYING* ChangeLog README TODO
  dodoc NEWS NOTES
}






