# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.5.6-r1.ebuild,v 1.2 2007/05/09 16:54:58 carlo Exp $

inherit db-use kde-dist

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

SRC_URI="${SRC_URI} mirror://gentoo/kdesdk-3.5-patchset-01.tar.bz2"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="berkdb kdehiddenvisibility subversion"

DEPEND="!alpha? ( !sparc? ( !ia64? ( >=dev-util/valgrind-3.2.0 ) ) )
	subversion? ( dev-util/subversion )
	berkdb? ( =sys-libs/db-4* )"

RDEPEND="${DEPEND}
	dev-util/cvs
	media-gfx/graphviz"

DEPEND="${RDEPEND}
	sys-devel/flex"

pkg_setup() {
	if use subversion ; then
		if [[ -n "$(svn-config --includes | grep -o /usr/include/apr-0)" ]] \
			&& ! has_version =dev-libs/apr-0* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-0*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
		if [[ -n "$(svn-config --includes | grep -o /usr/include/apr-1)" ]] \
			&& ! has_version =dev-libs/apr-1* ;
		then
			eerror "Subversion has been built against =dev-libs/apr-1*, but no matching version is installed."
			die "Please rebuild dev-util/subversion."
		fi
	fi
}

src_compile() {
	local myconf="$(use_with subversion)"

	if use berkdb; then
		myconf="${myconf} --with-berkeley-db --with-db-lib="$(db_libname)"
			--with-extra-includes=$(db_includedir)"
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	if use subversion ; then
		if [[ -n "$(svn-config --includes | grep -o /usr/include/apr-0)" ]] ; then
			myconf="--with-apr-config=/usr/bin/apr-config"
		else
			myconf="--with-apr-config=/usr/bin/apr-1-config"
		fi
	fi

	kde_src_compile
}

src_install() {
	kde_src_install
	for f in ${KDEDIR}/share/apps/kapptemplate/admin/{bcheck,conf.change,config,detect-autoconf}.pl ; do
		fperms 755 ${f}
	done
}

