# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ja/manpages-ja-20040615.ebuild,v 1.12 2005/01/01 14:35:19 eradicator Exp $

MY_P="man-pages-ja-${PV}"
GENTOO_MAN_P="portage-${P}"

DESCRIPTION="A collection of manual pages translated into Japanese"
HOMEPAGE="http://www.linux.or.jp/JM/ http://www.gentoo.gr.jp/jpmain/translation.xml"
SRC_URI="http://www.linux.or.jp/JM/${MY_P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${GENTOO_MAN_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc sparc x86"
IUSE=""

DEPEND="!>=sys-apps/groff-1.19
	=sys-apps/groff-1.18*
	sys-apps/man"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! groff -v -Tnippon >/dev/null 2>&1 ; then
		ewarn
		ewarn "You need to compile groff with multilingual support."
		ewarn "Please recompile sys-apps/groff with USE=\"cjk\"."
		ewarn
		die "groff m17n support disabled."
	fi
}

src_compile() {
	return 0
}

src_install() {
	for x in $(grep '^[^#].*' script/pkgs.list | cut -f1 | sort)
	do
		for a in $(ls -d manual/$x/man* 2>/dev/null)
		do
			jmandir=$(echo $a | cut -d/ -f3)

			einfo install $x:  /usr/share/man/ja/$jmandir/

			insinto /usr/share/man/ja/$jmandir
			doins $a/*
		done
	done

	cd ${WORKDIR}/man
	for y in *.[1-9]; do
		einfo install ${y}:  /usr/share/man/ja/man${y##*.}/
		insinto /usr/share/man/ja/man${y##*.}
		doins $y
	done
	cd -

	dodoc ChangeLog INSTALL README
}

pkg_postinst() {
	einfo
	einfo "You need to set appropriate LANG and PAGER variables to use"
	einfo "Japanese manpages."
	einfo "e.g."
	einfo "\tLANG=\"ja_JP.eucJP\""
	einfo "\tPAGER=\"jless\""
	einfo "\tJLESSCHARSET=\"ja\""
	einfo "\texport LANG PAGER JLESSCHARSET"
	einfo "or"
	einfo "\tLANG=\"ja_JP.eucJP\""
	einfo "\tPAGER=\"lv -c\""
	einfo "\texport LANG PAGER"
	einfo
}
