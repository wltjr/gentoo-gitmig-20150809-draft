# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdiff3/kdiff3-0.9.82.ebuild,v 1.2 2004/02/15 12:06:12 dholm Exp $

inherit kde
need-kde 3

DESCRIPTION="KDE-based frontend to diff3"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"
HOMEPAGE="http://kdiff3.sourceforge.net/"

KEYWORDS="~x86 amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="nomirror"

RDEPEND="$RDEPEND sys-apps/diffutils"
