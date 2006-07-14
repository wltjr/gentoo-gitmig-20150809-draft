# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libmatchbox/libmatchbox-1.7.ebuild,v 1.2 2006/07/14 17:20:21 yvasilev Exp $

inherit eutils libtool

DESCRIPTION="The Matchbox Library."
HOMEPAGE="http://projects.o-hand.com/matchbox/"
SRC_URI="http://projects.o-hand.com/matchbox/sources/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="debug doc jpeg pango png truetype X xsettings"

RDEPEND="|| ( (	x11-libs/libXext
		truetype? ( x11-libs/libXft ) )
		virtual/x11 )
	pango? ( x11-libs/pango )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	xsettings? ( x11-libs/libxsettings-client )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

pkg_setup() {
	# Bug #138135
	if use truetype && use pango; then
		ewarn "You have both the truetype and pango USE flags set, pango"
		ewarn "overrides and disables the XFT support truetype enables."
		ewarn "If this isn't what you intended you should stop the build!"
		ebeep 3
		epause 3
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	elibtoolize
}

src_compile() {
	econf	$(use_enable debug) \
		$(use_enable doc doxygen-docs) \
		$(use_enable truetype xft) \
		$(use_enable pango) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable xsettings) \
		$(use_with X x) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS Changelog INSTALL NEWS README
	use doc && dohtml doc/html/*
}
