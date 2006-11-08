# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openexr/openexr-1.4.0a.ebuild,v 1.1 2006/11/08 20:35:13 aballier Exp $

WANT_AUTOMAKE=1.9

inherit eutils libtool autotools

DESCRIPTION="ILM's HDR image file format libraries"
SRC_URI="http://savannah.nongnu.org/download/openexr/${P}.tar.gz"
HOMEPAGE="http://www.openexr.com"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE_VIDEO_CARDS="video_cards_nvidia"
IUSE="doc examples opengl ${IUSE_VIDEO_CARDS}"

RDEPEND="opengl? ( virtual/opengl
	>=x11-libs/fltk-1.1.0
	video_cards_nvidia? ( media-gfx/nvidia-cg-toolkit ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${P/a/}"

src_unpack() {
	if use opengl && ! built_with_use x11-libs/fltk opengl; then
		die "You need opengl support in fltk"
	fi

	unpack ${A}

	# Replace the temporary directory used for tests
	sed -i -e 's:"/var/tmp/":"'${T}'":' "${S}/IlmImfTest/tmpDir.h"

	cd "${S}"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautomake
	elibtoolize
}

src_compile() {
	econf \
		$(use_enable examples imfexamples) \
		$(use_with opengl fltk-config /usr/bin/fltk-config)

	emake || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" examplesdir="/usr/share/doc/${PF}/examples" install || \
		die "install failed"
	dodoc AUTHORS Changelog README* ChangeLog LICENSE NEWS
	newdoc exrdisplay/README README.exrdisplay
	use doc && dodoc doc/*pdf
}
