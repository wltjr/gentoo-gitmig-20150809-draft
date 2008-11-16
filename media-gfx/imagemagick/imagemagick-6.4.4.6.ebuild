# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imagemagick/imagemagick-6.4.4.6.ebuild,v 1.6 2008/11/16 16:13:35 klausman Exp $

EAPI="1"

inherit eutils multilib perl-app toolchain-funcs

MY_PN=ImageMagick
MY_P=${MY_PN}-${PV%.*}
MY_P2=${MY_PN}-${PV%.*}-${PV#*.*.*.}

DESCRIPTION="A collection of tools and libraries for many image formats"
HOMEPAGE="http://www.imagemagick.org/"
SRC_URI="ftp://ftp.imagemagick.org/pub/${MY_PN}/${MY_P2}.tar.bz2"

LICENSE="imagemagick"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="bzip2 +corefonts djvu doc fontconfig fpx graphviz gs hdri jbig jpeg jpeg2k
	lcms nocxx openexr openmp perl png q8 q32 raw svg tiff truetype X wmf xml zlib"

RDEPEND="bzip2? ( app-arch/bzip2 )
	djvu? ( app-text/djvu )
	fontconfig? ( media-libs/fontconfig )
	fpx? ( media-libs/libfpx )
	graphviz? ( >=media-gfx/graphviz-2.6 )
	gs? ( virtual/ghostscript )
	jbig? ( media-libs/jbigkit )
	jpeg? ( >=media-libs/jpeg-6b )
	jpeg2k? ( media-libs/jasper )
	lcms? ( >=media-libs/lcms-1.06 )
	openexr? ( media-libs/openexr )
	perl? ( >=dev-lang/perl-5.8.6-r6 !=dev-lang/perl-5.8.7 )
	png? ( media-libs/libpng )
	raw? ( media-gfx/ufraw )
	tiff? ( >=media-libs/tiff-3.5.5 )
	truetype? ( =media-libs/freetype-2*
		corefonts? ( media-fonts/corefonts ) )
	wmf? ( >=media-libs/libwmf-0.2.8 )
	xml? ( >=dev-libs/libxml2-2.4.10 )
	zlib? ( sys-libs/zlib )
	X? (
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		svg? ( >=gnome-base/librsvg-2.9.0 )
	)
	!dev-perl/perlmagick
	!sys-apps/compare
	>=sys-devel/libtool-1.5.2-r6"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	X? ( x11-proto/xextproto )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use djvu && ! built_with_use app-text/djvu threads; then
		eerror "app-text/djvu has to be built with threads support."
		die "build app-text/djvu with USE=\"threads\""
	fi
	# for now, only build svg support when X is enabled, as librsvg
	# pulls in quite some X dependencies.
	if use svg && ! use X ; then
		elog "the svg USE-flag requires the X USE-flag set."
		elog "disabling svg support for now."
	fi

	if use corefonts && ! use truetype ; then
		elog "corefonts USE-flag requires the truetype USE-flag to be set."
		elog "disabling corefonts support for now"
	fi
}

src_unpack() {
	unpack ${A}

	# fix doc dir, bug 91911
	sed -i -e \
		's:DOCUMENTATION_PATH="${DATA_DIR}/doc/${DOCUMENTATION_RELATIVE_PATH}":DOCUMENTATION_PATH="/usr/share/doc/${PF}":g' \
		"${S}"/configure || die
}

src_compile() {
	local myconf
	if use q32 ; then
		myconf="${myconf} --with-quantum-depth=32"
	elif use q8 ; then
		myconf="${myconf} --with-quantum-depth=8"
	else
		myconf="${myconf} --with-quantum-depth=16"
	fi

	if use X && use svg ; then
		myconf="${myconf} --with-rsvg"
	else
		myconf="${myconf} --without-rsvg"
	fi

	#openmp support only works with >=sys-devel/gcc-4.3
	# see bug #223825
	if use openmp && built_with_use --missing false sys-devel/gcc openmp; then
		if [[ $(gcc-version) != "4.3" ]] ; then
			ewarn "you need sys-devel/gcc-4.3 to be able to use openmp, disabling."
			myconf="${myconf} --disable-openmp"
		else
			myconf="${myconf} --enable-openmp"
		fi
	else
		elog "disabling openmp support"
		myconf="${myconf} --disable-openmp"
	fi

	use truetype && myconf="${myconf} $(use_with truetype windows-font-dir /usr/share/fonts/corefonts)"

	econf \
		${myconf} \
		--without-included-ltdl \
		--with-ltdl-include=/usr/include \
		--with-ltdl-lib=/usr/$(get_libdir) \
		--with-threads \
		--with-modules \
		$(use_with perl) \
		--with-gs-font-dir=/usr/share/fonts/default/ghostscript \
		$(use_enable hdri) \
		$(use_with !nocxx magick-plus-plus) \
		$(use_with bzip2 bzlib) \
		$(use_with djvu) \
		$(use_with fontconfig) \
		$(use_with fpx) \
		$(use_with gs dps) \
		$(use_with gs gslib) \
		$(use_with graphviz gvc) \
		$(use_with jbig) \
		$(use_with jpeg jpeg) \
		$(use_with jpeg2k jp2) \
		$(use_with lcms) \
		$(use_with openexr) \
		$(use_with png) \
		$(use_with svg rsvg) \
		$(use_with tiff) \
		$(use_with truetype freetype) \
		$(use_with wmf) \
		$(use_with xml) \
		$(use_with zlib) \
		$(use_with X x) \
		|| die "econf failed"
	emake || die "compile problem"
}

src_test() {
	# make check only works after make install,
	# --> only run if this version is already installed
	if has_version ~${CATEGORY}/${P} ; then
		emake -j1 check || die "make check failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation of files into image failed"

	# dont need these files with runtime plugins
	rm -f "${D}"/usr/$(get_libdir)/*/*/*.{la,a}

	use doc || rm -r "${D}"/usr/share/doc/${PF}/{www,images,index.html}
	dodoc NEWS.txt ChangeLog AUTHORS.txt README.txt

	# Fix perllocal.pod file collision
	use perl && fixlocalpod
}
