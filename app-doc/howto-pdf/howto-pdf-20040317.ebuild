# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/howto-pdf/howto-pdf-20040317.ebuild,v 1.6 2005/01/01 13:13:38 eradicator Exp $

DESCRIPTION="The LDP howtos, pdf format"
HOMEPAGE="http://www.tldp.org/"
SRC_URI="mirror://gentoo/Linux-pdf-HOWTOs-${PV}.tar.bz2"

LICENSE="GPL-2 LDP"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc/howto/pdf
	dosym /usr/share/doc/howto /usr/share/doc/HOWTO

	insinto /usr/share/doc/howto/pdf
	doins * || die
}
