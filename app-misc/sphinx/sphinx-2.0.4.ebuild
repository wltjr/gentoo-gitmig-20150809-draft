# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sphinx/sphinx-2.0.4.ebuild,v 1.1 2012/03/14 07:40:27 graaff Exp $

EAPI=4
inherit eutils autotools

#MY_P=${P/_/-}
MY_P=${P}-release

# This has been added by Gentoo, to explicitly version libstemmer.
# It is the date that http://snowball.tartarus.org/dist/libstemmer_c.tgz was
# fetched.
STEMMER_PV="20091122"
DESCRIPTION="Full-text search engine with support for MySQL and PostgreSQL"
HOMEPAGE="http://www.sphinxsearch.com/"
SRC_URI="http://sphinxsearch.com/files/${MY_P}.tar.gz
	stemmer? ( mirror://gentoo/libstemmer_c-${STEMMER_PV}.tgz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="debug id64 mysql odbc postgres stemmer test"

RDEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	odbc? ( dev-db/unixODBC )
	virtual/libiconv"
DEPEND="${RDEPEND}
	test? ( dev-lang/php )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	if use stemmer; then
		cd "${S}"
		unpack libstemmer_c-${STEMMER_PV}.tgz
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.1_beta-darwin8.patch

	# drop nasty hardcoded search path breaking Prefix
	sed -i -e '/\/usr\/local\//d' configure.ac || die

	# Regenerate autoconf files in the api directory first to avoid
	# running elibtoolize twice, which results in a warning.
	pushd api/libsphinxclient || die
	eautoreconf
	popd || die

	eautoreconf
}

src_configure() {
	# fix libiconv detection
	use !elibc_glibc && export ac_cv_search_iconv=-liconv

	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		$(use_enable id64) \
		$(use_with debug) \
		$(use_with mysql) \
		$(use_with odbc unixodbc) \
		$(use_with postgres pgsql) \
		$(use_with stemmer libstemmer)

	cd api/libsphinxclient || die
	econf STRIP=:
}

src_compile() {
	emake || die "emake failed"

	emake -j 1 -C api/libsphinxclient || die "emake libsphinxclient failed"
}

src_test() {
	elog "Tests require access to a live MySQL database and may require configuration."
	elog "You will find them in /usr/share/${PN}/test and they require dev-lang/php"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	emake DESTDIR="${D}" -C api/libsphinxclient install || die "install libsphinxclient failed"

	dodoc doc/*

	dodir /var/lib/sphinx
	dodir /var/log/sphinx
	dodir /var/run/sphinx

	newinitd "${FILESDIR}"/searchd.rc searchd

	if use test; then
		insinto /usr/share/${PN}
		doins -r test
	fi
}
