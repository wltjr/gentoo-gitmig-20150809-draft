# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guarddog/guarddog-1.9.15.ebuild,v 1.7 2003/02/13 14:51:49 vapier Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A firewall configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"

newdepend ">=sys-apps/iptables-1.2.5"

