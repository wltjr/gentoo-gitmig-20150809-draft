# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-firefox-bin/mozilla-firefox-bin-0.8.ebuild,v 1.7 2004/04/27 03:20:40 mr_bones_ Exp $

inherit nsplugins eutils

IUSE="gnome"

MY_PN=${PN/-bin/}
S=${WORKDIR}/firefox
DESCRIPTION="The Mozilla Firefox Web Browser"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/firefox-${PV}-i686-linux-gtk2+xft.tar.gz"
HOMEPAGE="http://www.mozilla.org/projects/firefox"
RESTRICT="nostrip"

KEYWORDS="x86 -ppc -sparc -alpha ~amd64"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"

DEPEND="virtual/glibc"
RDEPEND="virtual/x11
	x86? (
		>=sys-libs/lib-compat-1.0-r2
		>=x11-libs/gtk+-2.2
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	virtual/x11
	!net-www/mozilla-firefox"

src_install() {
	# Plugin path creation
	PLUGIN_DIR="/usr/lib/nsbrowser/plugins"
	dodir /${PLUGIN_DIR}

	# Install firefox in /opt
	dodir /opt
	mv ${S} ${D}/opt/firefox

	# Plugin path setup (rescuing the existing plugins)
	src_mv_plugins /opt/firefox/plugins

	# Fixing permissions
	chown -R root:root ${D}/opt/firefox

	# Truetype fonts
	cd ${D}/opt/firefox/defaults/pref
	einfo "Enabling truetype fonts. Filesdir is ${FILESDIR}"
	epatch ${FILESDIR}/firebird-0.7-antialiasing-patch

	# XXX: should become symlink to mozilla-launcher
	dobin ${FILESDIR}/firefox

	# Install icon and .desktop for menu entry
	if use gnome; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/icon/firefox-icon.png
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/icon/mozillafirefox.desktop
	fi
}

pkg_preinst() {
	# Remove the old plugins dir
	pkg_mv_plugins /opt/firefox/plugins
}
