# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gtkdiskfree/gtkdiskfree-2.0.1.ebuild,v 1.4 2012/06/01 15:05:19 ago Exp $

EAPI=4

DESCRIPTION="Graphical tool to show free disk space"
HOMEPAGE="https://gitorious.org/gtkdiskfree"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-master

src_configure() {
	econf $(use_enable nls) --without-gtk2
}
