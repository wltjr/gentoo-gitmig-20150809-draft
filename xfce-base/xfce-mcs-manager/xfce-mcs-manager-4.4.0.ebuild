# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-mcs-manager/xfce-mcs-manager-4.4.0.ebuild,v 1.14 2007/03/15 13:24:41 corsair Exp $

inherit xfce44

xfce44

DESCRIPTION="Settings manager (Multi-Channel Settings)"
HOMEPAGE="http://www.xfce.org/projects/xfce-mcs-manager"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# There are no gtk-doc for this package.

DOCS="AUTHORS ChangeLog NEWS README TODO"

xfce44_core_package
