# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-4.3.1.ebuild,v 1.2 2009/10/10 08:39:51 ssuominen Exp $

EAPI="2"

KMNAME="kdesdk"
inherit kde4-meta

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook"

RDEPEND="
	dev-util/cvs
"
