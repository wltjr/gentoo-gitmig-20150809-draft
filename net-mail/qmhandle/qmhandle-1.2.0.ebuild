# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmhandle/qmhandle-1.2.0.ebuild,v 1.1 2004/12/08 01:12:44 robbat2 Exp $

inherit eutils

DESCRIPTION="Qmail message queue tool"
HOMEPAGE="http://qmhandle.sf.net/"
SRC_URI="mirror://sourceforge/qmhandle/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~hppa ~ppc ~sparc ~amd64 ~ia64"
# Should run on all platforms without issue
IUSE=""
RDEPEND="|| ( mail-mta/qmail mail-mta/qmail-mysql mail-mta/qmail-ldap )
		dev-lang/perl
		sys-apps/psmisc"
DEPEND=""
S=${WORKDIR}


src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/qmHandle-gentoo.patch
}

src_compile() {
	einfo "Nothing to compile :-)"
}

src_install() {
	into /usr
	dodoc README HISTORY
	dobin qmHandle
}
