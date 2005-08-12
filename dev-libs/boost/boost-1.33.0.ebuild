# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.33.0.ebuild,v 1.1 2005/08/12 23:37:49 morfic Exp $

# This ebuild was generated by Ebuilder v0.4.
inherit python distutils multilib eutils

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
BOOST_PV1=${PV/./_}
BOOST_PV=${BOOST_PV1/./_}
SRC_URI="mirror://sourceforge/boost/${PN}_${BOOST_PV}.tar.bz2"
LICENSE="freedist Boost-1.0"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc icc pyste static threads threadsonly"

DEPEND="!icc? ( sys-devel/gcc )
	icc? (  >=dev-lang/icc-8.0.055 )
	dev-lang/python"

RDEPEND="pyste? ( dev-cpp/gccxml dev-python/elementtree ) ${DEPEND}"

S="${WORKDIR}/${PN}_${BOOST_PV}"

pkg_setup() {

	if [ "${ARCH}" == "amd64" ]; then
		arch=
	else
		arch=${ARCH}
	fi

	if use icc ; then
		BOOST_TOOLSET="intel-linux"
		TOOLSET_NAME="icc"
		SOSUFFIX="so"
	elif use ppc-macos ; then
		BOOST_TOOLSET="darwin"
		TOOLSET_NAME="darwin"
		SOSUFFIX="dylib"
	else
		BOOST_TOOLSET="gcc"
		TOOLSET_NAME="gcc"
		SOSUFFIX="so"
	fi

	if use static ; then
		BUILD="release <runtime-link>static"
	else
		BUILD="release <runtime-link>dynamic"
	fi

	if use debug ; then
		BUILD="${BUILD} debug"
	fi

	if use threads && use threadsonly ; then
		BUILD="${BUILD} <threading>multi"
	fi

	if use threads && ! use threadsonly ; then
		BUILD="${BUILD} <threading>single/multi"
	fi

	if ! use threads ; then
		BUILD="${BUILD} <threading>single"
	fi

	BOOSTJAM=./tools/build/jam_src/bin.*/bjam

	# we dont like what get_number_of_jobs does, so we borrow what counts to us,
	# thanks H?kan Wessberg <nacka-gentoo@refug.org>, bug #13565

	if [ "`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | wc -l`" -gt 0 ]; then
		ADMINOPTS="`egrep "^[[:space:]]*MAKEOPTS=" /etc/make.conf | cut -d= -f2 | sed 's/\"//g'`"
		ADMINPARAM="`echo ${ADMINOPTS} | gawk '{match($0, /-j *[0-9]*/, opt); print opt[0]}'`"
		NUMJOBS="${ADMINPARAM}"
	fi

	python_version

}

src_compile() {
		# Build bjam, a jam variant, which is used instead of make
		cd "${S}/tools/build/jam_src"
		./build.sh ${BOOST_TOOLSET} || die "Failed to build bjam"
		cd "${S}"

		if use icc ; then
				export CPLUS_INCLUDE_PATH="/opt/intel/compiler80/include/c++"
				export GXX_INCLUDE="/usr/include"
				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sINTEL_PATH="/opt/intel/compiler80/" \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sINTEL_PATH="/opt/intel/compiler80/" \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

		else
				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

				${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
				-sPYTHON_ROOT=/usr \
				-sPYTHON_VERSION=${PYVER} \
				-sTOOLS=${BOOST_TOOLSET} \
				-sBUILD="${BUILD}" \
				--prefix=${D}/usr \
				--layout=system

		fi

		if use pyste; then
			cd ${S}/libs/python/pyste/install
			distutils_src_compile
		fi
}

src_install () {
		# install build tools
		cd "${S}/tools/build"
		#do_whatever is too limiting here, need to move bunch of different stuff recursively
		insinto /usr/share/${PN}
		doins -a b* index.html v1/ v2/ ${D}/usr/share/${PN} || die "failed to install docs"
		cd "${S}"

		if use icc ; then
			export CPLUS_INCLUDE_PATH="/opt/intel/compiler80/include/c++"
			export GXX_INCLUDE="/usr/include"
			${BOOSTJAM} ${NUMJOBS} -sBOOST_ROOT="${S}" \
			-sPYTHON_ROOT=/usr \
			-sPYTHON_VERSION=${PYVER} \
			-sTOOLS=${BOOST_TOOLSET} \
			-sBUILD="${BUILD}" \
			-sINTEL_PATH="/opt/intel/compiler80/" \
			--prefix=${D}/usr \
			--layout=system \
			install || die "Install failed"
		else
			${BOOSTJAM}	${NUMJOBS} -sBOOST_ROOT="${S}" \
			-sPYTHON_ROOT=/usr \
			-sPYTHON_VERSION=${PYVER} \
			-sTOOLS=${BOOST_TOOLSET} \
			-sBUILD="${BUILD}" \
			--prefix=${D}/usr \
			--layout=system \
			install || die "Install failed"
		fi

	# Install documentation; seems to be mostly under ${S}/lib

	if use doc ; then
		dodoc README
		dohtml 	index.htm google_logo_40wht.gif c++boost.gif boost.css \
				-A pdf -r more-r people -r doc

		find libs -type f -not -regex '^libs/[^/]*/build/.*' \
			-and -not -regex '^libs/.*/test[^/]?/.*' \
			-and -not -regex '^libs/.*/bench[^/]?/.*' \
			-and -not -regex '^libs/[^/]*/tools/.*' \
			-and -not -name \*.bat \
			-and -not -name Jamfile\* \
			-and -not -regex '^libs/[^/]*/src/.*' \
			-and -not -iname makefile \
			-and -not -name \*.mak \
			-and -not -name .\* \
			-and -not -name \*.dsw \
			-and -not -name \*.dsp \
			-exec \
		install -D -m0644 \{\} ${D}/usr/share/doc/${PF}/html/\{\} \;
	fi
		#and finally set "default" links to -gcc-mt versions
		cd ${D}/usr/lib

		for fn in `ls -1 *.${SOSUFFIX}| cut -d- -f1 | sort | uniq`; do
			if [ -f "$fn.${SOSUFFIX}" ] ; then
				dosym "$fn.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}.${SOSUFFIX}"
			fi
			if [ -f "$fn-mt.${SOSUFFIX}" ] ; then
				dosym "$fn-mt.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-mt.${SOSUFFIX}"
			fi
			if [ -f "$fn-d.${SOSUFFIX}" ] ; then
				dosym "$fn-d.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-d.${SOSUFFIX}"
			fi
			if [ -f "$fn-mt-d.${SOSUFFIX}" ] ; then
				dosym "$fn-mt-d.${SOSUFFIX}" "/usr/lib/$fn-${TOOLSET_NAME}-mt-d.${SOSUFFIX}"
			fi
		done

		for fn in `ls -1 *.a| cut -d- -f1 | sort | uniq`; do
			if [ -f "$fn.a" ] ; then
				dosym "$fn.a" "/usr/lib/$fn-${TOOLSET_NAME}.a"
			fi
			if [ -f "$fn-mt.a" ] ; then
				dosym "$fn-mt.a" "/usr/lib/$fn-${TOOLSET_NAME}-mt.a"
			fi
			if [ -f "$fn-d.a" ] ; then
				dosym "$fn-d.a" "/usr/lib/$fn-${TOOLSET_NAME}-d.a"
			fi
			if [ -f "$fn-mt-d.a" ] ; then
				dosym "$fn-mt-d.a" "/usr/lib/$fn-${TOOLSET_NAME}-mt-d.a"
			fi
		done

	[[ $(get_libdir) == "lib" ]] || mv ${D}/usr/lib ${D}/usr/$(get_libdir)

	if use pyste; then
		cd ${S}/libs/python/pyste/install
		distutils_src_install
	fi
}
