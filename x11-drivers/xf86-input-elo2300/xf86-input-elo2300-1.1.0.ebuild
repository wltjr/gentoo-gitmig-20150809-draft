# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-elo2300/xf86-input-elo2300-1.1.0.ebuild,v 1.2 2006/06/05 21:34:40 flameeyes Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for elo2300 input devices"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
