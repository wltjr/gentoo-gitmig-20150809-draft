# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalyptus/kalyptus-3.5.0.ebuild,v 1.2 2005/12/12 19:32:51 josejx Exp $

KMNAME=kdebindings
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE bindings generator for C, ObjC and Java"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-lang/perl"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

# Weird build system, weirder errors.
# You're welcome to fix this in a better way --danarmak
src_compile () {
	export S=$S/kalyptus
	kde-meta_src_compile
}

src_install() {
	cd $S/kalyptus
	make install DESTDIR=$D
}