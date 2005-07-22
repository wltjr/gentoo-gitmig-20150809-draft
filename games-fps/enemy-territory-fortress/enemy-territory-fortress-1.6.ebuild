# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-fortress/enemy-territory-fortress-1.6.ebuild,v 1.1 2005/07/22 14:13:36 wolf31o2 Exp $

MOD_DESC="Fortress"
MOD_NAME=etf
inherit eutils games games-etmod

HOMEPAGE="http://www.etfgame.com/"
SRC_URI="http://www.etf-center.com/files/etf_${PV}-english.run
	http://www.playlinux.net/pub/files/native/etf_${PV}-english.run"

RESTRICT="nomirror nostrip"
LICENSE="as-is"

src_unpack() {
	unpack_makeself
	rm -rf setup.* bin
	tar xfz etf.tar.gz
	rm *.tar.gz search.sh
}
