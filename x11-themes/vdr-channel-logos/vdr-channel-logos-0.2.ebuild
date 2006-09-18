# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/vdr-channel-logos/vdr-channel-logos-0.2.ebuild,v 1.1 2006/09/18 19:58:20 hd_brummy Exp $

inherit eutils

MY_P=${PN#vdr-channel-}-${PV}

DESCRIPTION="Logos for vdr-skin*"
HOMEPAGE="http://www.vdrskins.org/"
SRC_URI="http://www.vdrskins.org/vdrskins/albums/userpics/10138/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S=${WORKDIR}/logos

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_install() {

	insinto /usr/share/vdr/channel-logos
	cp -a ${S}/*.xpm ${D}/usr/share/vdr/channel-logos/
}

