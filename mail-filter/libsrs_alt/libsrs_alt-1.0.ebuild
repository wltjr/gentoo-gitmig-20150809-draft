# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/libsrs_alt/libsrs_alt-1.0.ebuild,v 1.1 2008/12/07 12:45:02 peitolm Exp $

MY_PV=${PV}
MY_RC=${PV}
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="Sender Rewriting Scheme library"
HOMEPAGE="http://srs.mirtol.com/"
SRC_URI="http://srs.mirtol.com/libsrs_alt-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc !dev-perl/Mail-SRS"
RDEPEND=""

src_compile() {
	# Since the primary intended consumers of this library are MTAs,
	# use non-standard separator characters (--with-base64compat).
	# This breaks "SRS Compliancy", which is a rough standard at
	# best.
	econf --with-base64compat || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc "${S}"/MTAs/README.EXIM
}
