# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Filter-BufferText/XML-Filter-BufferText-1.01.ebuild,v 1.5 2004/07/08 23:38:46 kloeri Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Filter to put all characters() in one event"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RB/RBERJON/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rberjon/${P}"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc ~sparc alpha ~mips"

DEPEND="${DEPEND}
		dev-perl/XML-SAX-Base
		>=dev-perl/XML-SAX-0.12"

