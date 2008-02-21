# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-taglib/gst-plugins-taglib-0.10.7.ebuild,v 1.1 2008/02/21 15:51:53 zaheerm Exp $

inherit eutils gst-plugins-good

KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.17
	>=media-libs/gstreamer-0.10.17
	>=media-libs/taglib-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
