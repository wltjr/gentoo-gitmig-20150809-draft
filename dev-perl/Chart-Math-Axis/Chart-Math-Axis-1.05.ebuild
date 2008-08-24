# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-1.05.ebuild,v 1.1 2008/08/24 07:23:41 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Implements an algorithm to find good values for chart axis"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Math-BigInt-1.70
	>=virtual/perl-Storable-2.12
	>=dev-perl/Params-Util-0.15
	dev-lang/perl"
