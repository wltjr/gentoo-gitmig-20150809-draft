# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/splat/splat-0.08.ebuild,v 1.6 2004/07/17 16:11:48 tgall Exp $

DESCRIPTION="Simple Portage Log Analyzer Tool"
SRC_URI="http://www.l8nite.net/projects/splat/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.l8nite.net/projects/splat/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc macos ppc64"
IUSE=""
DEPEND="dev-lang/perl"

src_install() {
	newbin splat.pl splat
	dodoc COPYING ChangeLog
}
