# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktnef/ktnef-3.4.3.ebuild,v 1.8 2006/03/26 04:51:08 agriffis Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Viewer for mail attachments using TNEF format"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

