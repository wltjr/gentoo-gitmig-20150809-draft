# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Tar/Archive-Tar-0.22.ebuild,v 1.5 2003/06/21 21:36:35 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}

DESCRIPTION="A Perl module for creation and manipulation of tar files"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/SRZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Archive/SRZ/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
