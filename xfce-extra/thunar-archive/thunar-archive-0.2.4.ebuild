# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-archive/thunar-archive-0.2.4.ebuild,v 1.4 2007/02/03 00:11:32 nichoj Exp $

inherit xfce44

xfce44
xfce44_goodies_thunar_plugin

MY_P="${PN}-plugin-${PV}"

DESCRIPTION="Thunar archive plugin"
HOMEPAGE="http://www.foo-projects.org/~benny/projects/thunar-archive-plugin/"
SRC_URI="http://download2.berlios.de/xfce-goodies/${MY_P}${COMPRESS}"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
