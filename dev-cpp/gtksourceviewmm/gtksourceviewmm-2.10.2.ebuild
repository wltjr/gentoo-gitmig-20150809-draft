# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtksourceviewmm/gtksourceviewmm-2.10.2.ebuild,v 1.1 2011/06/26 17:49:06 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="C++ bindings for gtksourceview"
HOMEPAGE="http://projects.gnome.org/gtksourceviewmm/"

KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"
SLOT="2.0"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-cpp/gtkmm-2.12:2.4
	dev-cpp/atkmm
	>=x11-libs/gtksourceview-2.10.0:2.0
	!>=dev-cpp/libgtksourceviewmm-1"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}

src_prepare() {
	gnome2_src_prepare

	# Remove docs from SUBDIRS so that docs are not installed, as
	# we handle it in src_install.
	sed -i -e 's|^\(SUBDIRS =.*\)$(doc_subdirs)\(.*\)|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	gnome2_src_install
	use doc && dohtml -r docs/reference/html/*
}
