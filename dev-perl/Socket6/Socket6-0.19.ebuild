# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.19.ebuild,v 1.2 2006/01/27 21:36:44 hansmi Exp $

inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"
SRC_URI="mirror://cpan/authors/id/U/UM/UMEMOTO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/UMEMOTO/${P}/"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"

SRC_TEST="do"
