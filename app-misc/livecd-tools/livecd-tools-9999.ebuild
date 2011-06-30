# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-9999.ebuild,v 1.5 2011/06/30 18:48:06 jmbsvicetto Exp $
EAPI="4"

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/livecd-tools.git"
inherit eutils git-2

DESCRIPTION="Gentoo LiveCD tools for autoconfiguration of hardware"
HOMEPAGE="http://wolf31o2.org/projects/livecd-tools"
SRC_URI=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

RDEPEND="dev-util/dialog
	>=sys-apps/baselayout-2
	>=sys-apps/openrc-0.8.2-r1
	sys-apps/pciutils
	sys-apps/gawk
	sys-apps/sed"

pkg_setup() {
		ewarn "This package is designed for use on the LiveCD only and will do"
		ewarn "unspeakably horrible and unexpected things on a normal system."
		ewarn "YOU HAVE BEEN WARNED!!!"
}

src_install() {
	doconfd conf.d/*
	doinitd init.d/*
	dosbin net-setup spind
	into /
	dosbin livecd-functions.sh
}
