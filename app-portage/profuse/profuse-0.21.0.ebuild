# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/profuse/profuse-0.21.0.ebuild,v 1.5 2005/07/09 02:35:44 swegener Exp $

DESCRIPTION="use flags and profile gtk2 editor, with good features and 3 GUIs."
HOMEPAGE="http://libconf.net/profuse/"
SRC_URI="http://libconf.net/profuse/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="gtk ncurses"

RDEPEND="dev-lang/perl
>=dev-util/dialog-1.0.20050206
dev-perl/TermReadKey
>=dev-util/libconf-0.39.16
gtk? ( >=dev-perl/gtk2-fu-0.07 )
ncurses? ( dev-perl/Curses-UI )"

src_install() {
	make install PREFIX="${D}"/usr || die "make install failed"
}
