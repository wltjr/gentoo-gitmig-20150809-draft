# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.20.ebuild,v 1.3 2004/05/07 18:49:31 gustavoz Exp $

inherit perl-module

DESCRIPTION="A date and time object"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND=">=dev-perl/Params-Validate-0.72
		dev-perl/Time-Local
		dev-perl/DateTime-TimeZone
		dev-perl/DateTime-Locale
		dev-perl/Class-Factory-Util"

