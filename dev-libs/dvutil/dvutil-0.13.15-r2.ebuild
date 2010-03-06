# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-0.13.15-r2.ebuild,v 1.6 2010/03/06 21:49:19 ssuominen Exp $

inherit eutils

DESCRIPTION="C++ classes for files, dates, property lists, reference counted pointers, number conversion etc."
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/download/dvutil-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE="doc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-underquoted-m4.diff

	sed -i 's|^\(SUBDIRS =.*\)doc\(.*\)$|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		doman doc/man/*/*.[1-9]
		dohtml -r doc/html/*
	fi
}
