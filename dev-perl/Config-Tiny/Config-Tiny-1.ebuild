# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Tiny/Config-Tiny-1.ebuild,v 1.2 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="No description available."
SRC_URI="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

DEPEND="dev-perl/Test-Simple"

