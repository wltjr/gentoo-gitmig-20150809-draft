# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kappfinder/kappfinder-3.5.8.ebuild,v 1.7 2008/03/04 02:30:09 jer Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE tool that looks for well-known apps in your path and creates .desktop files for them in the KDE menu"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

RDEPEND="$(deprange $PV $MAXKDEVER kde-base/kicker)"
