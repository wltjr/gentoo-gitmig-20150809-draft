# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gcstar/gcstar-1.6.2.ebuild,v 1.1 2011/11/20 06:51:05 tetromino Exp $

EAPI="4"

inherit eutils fdo-mime gnome2-utils

DESCRIPTION="Manage your collections of movies, games, books, music and more"
HOMEPAGE="http://www.gcstar.org/"
SRC_URI="http://download.gna.org/gcstar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cddb gnome mp3 spell stats tellico vorbis"

RDEPEND="dev-lang/perl
	dev-perl/Archive-Zip
	dev-perl/DateTime-Format-Strptime
	dev-perl/gtk2-perl
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/XML-Parser
	dev-perl/XML-Simple
	virtual/perl-Archive-Tar
	virtual/perl-Encode
	virtual/perl-Getopt-Long
	virtual/perl-File-Path
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	virtual/perl-IO-Compress
	virtual/perl-libnet
	virtual/perl-Storable
	virtual/perl-Time-Piece

	cddb? ( dev-perl/Net-FreeDB )
	gnome? ( dev-perl/gnome2-vfs-perl )
	mp3? ( dev-perl/MP3-Info dev-perl/MP3-Tag )
	spell? ( dev-perl/gtk2-spell )
	stats? ( dev-perl/Date-Calc
		dev-perl/GD[png,truetype] )
	tellico? ( virtual/perl-Digest-MD5
		virtual/perl-MIME-Base64 )
	vorbis? ( dev-perl/Ogg-Vorbis-Header-PurePerl )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.4.0-man.patch"
}

src_install() {
	if [[ -n ${LINGUAS+set} ]]; then
		# LINGUAS is set, let's try to respect it.
		pushd lib/gcstar/GCLang > /dev/null

		mkdir tmp || die "mkdir failed"
		mv ?? tmp || die "mv 1 failed"
		# English version should be always available so we will keep it
		mv tmp/EN . || die "mv 2 failed"

		for x in ${LINGUAS}; do
			# GCstar uses upper-case, 2-letter language codes
			d=$(echo ${x} | tr '[:lower:]' '[:upper:]' | sed -e 's:_.*::')
			if [[ -d "tmp/${d}" ]]; then
				mv "tmp/${d}" . || die "mv 3 failed"
			fi
		done

		rm -rf tmp
		popd > /dev/null
	fi

	# Yes, ED *is* needed here. gcstar's install lacks any concept of DESTDIR.
	./install --prefix="${ED}usr" \
		--noclean --nomenu || die "install script failed"

	domenu share/applications/gcstar.desktop
	for size in 16x16 22x22 24x24 32x32 36x36 48x48 64x64 72x72 96x96 128x128
	do
		insinto /usr/share/icons/hicolor/${size}/apps
		newins share/gcstar/icons/gcstar_${size}.png gcstar.png
	done
	insinto /usr/share/icons/hicolor/scalable/apps
	newins share/gcstar/icons/gcstar_scalable.svg gcstar.svg
	insinto /usr/share/mime/packages
	doins share/applications/gcstar.xml

	dodoc CHANGELOG CHANGELOG.fr README README.fr
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
