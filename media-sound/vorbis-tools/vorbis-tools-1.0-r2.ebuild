# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0-r2.ebuild,v 1.3 2004/03/29 01:01:02 vapier Exp $

DESCRIPTION="tools for using the Ogg Vorbis sound file format"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/vorbis-tools-1.0.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="nls"

RDEPEND=">=media-libs/libvorbis-${PV}
	>=media-libs/libogg-${PV}
	>=media-libs/libao-0.8.2
	>=net-misc/curl-7.9"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS README
	docinto ogg123
	dodoc ogg123/ogg123rc-example
}
