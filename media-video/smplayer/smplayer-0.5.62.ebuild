# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.5.62.ebuild,v 1.2 2008/02/01 09:03:04 opfer Exp $

inherit eutils qt4

DESCRIPTION="Great front-end for mplayer written in Qt4"
HOMEPAGE="http://smplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(qt4_min_version 4.2)"
RDEPEND="${DEPEND}
	>media-video/mplayer-1.0_rc1"

LANGS="bg cs de en_US es fr hu it ja ka nl pl pt_BR pt_PT sk sr sv tr zh_CN zh_TW"
NOLONGLANGS="ro_RO ru_RU uk_UA"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_compile() {
	local MY_SVNREV="UNKNOWN"
	echo "SVN-r${MY_SVNREV}" > svn_revision.txt
	echo "#define SVN_REVISION \"SVN-r${MY_SVNREV}\"" > src/svn_revision.h

	# Fix paths in Makefile and allow parallel building
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^CONF_PREFIX=/s:\$(PREFIX)::" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/get_svn_revision.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"

	eqmake4 src/${PN}.pro -o src/Makefile
	emake || die "emake failed"

	# Generate translations
	cd "${S}"/src/translations
	local LANG=
	for LANG in ${LINGUAS}; do
		if has ${LANG} ${LANGS}; then
			einfo "Generating ${LANG} translation ..."
			lrelease ${PN}_${LANG}.ts || die "Failed to generate ${LANG} translation!"
			continue
		elif [[ " ${NOLONGLANGS} " == *" ${LANG}_"* ]]; then
			local X=
			for X in ${NOLONGLANGS}; do
				if [[ "${LANG}" == "${X%_*}" ]]; then
					einfo "Generating ${X} translation ..."
					lrelease ${PN}_${X}.ts || die "Failed to generate ${X} translation!"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA."
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
