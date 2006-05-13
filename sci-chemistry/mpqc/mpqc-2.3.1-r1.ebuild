# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mpqc/mpqc-2.3.1-r1.ebuild,v 1.1 2006/05/13 22:21:12 spyderous Exp $

inherit fortran

DESCRIPTION="The Massively Parallel Quantum Chemistry Program"
HOMEPAGE="http://www.mpqc.org/"
SRC_URI="mirror://sourceforge/mpqc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# Should work on x86, amd64 and ppc, at least
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc threads tcltk"

RDEPEND="virtual/blas
	virtual/lapack
	tcltk? ( dev-lang/tk )"
DEPEND="${RDEPEND}
	sys-devel/flex
	dev-lang/perl
	>=sys-apps/sed-4
	doc? ( app-doc/doxygen
		media-gfx/graphviz )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# do not install tkmolrender if not requested
	if ! use tcltk; then
		sed -e "s:.*/bin/molrender/tkmolrender.*::" \
			-e "s:.*\$(INSTALLBINOPT) tkmolrender.*::" \
			-e "s:/bin/rm -f tkmolrender::" \
			-i "./src/bin/molrender/Makefile" \
			|| die "failed to disable tkmolrender"
	fi
}


src_compile() {
#	CFLAGS_SAVE=${CFLAGS}; CXXFLAGS_SAVE=${CXXFLAGS}

	# Only shared will work on ppc64 - bug #62124
	# But we always want shared libraries
	econf \
		$(use_enable threads) \
		--enable-shared \
		${myconf} || die "configure failed"

	sed -i -e "s:^CFLAGS =.*$:CFLAGS=${CFLAGS}:" \
		-e "s:^FFLAGS =.*$:FFLAGS=${FFLAGS:- -O2}:" \
		-e "s:^CXXFLAGS =.*$:CXXFLAGS=${CXXFLAGS}:" \
		lib/LocalMakefile
	emake || die "emake failed"
}


src_test() {
	cd "${S}"/src/bin/mpqc/validate

	# we'll only run the small test set, since the
	# medium and large ones take >10h and >24h on my
	# 1.8Ghz P4M
	make check0 || die "failed in test routines"
}



src_install() {
	make installroot="${D}" install install_devel install_inc \
		|| die "install failed"

	dodoc CHANGES CITATION README || die "failed to install docs"

	# make extended docs 
	if use doc; then
		cd "${S}"/doc
		make all || die "failed to generate documentation"
		doman man/man1/* && doman man/man3/* || \
			die "failed to install man pages"
		dohtml -r html/
	fi
}

pkg_postinst() {
	echo
	einfo "MPQC can be picky with regard to compilation flags."
	einfo "If during mpqc runs you have trouble converging or "
	einfo "experience oscillations during SCF interations, "
	einfo "consider recompiling with less aggressive CFLAGS/CXXFLAGS."
	einfo "Particularly, replacing -march=pentium4 by -march=pentium3"
	einfo "might help if you encounter problems with correlation "
	einfo "consistent basis sets."
	echo
}





