# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-mitm/doom3-mitm-20070129.ebuild,v 1.1 2009/10/07 20:40:02 nyhm Exp $

EAPI=2

MOD_DESC="Single player maps"
MOD_NAME="Make it to Morning"

inherit eutils games games-mods

HOMEPAGE="http://www.makeittomorning.co.uk/"
SRC_URI="http://www.doomwadstation.com/doom3/maps/Morning/mitm_4.zip
	http://www.doomwadstation.com/doom3/maps/Morning/mitm5.zip"

LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="games-fps/doom3-roe
	games-fps/doom3[opengl,roe]"

src_unpack() {
	mkdir mitm
	cd mitm
	unpack ${A}
}

src_prepare() {
	cd mitm
	mv -f MITM*.txt mitm.txt || die
	mv -f Mitm5*.txt mitm5.txt || die
}

src_install() {
	games-mods_src_install
	games_make_wrapper ${PN} \
		"doom3 +set fs_game_base d3xp +set fs_game mitm +map mitm"
	make_desktop_entry ${PN} "Doom 3 - ${MOD_NAME} (1)" doom3
	local i
	for i in {2..5} ; do
		games_make_wrapper ${PN}${i} \
			"doom3 +set fs_game_base d3xp +set fs_game mitm +map mitm${i}"
		make_desktop_entry ${PN}${i} "Doom 3 - ${MOD_NAME} (${i})" doom3
	done
}
