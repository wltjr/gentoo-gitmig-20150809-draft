# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PadWalker/PadWalker-1.7.ebuild,v 1.1 2008/10/05 14:35:55 tove Exp $

MODULE_AUTHOR=ROBIN
inherit perl-module

DESCRIPTION="play with other peoples' lexical variables"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
