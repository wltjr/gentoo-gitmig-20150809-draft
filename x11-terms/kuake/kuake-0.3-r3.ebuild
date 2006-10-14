# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/kuake/kuake-0.3-r3.ebuild,v 1.7 2006/10/14 11:24:55 flameeyes Exp $

inherit kde eutils

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="2.1"

ARTS_REQUIRED="never"

DESCRIPTION="A Quake-style terminal emulator."
HOMEPAGE="http://www.nemohackers.org/kuake.php"
SRC_URI="http://199.231.140.154/software/${PN}/${P}.tar.gz
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="arts"

DEPEND="|| ( kde-base/konsole kde-base/kdebase )"

need-kde 3.3

PATCHES="${FILESDIR}/${P}-dropdown-fix.patch
	${FILESDIR}/${P}-alignment-fix.patch"
