# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.9.ebuild,v 1.2 2004/11/05 03:09:30 obz Exp $

inherit libtool gnome.org eutils python

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
IUSE="python"

DEPEND=">=dev-libs/libxml2-2.6.8
	python? ( dev-lang/python )"

src_unpack() {

	unpack ${A}
	cd ${S}
	# we still require the 1.1.8 patch for the .m4 file, to add
	# the CXXFLAGS defines <obz@gentoo.org>
	epatch ${FILESDIR}/libxslt.m4-${PN}-1.1.8.patch

}

src_compile() {

	elibtoolize
	econf `use_with python` || die "configure failed"
	emake || die "make failed"

}

src_install() {

	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README NEWS TODO

}
