# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-0.20.ebuild,v 1.3 2004/02/22 20:42:08 agriffis Exp $

inherit perl-module

MY_P=File-Remove${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Remove files and directories"
SRC_URI="http://www.cpan.org/modules/by-authors/id/G/GA/GABOR/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/G/GA/GABOR/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~alpha ~hppa ~mips ~ppc ~sparc"

