# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/freetds/freetds-0.82-r3.ebuild,v 1.3 2011/08/26 20:06:13 grobian Exp $

EAPI="3"

inherit autotools flag-o-matic

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~ppc-macos ~sparc-solaris ~x86-solaris"
DESCRIPTION="Tabular Datastream Library."
HOMEPAGE="http://www.freetds.org/"
SRC_URI="http://ibiblio.org/pub/Linux/ALPHA/freetds/stable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="odbc iodbc mssql"
RESTRICT="test"

DEPEND="odbc? ( dev-db/unixODBC )
		iodbc? ( dev-db/libiodbc )"
RDEPEND="${DEPEND}"

src_prepare() {
	# taken from a nightly build (20100522)
	cp "${FILESDIR}/config.rpath" "${S}"

	sed -ie 's:with_iodbc/include":with_iodbc/include/iodbc":' configure.ac
	eautoreconf
}

src_configure() {
	myconf="--with-tdsver=7.0 $(use_enable mssql msdblib)"

	if use iodbc ; then
		myconf="${myconf} --enable-odbc --with-iodbc=${EPREFIX}/usr"
	elif use odbc ; then
		myconf="${myconf} --enable-odbc --with-unixodbc=${EPREFIX}/usr"
	fi

	use elibc_glibc || append-libs iconv

	econf $myconf || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="doc/${PF}" install || die "make install failed"
}
