# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/coreblog/coreblog-0.6.ebuild,v 1.3 2004/10/08 10:01:50 radek Exp $

inherit zproduct

NEW_PV="${PV//./-}"

DESCRIPTION="Blog/Weblog/Web Nikki system for Zope."
HOMEPAGE="http://coreblog.org/"
SRC_URI="${HOMEPAGE}/junk/COREBlog06b.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""

ZPROD_LIST="COREBlog"
