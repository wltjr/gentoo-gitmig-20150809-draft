# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xclock/xclock-1.0.1.ebuild,v 1.4 2006/01/31 13:02:59 killerfox Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xclock application"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="xprint"
RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libxkbfile
	x11-libs/libXaw"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable xprint)"

pkg_setup() {
	if use xprint && ! built_with_use x11-libs/libXaw xprint; then
		die "Build x11-libs/libXaw with USE=xprint."
	fi
}
