# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-pango/gst-plugins-pango-0.8.8-r1.ebuild,v 1.8 2005/06/09 20:54:05 gustavoz Exp $

inherit gst-plugins

KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86"

IUSE=""
DEPEND="x11-libs/pango"

src_unpack() {

	gst-plugins_src_unpack

	cd ${S}/ext/pango
	# fix subtitle crop at bottom
	epatch ${FILESDIR}/${P}-sub_position.patch

}
