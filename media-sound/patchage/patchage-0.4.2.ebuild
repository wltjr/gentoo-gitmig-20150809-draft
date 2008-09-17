# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/patchage/patchage-0.4.2.ebuild,v 1.1 2008/09/17 06:40:35 aballier Exp $

EAPI=1

DESCRIPTION="Modular patch bay for audio and MIDI systems"
HOMEPAGE="http://wiki.drobilla.net/Patchage"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa dbus debug jack"

RDEPEND=">=media-libs/raul-0.5.0
	>=x11-libs/flowcanvas-0.5.0
	>=dev-cpp/gtkmm-2.11.12
	dev-cpp/glibmm
	dev-cpp/libglademm
	dev-cpp/libgnomecanvasmm
	dev-libs/boost
	jack? ( >=media-sound/jack-audio-connection-kit-0.107 )
	alsa? ( media-libs/alsa-lib )
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable alsa ) \
		$(use_enable jack) \
		$(use_enable dbus)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
