# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kspaceduel/kspaceduel-4.14.3.ebuild,v 1.1 2015/06/04 18:44:49 kensington Exp $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE Space Game"
HOMEPAGE="
	http://www.kde.org/applications/games/kspaceduel/
	http://games.kde.org/game.php?game=kspaceduel
"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdeapps_dep libkdegames)"
RDEPEND="${DEPEND}"
