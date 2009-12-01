# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.3.4.ebuild,v 1.1 2009/12/01 11:18:39 wired Exp $

EAPI="2"

KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa debug"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with alsa)"
	kde4-meta_src_configure
}
