# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkleds/gkleds-0.6.1.ebuild,v 1.1 2002/08/30 07:44:12 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gkrellm plugin for monitoring keyboard LEDs"
SRC_URI="http://www.stud.ifi.uio.no/~oyvinha/gkleds/${P}.tar.gz"
HOMEPAGE="http://www.stud.ifi.uio.no/~oyvinha/gkleds/"

DEPEND="=app-admin/gkrellm-1.2*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	make || die
}

src_install() {
	insinto /usr/lib/gkrellm/plugins
	doinst gkleds.so

	dodoc COPYING Changelog License TODO INSTALL README
}
