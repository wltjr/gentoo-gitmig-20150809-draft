# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ethtool/ethtool-1.8.ebuild,v 1.1 2004/03/10 23:03:02 agriffis Exp $

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="http://sourceforge.net/projects/gkernel/"
SRC_URI="mirror://sourceforge/gkernel/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~alpha ~sparc ~ppc ~hppa ~ia64"

IUSE=""

src_install() {
	einstall || die
	dodoc NEWS README INSTALL
}
