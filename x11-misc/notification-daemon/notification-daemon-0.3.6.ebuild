# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/notification-daemon/notification-daemon-0.3.6.ebuild,v 1.4 2006/10/30 20:10:46 jer Exp $

inherit gnome2 eutils

DESCRIPTION="Notifications daemon"
HOMEPAGE="http://www.galago-project.org/"
SRC_URI="http://www.galago-project.org/files/releases/source/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/glib-2.4.0
		>=x11-libs/gtk+-2.4.0
		>=gnome-base/gconf-2.4.0
		>=x11-libs/libsexy-0.1.3
		||	(
				>=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.60 )
			)
		x11-libs/libwnck
		dev-libs/popt"
RDEPEND="${DEPEND}
		 >=sys-devel/gettext-0.14"

DOCS="AUTHORS ChangeLog NEWS"
