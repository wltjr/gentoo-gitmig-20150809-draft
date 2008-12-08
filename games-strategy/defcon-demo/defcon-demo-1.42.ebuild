# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/defcon-demo/defcon-demo-1.42.ebuild,v 1.2 2008/12/08 02:50:46 darkside Exp $

EAPI=1
inherit eutils toolchain-funcs games

MY_PN=defcon
MY_PV=${PV/_/-}
MY_P=defcon-v${MY_PV}

DESCRIPTION="Global thermonuclear war simulation with multiplayer support"
HOMEPAGE="http://www.introversion.co.uk/defcon/"
SRC_URI="http://download.introversion.co.uk/defcon/linux/${MY_P}.tar.gz"

LICENSE="defcon"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+system-libs"
RESTRICT="strip"

# glibc discussion:
# http://forums.introversion.co.uk/defcon/viewtopic.php?t=4016
RDEPEND=">=sys-libs/glibc-2.3
		system-libs? (
			media-libs/libogg
			media-libs/libsdl
			media-libs/libvorbis )
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXext
		x11-libs/libXdmcp"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# FindPath scripts are ugly and unnecessary
	rm -f defcon doc/README-SDL.txt
	if use system-libs ; then
		rm -f lib/lib*
	fi
	sed \
		-e "s:GAMEDIR:${GAMES_PREFIX_OPT}/${PN}:g" \
		"${FILESDIR}"/defcon > "${T}"/defcon \
		|| die "sed failed"
	echo "int chdir(const char *d) { return 0; }" > chdir.c \
		|| die "echo failed"
}

src_compile() {
	$(tc-getCC) -fPIC -shared -ldl -o lib/chdir.so chdir.c || die
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}/lib"
	doins lib/*.dat || die

	exeinto "${dir}"/lib
	doexe lib/*.{sh,x86,so} || die

	dodoc manual.pdf doc/*txt
	doicon doc/defcon.ico

	# Can be upgraded to full version, so is not installed as "demo"
	dogamesbin "${T}"/defcon || die "dogamesbin failed"
	make_desktop_entry ${MY_PN} "Defcon" /usr/share/pixmaps/defcon.ico

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Screenshots will appear in ~/.defcon/lib"
}
