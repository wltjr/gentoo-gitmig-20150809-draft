# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.3.5.ebuild,v 1.1 2002/10/15 03:49:56 vapier Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
http://130.239.134.83/waimea/files/unstable/source/${P}.tar.gz"
HOMEPAGE="http://waimea.sf.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~sparc64"

DEPEND="virtual/x11 media-libs/imlib2"
	
RDEPEND="${DEPEND}"
PROVIDE="virtual/blackbox"

src_compile() {
	econf || die "configure failure whine whine"
	emake || die "make died, that sux0rs"
}

src_install() {
	make \
		prefix=${D}/usr \
		sysconfdir=${D}/etc/X11/waimea \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		install || die "make install died"

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	dodir /etc/X11/Sessions
	echo "/usr/bin/waimea" > ${D}/etc/X11/Sessions/waimea
	chmod +x ${D}/etc/X11/Sessions/waimea
}

pkg_postinst() {
	einfo "unfortunately the older version of this package broke the"
	einfo "/etc/skel/.waimearc and made it a directory, please remove"
	einfo "this if you want the package to install perfectly"
	einfo "copy /etc/skel/.waimearc to your homedir:"
	einfo "  cp -a /etc/skel/.waimearc $HOME"
}
