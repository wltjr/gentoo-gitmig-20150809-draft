# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lilo-config/lilo-config-3.4.1.ebuild,v 1.3 2005/06/30 21:02:27 danarmak Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE LiLo kcontrol module"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
DEPEND=""

PATCHES="$FILESDIR/never-disable.diff"
