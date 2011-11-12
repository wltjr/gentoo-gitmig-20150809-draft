# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/tovid/tovid-0.34.ebuild,v 1.1 2011/11/12 16:06:15 ssuominen Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A collection of DVD authoring tools"
HOMEPAGE="http://tovid.wikia.com/wiki/Tovid_Wiki"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-cdr/cdrdao
	app-cdr/dvd+rw-tools
	dev-python/pycairo
	dev-python/imaging
	dev-tcltk/tix
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	media-sound/normalize
	>=media-sound/sox-14.3.2
	media-video/dvdauthor
	>=media-video/mjpegtools-2.0.0
	>=media-video/mplayer-1.0_rc4_p20110101
	>=media-video/transcode-1.1.5
	media-video/vcdimager
	sys-devel/bc
	virtual/ffmpeg"
DEPEND="app-text/txt2tags"

DOCS="AUTHORS ChangeLog README"
