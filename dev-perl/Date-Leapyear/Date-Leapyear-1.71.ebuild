# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.71.ebuild,v 1.17 2006/02/13 11:11:41 mcummings Exp $

inherit perl-module

DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/perl-Test-Simple
		virtual/perl-Test-Harness"
