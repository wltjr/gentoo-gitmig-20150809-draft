# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <lewis@sistina.com>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="http://prdownloads.sourceforge.net/cscope/${A}"
HOMEPAGE="http://cscope.sourceforge.net"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"
DEPEND="$RDEPEND sys-devel/flex"
src_compile() {                           
   try ./configure --prefix=/usr/ --mandir=/usr/share/man --infodir=/usr/share/info
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    try make prefix=${D}/usr/ mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*
}




