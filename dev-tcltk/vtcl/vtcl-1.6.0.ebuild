# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/vtcl/vtcl-1.6.0.ebuild,v 1.3 2005/03/16 12:16:29 dholm Exp $

DESCRIPTION="Visual Tcl is a high-quality application development environment."
HOMEPAGE="http://vtcl.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
IUSE="doc"
DEPEND="dev-lang/tk"

MY_DESTDIR=/usr/share/${PN}
src_compile() {
	./configure || die
	sed -i 's,^\(VTCL_HOME=\).*,\1'${MY_DESTDIR}',g' vtcl	|| die "Path fixing failed."
}

src_install() {
	dodir ${MY_DESTDIR} || die "Directory creation failed."
	dobin vtcl || die
	cp -r ./{demo,images,lib,sample,vtcl.tcl} ${D}/${MY_DESTDIR} || die "Data installation failed."
	dodoc ChangeLog LICENSE README
	use doc && dodoc doc/tutorial.txt
	use doc && dohtml doc/*html
}
