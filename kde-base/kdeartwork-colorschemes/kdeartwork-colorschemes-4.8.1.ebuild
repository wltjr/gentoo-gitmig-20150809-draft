# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-colorschemes/kdeartwork-colorschemes-4.8.1.ebuild,v 1.1 2012/03/06 23:35:13 dilfridge Exp $

EAPI=4

KMNAME="kdeartwork"
KMMODULE="ColorSchemes"
inherit kde4-meta

DESCRIPTION="KDE extra colorschemes"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

# Moved here in 4.7
add_blocker kdeaccessibility-colorschemes
