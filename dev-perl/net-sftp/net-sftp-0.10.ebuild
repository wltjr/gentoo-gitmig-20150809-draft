# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-sftp/net-sftp-0.10.ebuild,v 1.2 2006/01/13 22:05:54 mcummings Exp $

inherit perl-module

MY_P=Net-SFTP-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure File Transfer Protocol client"
HOMEPAGE="http://search.cpan.org/~drolsky/${MY_P}"
SRC_URI="mirror://cpan/authors/id/D/DB/DBROBINS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~mips ~ppc ~sparc x86"
IUSE=""

DEPEND=">=dev-perl/net-ssh-perl-1.25"
