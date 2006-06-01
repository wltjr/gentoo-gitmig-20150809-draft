# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcddb/libkcddb-3.5.2.ebuild,v 1.9 2006/06/01 20:48:10 flameeyes Exp $

KMNAME=kdemultimedia
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE library for CDDB"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""