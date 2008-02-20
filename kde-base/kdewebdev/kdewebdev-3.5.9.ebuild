# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdewebdev/kdewebdev-3.5.9.ebuild,v 1.1 2008/02/20 22:56:36 philantrop Exp $

EAPI="1"
inherit kde-dist

DESCRIPTION="KDE web development - Quanta"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc kdehiddenvisibility tidy"

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

RDEPEND="${DEPEND}
	tidy? ( app-text/htmltidy )
	doc? ( app-doc/quanta-docs )"
