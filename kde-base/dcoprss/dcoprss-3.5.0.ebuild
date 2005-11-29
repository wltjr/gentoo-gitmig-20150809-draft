# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/dcoprss/dcoprss-3.5.0.ebuild,v 1.2 2005/11/29 05:02:37 weeve Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: RSS server and client for DCOP"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/librss)"


KMCOPYLIB="librss librss"
KMEXTRACTONLY="librss"
