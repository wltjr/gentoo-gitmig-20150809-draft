# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.2.ebuild,v 1.2 2005/04/16 15:02:04 hansmi Exp $

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~x86 ~sparc ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-libs/glib-2.2.3
	sys-apps/tcp-wrappers"

IUSE=""

src_install () {
	einstall
	insinto /etc
	doins ser2net.conf
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
}
