# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/flwm/flwm-1.00.ebuild,v 1.1 2001/06/22 00:37:02 tadpol Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
SRC_URI="http://flwm.sourceforge.net/${A}"
HOMEPAGE="http://flwm.sourceforge.net"
DESCRIPTION="A lightweight window manager based on fltk"

DEPEND=">=x11-base/xfree-4.0.1
	>=x11-libs/fltk-1.0.11
"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install() {
    doman flwm.1
    dodoc README flwm_wmconfig
    into /usr/X11R6
    dobin flwm
}
