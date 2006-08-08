# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/hgmenu/hgmenu-0.9.1.ebuild,v 1.1 2006/08/08 20:42:14 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: mercurial integration plugin"
HOMEPAGE="http://www.selenic.com/pipermail/mercurial/2006-July/009510.html"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="~dev-util/mercurial-${PV}"
