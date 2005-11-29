# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.5.0.ebuild,v 1.2 2005/11/29 05:02:44 weeve Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
HOMEPAGE="http://kopete.kde.org/"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="sametime ssl xmms"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2
	>=dev-libs/glib-2
	sametime? ( =net-libs/meanwhile-0.4* )
	xmms? ( media-sound/xmms )"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )"

src_compile() {
	# External libgadu support - doesn't work, kopete requires a specific development snapshot of libgadu.
	# Maybe we can enable it in the future.
	# The nowlistening plugin has xmms support.
	local myconf="$(use_enable sametime sametime-plugin)
	              $(use_with xmms) --without-external-libgadu"

	kde-meta_src_compile
}
