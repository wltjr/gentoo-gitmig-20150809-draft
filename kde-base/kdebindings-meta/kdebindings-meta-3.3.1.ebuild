# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.3.1.ebuild,v 1.5 2005/02/15 21:49:17 greg_g Exp $
MAXKDEVER=3.3.1

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.3"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/dcopc)
$(deprange $PV $MAXKDEVER kde-base/dcopperl)
$(deprange $PV $MAXKDEVER kde-base/dcoppython)
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange $PV $MAXKDEVER kde-base/kdejava)
$(deprange $PV $MAXKDEVER kde-base/kjsembed)
$(deprange $PV $MAXKDEVER kde-base/korundum)
$(deprange $PV $MAXKDEVER kde-base/qtjava)
$(deprange $PV $MAXKDEVER kde-base/qtruby)
$(deprange $PV $MAXKDEVER kde-base/smoke)"


# Omitted: qtsharp, dcopjava, xparts (considered broken by upstream) 
