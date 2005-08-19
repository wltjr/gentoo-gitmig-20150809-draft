# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-2.8.0-r2.ebuild,v 1.2 2005/08/19 17:23:31 leonardop Exp $

inherit gnome.org flag-o-matic eutils debug

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="${SRC_URI}
	mirror://gentoo/gtk+-2-smoothscroll-r6.patch.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc tiff jpeg static"

RDEPEND="virtual/x11
	>=dev-libs/glib-2.7.1
	>=dev-libs/atk-1.0.1
	>=x11-libs/pango-1.9
	>=x11-libs/cairo-0.9.2
	x11-misc/shared-mime-info
	>=media-libs/libpng-1.2.1
	media-libs/fontconfig
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	sys-devel/autoconf
	>=sys-devel/automake-1.7.9
	doc? (
		>=dev-util/gtk-doc-1.4
		~app-text/docbook-xml-dtd-4.1.2 )"


pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	use x86 && [ "$(get_libdir)" == "lib32" ] && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_unpack() {

	unpack ${A}

	cd ${S}
	# beautifying patch for disabled icons
	epatch ${FILESDIR}/${PN}-2.2.1-disable_icons_smooth_alpha.patch
	# add smoothscroll support for usability reasons
	# http://bugzilla.gnome.org/show_bug.cgi?id=103811
	epatch ${DISTDIR}/${PN}-2-smoothscroll-r6.patch.bz2

	cd ${S}

	# Some sanity checks from upstream.
	epatch ${FILESDIR}/${P}-dep_checks.patch
	# Avoid Gdk warnings and other side-effects.
	epatch ${FILESDIR}/${P}-gdk_fix.patch

	# use an arch-specific config directory so that 32bit and 64bit versions
	# dont clash on multilib systems
	has_multilib_profile && epatch ${FILESDIR}/gtk+-2.8.0-multilib.patch

	# and this line is just here to make building emul-linux-x86-gtklibs a bit
	# easier, so even this should be amd64 specific.
	use x86 && [ "$(get_libdir)" == "lib32" ] && epatch ${FILESDIR}/gtk+-2.8.0-multilib.patch

	# patch for ppc64 (#64359)
	use ppc64 && epatch ${FILESDIR}/${PN}-2.4.9-ppc64.patch
	use ppc64 && append-flags -mminimal-toc

	autoconf || die
	automake || die

	epunt_cxx

}

src_compile() {

	# bug 8762
	replace-flags "-O3" "-O2"

	econf \
		`use_enable doc gtk-doc` \
		`use_with jpeg libjpeg` \
		`use_with tiff libtiff` \
		`use_enable static` \
		--with-libpng \
		--with-gdktarget=x11 \
		--with-xinput \
		|| die

	# gtk+ isn't multithread friendly due to some obscure code generation bug
	emake -j1 || die

}

src_install() {

	dodir ${GTK2_CONFDIR}

	make DESTDIR=${D} install || die

	# Enable xft in environment as suggested by <utx@gentoo.org>
	dodir /etc/env.d
	echo "GDK_USE_XFT=1" >${D}/etc/env.d/50gtk2

	dodoc AUTHORS ChangeLog* HACKING NEWS* README*

}

pkg_postinst() {

	gtk-query-immodules-2.0 >	/${GTK2_CONFDIR}/gtk.immodules
	gdk-pixbuf-query-loaders >	/${GTK2_CONFDIR}/gdk-pixbuf.loaders

}
