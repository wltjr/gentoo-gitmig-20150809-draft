# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nip2/nip2-7.18.2.ebuild,v 1.3 2009/09/29 11:50:06 maekke Exp $

EAPI="2"
inherit eutils autotools fdo-mime versionator

DESCRIPTION="VIPS Image Processing Graphical User Interface"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="fftw gsl test"

RDEPEND="
	>=dev-libs/glib-2
	dev-libs/libxml2
	x11-misc/xdg-utils
	>=media-libs/vips-${PV}
	>=x11-libs/gtk+-2.4.9
	gsl? ( sci-libs/gsl )
	fftw? ( sci-libs/fftw:3.0 )"
DEPEND="${RDEPEND}
	=sys-devel/bison-2.3*
	sys-devel/flex
	test? ( media-libs/vips[lcms] )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-7.16.4-fftw3-build.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-update-desktop \
		$(use_with gsl) \
		$(use_with fftw fftw3)
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README* || die
	# icon for .desktop
	insinto /usr/share/icons/hicolor/128x128/apps
	newins share/nip2/data/vips-128.png nip2.png || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
