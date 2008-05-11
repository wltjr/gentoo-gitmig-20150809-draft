# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/traylib/traylib-0.3.2.1.ebuild,v 1.1 2008/05/11 15:58:24 lack Exp $

NEED_PYTHON="2.3"
inherit python eutils multilib

MY_PN="TrayLib"
DESCRIPTION="TrayLib is a library for tray-based rox panel applets."
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/libs/${MY_PN}-${PV}.tgz"

RDEPEND=">=rox-base/rox-lib-1.9.6
	!<rox-base/tasktray-0.7
	!<rox-base/devtray-0.4.1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	dodir "${baselibdir}"
	cp -r ${MY_PN}/ "${D}${baselibdir}/${MY_PN}"
	python_mod_optimize "${D}${baselibdir}/${MY_PN}/" >/dev/null 2>&1
	dodir /usr/share/doc/
	dosym ${baselibdir}/${MY_PN}/Help /usr/share/doc/${P}
}
