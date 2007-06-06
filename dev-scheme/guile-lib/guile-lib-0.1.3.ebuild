# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-lib/guile-lib-0.1.3.ebuild,v 1.1 2007/06/06 23:03:03 dberkholz Exp $

inherit eutils

DESCRIPTION="An accumulation place for pure-scheme Guile modules"
HOMEPAGE="home.gna.org/guile-lib/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND}"

pkg_setup() {
	built_with_use dev-scheme/guile regex deprecated || die "guile must be built with USE='regex deprecated'"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"
}
