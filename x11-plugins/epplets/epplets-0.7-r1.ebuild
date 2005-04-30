# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/epplets/epplets-0.7-r1.ebuild,v 1.3 2005/04/30 09:32:01 kloeri Exp $

inherit eutils

DESCRIPTION="Base files for Enlightenment epplets and some epplets"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/epplets-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~alpha"
IUSE=""

DEPEND="virtual/x11
	virtual/glut
	>=media-libs/imlib-1.9.10
	>=x11-wm/enlightenment-0.16.6
	media-sound/esound"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-compmgr-fix.patch #68057
}

src_compile() {
	export EROOT=/usr/share/epplets
	export EBIN=/usr/bin
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
}
