# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kworldclock/kdeartwork-kworldclock-3.5.9.ebuild,v 1.4 2008/05/12 14:30:48 armin76 Exp $

ARTS_REQUIRED="never"

KMMODULE=kworldclock
KMNAME=kdeartwork
EAPI="1"
inherit kde-meta

DESCRIPTION="kworldclock from kdeartwork"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=kde-base/kworldclock-${PV}:${SLOT} >=kde-base/kdetoys-${PV}:${SLOT} )"
