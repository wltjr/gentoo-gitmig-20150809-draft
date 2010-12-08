# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/alacarte/alacarte-0.13.2.ebuild,v 1.2 2010/12/08 20:52:52 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 python

DESCRIPTION="Simple GNOME menu editor"
HOMEPAGE="http://live.gnome.org/"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
SLOT=0

common_depends="
	>=dev-python/pygobject-2.15.1
	>=dev-python/pygtk-2.13
	>=gnome-base/gnome-menus-2.27.92[python]"

RDEPEND="${common_depends}
	>=gnome-base/gnome-panel-2.16"

DEPEND="${common_depends}
	sys-devel/gettext
	>=dev-util/intltool-0.40.0
	>=dev-util/pkgconfig-0.19"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_configure() {
	PYTHON="$(PYTHON -a)" gnome2_src_configure
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize Alacarte
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup Alacarte
}
