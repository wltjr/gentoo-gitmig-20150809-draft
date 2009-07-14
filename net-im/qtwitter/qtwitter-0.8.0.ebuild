# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qtwitter/qtwitter-0.8.0.ebuild,v 1.1 2009/07/14 19:03:01 hwoarang Exp $

EAPI="2"

inherit qt4

DESCRIPTION="A Qt-based client for Twitter and Identi.ca"
HOMEPAGE="http://www.qt-apps.org/content/show.php/qTwitter?content=99087"
SRC_URI="http://files.ayoy.net/qtwitter/release/${PV}/src/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +oauth"

DEPEND="x11-libs/qt-gui:4
	oauth? ( dev-libs/qoauth )"
RDEPEND="${DEPEND}"

LANGS="pt_BR"
LANGSLONG="ca_ES de_DE es_ES fr_FR it_IT ja_JP pl_PL"

src_prepare() {
	qt4_src_prepare
	echo "CONFIG += nostrip" >> "${S}"/${PN}.pro

	local langs=
	for lingua in $LINGUAS; do
		if has $lingua $LANGS; then
			langs="$langs loc/${PN}_${lingua}.ts"
		else
			for a in $LANGSLONG; do
				if [[ $lingua == ${a%_*} ]]; then
					langs="$langs loc/${PN}_${a}.ts"
				fi
			done
		fi
	done

	# remove translations and add only the selected ones
	sed -i -e '/^ *loc.*\.ts/d' \
	    -e "/^TRANSLATIONS/s:loc.*:${langs}:" \
	        qtwitter-app/qtwitter-app.pro || die "sed failed"
	# first line fixes bug about unsecure runpaths
	# second disables docs installation by make (done by dodoc in install)
	sed -i -e '/-Wl,-rpath,\$\${TOP}/d' \
	    -e '/doc \\/d' \
	    qtwitter-app/qtwitter-app.pro || die "sed failed"

	sed -i "s!\(\$\${INSTALL_PREFIX}\)/lib!\1/$(get_libdir)!" \
		twitterapi/twitterapi.pro urlshortener/urlshortener.pro || die "sed failed"

	use oauth || sed -i '/DEFINES += OAUTH/d' ${PN}.pri
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README CHANGELOG || die "dodoc failed"
}
