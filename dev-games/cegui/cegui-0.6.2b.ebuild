# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cegui/cegui-0.6.2b.ebuild,v 1.3 2009/04/01 18:32:46 josejx Exp $

EAPI=2
inherit autotools eutils

MY_P=CEGUI-${PV%b}
DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"
SRC_URI="mirror://sourceforge/crayzedsgui/${MY_P}b.tar.gz
	doc? ( mirror://sourceforge/crayzedsgui/${MY_P}-DOCS.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="debug devil directfb doc examples expat freeimage irrlicht lua opengl xerces-c xml"

RDEPEND="dev-libs/libpcre
	media-libs/freetype:2
	devil? ( media-libs/devil )
	directfb? ( dev-libs/DirectFB )
	expat? ( dev-libs/expat )
	freeimage? ( media-libs/freeimage )
	irrlicht? ( dev-games/irrlicht )
	lua? (
		dev-lang/lua
		dev-lang/toluapp
	)
	opengl? (
		virtual/opengl
		virtual/glu
		virtual/glut
		media-libs/glew
	)
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	sed -i \
		-e 's/ILvoid/void/g' \
		ImageCodecModules/DevILImageCodec/CEGUIDevILImageCodec.cpp \
		|| die "sed failed"
	if use examples ; then
		cp -r Samples Samples.clean
		rm -f $(find Samples.clean -name 'Makefile*')
		rm -rf Samples.clean/bin
	fi
	eautoreconf #220040
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable devil) \
		$(use_enable directfb directfb-renderer) \
		$(use_enable examples samples) \
		$(use_enable expat) \
		$(use_enable freeimage) \
		$(use_enable irrlicht irrlicht-renderer) \
		$(use_enable lua external-toluapp) \
		$(use_enable lua lua-module) \
		$(use_enable lua toluacegui) \
		$(use_enable opengl external-glew) \
		$(use_enable opengl opengl-renderer) \
		$(use_enable xerces-c) \
		$(use_enable xml libxml) \
		--enable-static \
		--enable-tga \
		--enable-tinyxml \
		--disable-corona \
		--disable-dependency-tracking \
		--disable-external-tinyxml \
		--disable-samples \
		--disable-silly \
		--without-gtk2 \
		--without-ogre-renderer
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	if use doc ; then
		dohtml -r documentation/api_reference || die "dohtml failed"
		dodoc documentation/*.pdf || die "dodoc failed"
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/Samples
		doins -r Samples.clean/* || die "doins failed"
	fi
}
