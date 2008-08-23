# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.24.ebuild,v 1.1 2008/08/23 18:06:58 tove Exp $

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Exception::Class module for perl"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

SRC_TEST="do"

RDEPEND=">=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.12
	dev-lang/perl"

DEPEND="${RDEPEND}
	>=dev-perl/module-build-0.28
	test? ( dev-perl/Test-Pod )"

export OPTIMIZE="$CFLAGS"
