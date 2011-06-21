# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gabedit/gabedit-2.3.7.ebuild,v 1.3 2011/06/21 06:04:55 jlec Exp $

EAPI=2

inherit toolchain-funcs versionator

MY_PN=${PN/g/G}
MY_PV=$(delete_all_version_separators)
MY_P="${MY_PN}Src${MY_PV}"

DESCRIPTION="GUI for computational chemistry packages"
HOMEPAGE="http://gabedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/GabeditDevloppment/${MY_PN}${MY_PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86"
IUSE="openmp"

RDEPEND="
	dev-libs/glib:2
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/gtkglext
	x11-libs/gl2ps
	x11-libs/pango
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	tc-export CC
	sed -i "/rmdir tmp/d" "${S}"/Makefile
	sed -e "/GTK_DISABLE_DEPRECATED/s:define:undef:g" \
		-i "${S}/Config.h" || die
	sed -e 's:-g::g' -i Makefile || die
	cp "${FILESDIR}"/CONFIG.Gentoo "${S}"/CONFIG

	if use openmp && tc-has-openmp; then
		cat <<- EOF >> "${S}/CONFIG"
			OMPLIB=-L/usr/$(get_libdir) -lgomp
			OMPCFLAGS=-DENABLE_OMP -fopenmp
		EOF
	fi
	echo "COMMONCFLAGS = ${CFLAGS} -DENABLE_DEPRECATED \$(OMPCFLAGS) \$(DRAWGEOMGL)" >> CONFIG
}

src_compile() {
	emake external_gl2ps=1 || die "emake failed"
}

src_install() {
	dobin ${PN} || die
	dodoc ChangeLog || die
}
