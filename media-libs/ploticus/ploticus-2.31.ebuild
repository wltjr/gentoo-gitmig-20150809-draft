# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ploticus/ploticus-2.31.ebuild,v 1.2 2005/07/16 11:36:02 dholm Exp $

inherit eutils toolchain-funcs

MY_P=pl${PV/./}src

S=${WORKDIR}/${MY_P}
DESCRIPTION="A command line application for producing graphs and charts"
HOMEPAGE="http://ploticus.sourceforge.net"
SRC_URI="http://ploticus.sourceforge.net/download/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-09.patch.bz2"
LICENSE="GPL-2"
SLOT=0
KEYWORDS="~ppc ~x86"
IUSE="gd flash nls cpulimit svg svgz truetype X"
DEPEND="media-libs/libpng
	gd? ( >=media-libs/gd-1.84 media-libs/jpeg )
	flash? ( =media-libs/ming-0.2a )
	truetype? ( =media-libs/freetype-2* )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	# Fixes a problem with NOX11.
	# Changes the install directory and comments all flash and gd-related
	# options. (These options will be selectively uncommented later.)
	epatch ${FILESDIR}/${MY_P}.patch

	# Patch to posrelease 09
	epatch ${MY_P}-09.patch

	# I need more vars ^^'
	cd ${MY_P}/src
	sed -i "s/#define MAXVAR 200/#define MAXVAR 2000/" tdhkit.h
}

src_compile() {
	cd src
	# ploticus may be compiled using the external libgd, a libgd provided with
	# the package, or no gd support at all.

	local MO=""
	if useq gd; then
		# PNG and JPEG are supported by default.
		GD18LIBS="-lgd -lpng -lz -ljpeg"
		# Note that truetype works only with the external gd lib.
		if useq truetype; then
			GD18LIBS="${GD18LIBS} -lfreetype"
			MO="${MO} GDFREETYPE=-DGDFREETYPE"
		fi
		# Set the graphics formats support.
		# Use the external libgd.
		MO="${MO} ZFLAG=-DWZ GD18H= GD16H= GDLEVEL=-DGD18=1 plgd18"
		EXE="plpng"
		GD16LIBS="${GD18LIBS}"
		GD18LIBS="${GD18LIBS}"

	else
		# No support for libgd at all.
		# Note that gif and truetype do not work without gd.
		EXE=plnogd
		MO="${MO} NOGDFLAG=-DNOGD"
		GD16LIBS=
		GD18LIBS=
	fi

	# Support for non-roman alphabets and collation.
	if useq nls; then
		MO="${MO} LOCALEOBJ=localef.o LOCALE_FLAG=-DLOCALE"
	fi

	# Support for compressed or uncompressed svg. svgz implies svg. If the 
	# external gd library is used, the svgz format will always be available if
	# ploticus was compiled with support for svg (even if the svgz flag was not
	# specified and even if the -svgz flag was used).
	if useq svgz; then
		MO="${MO} ZLIB=-lz ZFLAG=-DWZ"
	elif ! useq svg; then
		MO="${MO} NOSVGFLAG=-DNOSVG"
	fi

	# Support for X11 output.
	if ! useq X; then
		MO="${MO} NOXFLAG=-DNOX11 XLIBS= XOBJ="
	fi

	# Support for Flash output.
	if useq flash; then
		MO="${MO} MING=-lming"
	else
		MO="${MO} NOSWFFLAG=-DNOSWF"
	fi

	# Support for limiting CPU utilization. (Enabled by default.)
	if ! useq cpulimit; then
		MO="${MO} NORLIMFLAG=-DNORLIMIT"
	fi
	emake "CC=$(tc-getCC)" ${MO} EXE="${EXE}" GD18LIBS="${GD18LIBS}" \
		GD16LIBS="${GD16LIBS}" \
		PREFABS_DIR=/usr/share/ploticus/prefabs ploticus || die
}

src_test() {
	cd ${S}/pltestsuite
	export PATH="${S}/src:${PATH}"
	#sed -i -e "s:PL=.*:PL=${S}/src/pl:" run_script_test
	local TESTS="gif png jpeg eps"
	useq svg && TESTS="${TESTS} svg"
	useq svgz && TESTS="${TESTS} svgz"
	for TEST in ${TESTS};
	do
		echo "Testing ${TEST}"
		echo -e "${TEST}\n" | ./run_script_test
		cat Diag.out
	done
}

src_install() {
	dodoc README
	cd ${S}/src
	mkdir -p ${D}usr/bin
	if useq gd; then
		EXE="pl plpng"
	else
		EXE=pl
	fi
	emake DESTDIR=${D} EXE="${EXE}" install || die

	PL_TARGET=/usr/share/${PN}
	insinto ${PL_TARGET}/prefabs
	doins ${S}/prefabs/*
	insinto ${PL_TARGET}/testsuite
	doins ${S}/pltestsuite/*

	# Add the PLOTICUS_PREFABS environment variable
	#dodir /etc/env.d
	#echo -e "PLOTICUS_PREFABS=${PL_TARGET}/prefabs" > ${D}/etc/env.d/11ploticus

}

#pkg_postinst() {
#	einfo "The environment has been set up for Ploticus to find the prefab files."
#	einfo "In order to immediately activate these settings please do:"
#	einfo ""
#	einfo " env-update"
#	einfo " source /etc/profile"
#	einfo ""
#	einfo "Otherwise the setting will become active at next login."
#
#}

