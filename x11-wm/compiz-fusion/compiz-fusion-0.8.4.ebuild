# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/compiz-fusion/compiz-fusion-0.8.4.ebuild,v 1.2 2009/10/23 09:04:28 ssuominen Exp $

DESCRIPTION="Compiz Fusion (meta)"
HOMEPAGE="http://www.compiz.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emerald gnome unsupported"

RDEPEND="~x11-wm/compiz-${PV}
	~x11-plugins/compiz-plugins-main-${PV}
	~x11-plugins/compiz-plugins-extra-${PV}
	unsupported? ( ~x11-plugins/compiz-plugins-unsupported-${PV} )
	~x11-apps/ccsm-${PV}
	emerald? ( ~x11-wm/emerald-${PV} )
	gnome? ( ~x11-libs/compizconfig-backend-gconf-${PV} )"

pkg_postinst() {
	ewarn "If you want to try out simple-ccsm, you'll need to emerge it"
	ewarn "If you want to use emerald, set the emerald use flag"
}
