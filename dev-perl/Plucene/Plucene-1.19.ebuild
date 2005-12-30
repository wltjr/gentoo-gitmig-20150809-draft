# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Plucene/Plucene-1.19.ebuild,v 1.10 2005/12/30 11:11:15 mcummings Exp $

inherit perl-module

DESCRIPTION="Plucene - the Perl lucene port"
HOMEPAGE="http://search.cpan.org/~simon/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SI/SIMON/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-lang/perl-5.8.4
		dev-perl/module-build
		perl-core/Memoize
		dev-perl/Tie-Array-Sorted
		dev-perl/Encode-compat
		dev-perl/File-Slurp
		dev-perl/Class-Virtual
		dev-perl/Class-Accessor
		dev-perl/Time-Piece
		>=perl-core/Test-Harness-2.30
		>=perl-core/Scalar-List-Utils-1.13
		dev-perl/Lingua-Stem
		dev-perl/Bit-Vector-Minimal
		dev-perl/IO-stringy"
