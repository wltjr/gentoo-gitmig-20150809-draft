# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-docs-konq-plugins/kdeaddons-docs-konq-plugins-3.5.7.ebuild,v 1.1 2007/05/22 21:44:52 carlo Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="doc/konq-plugins"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Documentation for the konqueror plugins from kdeaddons"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""

