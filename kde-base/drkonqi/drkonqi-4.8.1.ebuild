# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/drkonqi/drkonqi-4.8.1.ebuild,v 1.1 2012/03/06 23:35:10 dilfridge Exp $

EAPI=4

KMNAME="kde-runtime"
inherit kde4-meta

DESCRIPTION="KDE crash handler, gives the user feedback if a program crashed"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

pkg_postinst() {
	kde4-meta_pkg_postinst
	if ! has_version "sys-devel/gdb"; then
		elog "For more usability consider installing following packages:"
		elog "    sys-devel/gdb - Easier debugging support"
	fi
}
