# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-1.0_rc3.ebuild,v 1.2 2007/01/05 16:04:51 flameeyes Exp $

inherit kde eutils

MY_P=${P/_/}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
SRC_URI="mirror://sourceforge/k3b/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa css dvdr dvdread encode ffmpeg flac hal kde mp3 musepack musicbrainz
	sndfile vcd vorbis emovix"

DEPEND="kde? ( || ( kde-base/kdesu kde-base/kdebase ) )
	hal? ( || ( dev-libs/dbus-qt3-old
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.30 ) )
		sys-apps/hal )
	media-libs/libsamplerate
	media-libs/taglib
	>=media-sound/cdparanoia-3.9.8
	sndfile? ( media-libs/libsndfile )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	mp3? ( media-libs/libmad )
	musepack? ( media-libs/libmpcdec )
	vorbis? ( media-libs/libvorbis )
	musicbrainz? ( media-libs/musicbrainz )
	encode? ( media-sound/lame )
	alsa? ( media-libs/alsa-lib )
	dvdread? ( media-libs/libdvdread )"

RDEPEND="${DEPEND}
	virtual/cdrtools
	>=app-cdr/cdrdao-1.1.7-r3
	media-sound/normalize
	dvdr? ( >=app-cdr/dvd+rw-tools-7.0 )
	css? ( media-libs/libdvdcss )
	encode? ( media-sound/sox
			  media-video/transcode )
	vcd? ( media-video/vcdimager )
	emovix? ( media-video/emovix )"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

need-kde 3.2

# The following commented lines will have to be uncommented once the final
# release is done. This pre-release version does not support i18n.
#I18N="${PN}-i18n-${PV}"

# Supported languages and translated documentation
#LANGS="af bg bn br bs ca cs cy da de el en_GB es et eu fr ga he hi hu is it ja km lt mk ms nb nds nl nn pa pl pt pt_BR ro ru se sl sr sr@Latn sv ta tr uk zh_CN"

#for X in ${LANGS}; do
#	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/k3b/${I18N}.tar.bz2 )"
#	IUSE="${IUSE} linguas_${X}"
#done

pkg_setup() {
	if use hal && has_version '<sys-apps/dbus-0.91' && ! built_with_use sys-apps/dbus qt3; then
		eerror "You are trying to compile ${CATEGORY}/${PF} with the \"hal\" USE flag enabled,"
		eerror "but sys-apps/dbus is not built with Qt3 support."
		die "Please, rebuild sys-apps/dbus with the \"qt3\" USE flag."
	fi
	if use encode && ! built_with_use media-video/transcode dvdread; then
		eerror "You are trying to compile ${CATEGORY}/${PF} with the \"encode\""
		eerror "USE flag enabled, however media-video/transcode was not built"
		eerror "with libdvdread support. Also keep in mind that enabling"
		eerror "the dvdread USE flag will cause k3b to use libdvdread as well."
		die "Please, rebuild media-video/transcode with the \"dvdread\" USE flag."
	fi

	kde_pkg_setup
}

src_unpack() {
	kde_src_unpack

	if [ -d "${WORKDIR}/${I18N}" ]; then
		cd "${WORKDIR}/${I18N}"
		for X in ${LANGS}; do
			use linguas_${X} || rm -rf "${X}"
		done
		rm -f configure
	fi

	rm -f "${S}/configure"
}

src_compile() {
	local myconf="--enable-libsuffix= 		\
			--with-external-libsamplerate	\
			--without-resmgr				\
			$(use_with kde k3bsetup)		\
			$(use_with hal)					\
			$(use_with encode lame)			\
			$(use_with ffmpeg)				\
			$(use_with flac)				\
			$(use_with vorbis oggvorbis)	\
			$(use_with sndfile)				\
			$(use_with mp3 libmad)			\
			$(use_with musepack)			\
			$(use_with musicbrainz)			\
			$(use_with alsa)"

	# Build process of K3b
	kde_src_compile

	# Build process of K3b-i18n
#	if [ -d "${WORKDIR}/${I18N}" ]; then
#		KDE_S="${WORKDIR}/${I18N}" \
#		kde_src_compile
#	fi
}

src_install() {
	kde_src_install
	dodoc FAQ KNOWNBUGS PERMISSIONS

#	if [ -d "${WORKDIR}/${I18N}" ]; then
#		KDE_S="${WORKDIR}/${I18N}" \
#		kde_src_install
#	fi

	# Move menu entry
	if use kde; then
		mv ${D}/usr/share/applnk/Settings/System/k3bsetup2.desktop ${D}/usr/share/applications/kde/
	fi
	rm -fR ${D}/usr/share/applnk/
}

pkg_postinst() {
	echo
	elog "Make sure you have proper read/write permissions on the cdrom device(s)."
	elog "Usually, it is sufficient to be in the cdrom group."
	echo
}
