# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-latex/pidgin-latex-1.3.2.ebuild,v 1.1 2009/08/22 04:35:30 tester Exp $

inherit flag-o-matic multilib eutils

DESCRIPTION="Pidgin plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/pidgin-latex"
SRC_URI="mirror://sourceforge/pidgin-latex/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-im/pidgin
	>=x11-libs/gtk+-2"
RDEPEND="${DEPEND}
	app-text/dvipng
	media-gfx/imagemagick"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use net-im/pidgin gtk; then
		eerror "You need to compile net-im/pidgin with USE=gtk"
		die "Missing gtk USE flag on net-im/pidgin"
	fi
}

src_compile()
{
	append-flags -fPIC
	emake || die "emake failed"
}

src_install()
{
	make LIB_INSTALL_DIR="${D}/usr/$(get_libdir)/pidgin" install PREFIX="${D}/usr" \
	|| die "make install failed"
	dodoc README CHANGELOG TODO
}
