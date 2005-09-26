# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/triptych-demo/triptych-demo-0.ebuild,v 1.6 2005/09/26 18:13:36 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="fast-paced tetris-like puzzler"
HOMEPAGE="http://www.chroniclogic.com/triptych.htm"
SRC_URI="http://www.chroniclogic.com/demo/triptych.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/libc
	media-libs/libsdl
	virtual/x11
	virtual/opengl"

S=${WORKDIR}/triptych

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -pPR * "${D}"/${dir}/
	games_make_wrapper triptych ./triptych ${dir}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	# Fix perms on status files #74217
	local f
	for f in triptych.{clr,cnt,scr} ; do
		f="${ROOT}/${GAMES_PREFIX_OPT}/${PN}/${f}"
		if [[ ! -e ${f} ]] ; then
			touch "${f}"
			chmod 660 "${f}"
			chown ${GAMES_USER}:${GAMES_GROUP} "${f}"
		fi
	done
}
