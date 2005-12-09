# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/amyedit/amyedit-0.9.ebuild,v 1.6 2005/12/09 03:20:02 tsunam Exp $

inherit eutils

DESCRIPTION=" AmyEdit is a LaTeX editor"
HOMEPAGE="http://amyedit.sf.net"
SRC_URI="mirror://sourceforge/amyedit/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND=">=dev-cpp/gtkmm-2.4.8
	>=x11-libs/gtksourceview-1.0
	app-text/aspell"

src_install() {
	einstall
	dodoc Changelog README TODO || die
}
