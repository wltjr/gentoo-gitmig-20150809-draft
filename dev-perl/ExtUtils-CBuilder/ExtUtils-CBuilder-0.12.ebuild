# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-CBuilder/ExtUtils-CBuilder-0.12.ebuild,v 1.8 2006/03/03 20:36:41 chriswhite Exp $

inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"
HOMEPAGE="http://search.cpan.org/~kwilliams/ExtUtils-CBuilder-0.12/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/module-build"
