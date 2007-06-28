# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.12.ebuild,v 1.5 2007/06/28 08:10:14 corsair Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
PATCH_VERSION="2.2.12-r0"
PATCH_P="${PN}-${PATCH_VERSION}-patches"

inherit eutils multilib autotools gnuconfig

KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 mips ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

DESCRIPTION="ODBC Interface for Linux."
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz
		mirror://gentoo/${PATCH_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="qt3 gnome"

DEPEND=">=sys-libs/readline-4.1
		>=sys-libs/ncurses-5.2
		qt3? ( =x11-libs/qt-3* )
		gnome? ( gnome-base/libgnomeui )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${WORKDIR}/${PATCH_P}/*
	#epatch "${FILESDIR}/${P}-configure.in.patch"
	#epatch "${FILESDIR}/${P}-qt.m4.patch"
	#epatch "${FILESDIR}/${P}-gODBCConfig-Makefile.am.patch"
	#epatch "${FILESDIR}/${P}-gODBCConfig-configure.in.patch"
	#epatch "${FILESDIR}/${P}-gODBCConfig-odbcconfig.c.patch"
	#epatch "${FILESDIR}/${P}-gODBCConfig-support.c.patch"
	#epatch "${FILESDIR}/${P}-gODBCConfig-support.h.patch"
}

src_compile() {
	local myconf

	if use qt3 && ! use mips ; then
		myconf="--enable-gui=yes --x-libraries=/usr/$(get_libdir)"
	else
		myconf="--enable-gui=no"
	fi

# Detect mips systems properly
	gnuconfig_update
	eautoreconf

	econf --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/${PN} \
		--libdir=/usr/$(get_libdir) \
		--enable-static \
		--enable-fdb \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"

	if use gnome; then
		# Symlink for configure
		ln -s ${S}/odbcinst/.libs ./lib
		# Symlink for libtool
		ln -s ${S}/odbcinst/.libs ./lib/.libs

		cd gODBCConfig
		touch ChangeLog
		gnuconfig_update
		autoreconf --install
		econf --host=${CHOST} \
			--with-odbc=${S} \
			--enable-static \
			--prefix=/usr \
			--sysconfdir=/etc/${PN} || die "econf gODBCConfig failed"
		ln -s ../depcomp .
		ln -s ../libtool .

		emake || die "emake gODBCConfig failed"
		cd ..
	fi
}



src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	if use gnome;
	then
		cd gODBCConfig
		emake DESTDIR=${D} install || die "emake gODBCConfig install failed"
		cd ..
	fi

	dodoc AUTHORS ChangeLog NEWS README*
	find doc/ -name "Makefile*" -exec rm '{}' \;
	dohtml doc/*
	prepalldocs
}

