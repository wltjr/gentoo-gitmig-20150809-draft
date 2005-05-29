# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.98.ebuild,v 1.7 2005/05/29 16:10:03 corsair Exp $

inherit perl-module

MY_P=${PN}ron-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
SRC_URI="mirror://cpan/authors/id/P/PA/PAVELH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pavelh/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ~ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND="${DEPEND}
	app-text/sablotron"

myconf="SABLOTLIBPATH=/usr/lib SABLOTINCPATH=/usr/include"
