# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Cache/Cache-Cache-1.01.ebuild,v 1.6 2003/06/21 21:36:35 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Class-Container module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DC/DCLINTON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/D/DC/DCLINTON/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/Digest-SHA1-2.01
	>=dev-perl/Error-0.15
	>=dev-perl/Storable-1.0.14
	>=dev-perl/IPC-ShareLite-0.08"

export OPTIMIZE="$CFLAGS"
