# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/wp_tray/wp_tray-0.5.5.ebuild,v 1.6 2011/01/11 20:19:47 pacho Exp $

EAPI=2
GCONF_DEBUG=no
inherit eutils gnome2 multilib

DESCRIPTION="Wallpaper Manager for the Gnome Desktop"
HOMEPAGE="http://planetearthworm.com/projects/wp_tray"
SRC_URI="http://planetearthworm.com/projects/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	dev-cpp/libgnomeuimm
	dev-cpp/libxmlpp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/boost"

pkg_setup() {
	G2CONF="${G2CONF} --with-boostfilesystem=/usr/$(get_libdir)/libboost_filesystem.so"
	G2CONF="${G2CONF} --with-boostregex=/usr/$(get_libdir)/libboost_regex.so"
	DOCS="AUTHORS ChangeLog NEWS README*"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc45.patch
	gnome2_src_prepare
}

src_install() {
	addpredict /root/.gconf
	gnome2_src_install
}
