# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remoteosd/vdr-remoteosd-0.0.2.ebuild,v 1.3 2008/10/30 15:46:37 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR: remoteosd PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/remoteosd/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0
		>=media-plugins/vdr-svdrpservice-0.0.2"

PATCHES="${FILESDIR}/${P}-readconfig.diff"

src_unpack() {
	vdr-plugin_src_unpack unpack

	cd "${S}"
	sed -i menu.h \
		-e 's-../svdrpservice/svdrpservice.h-svdrpservice/svdrpservice.h-'

	vdr-plugin_src_unpack all_but_unpack
}
