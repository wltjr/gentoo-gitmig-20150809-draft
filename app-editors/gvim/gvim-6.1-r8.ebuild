# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-6.1-r8.ebuild,v 1.1 2003/03/23 20:36:26 agriffis Exp $

IUSE="gnome gpm gtk gtk2 nls perl python ruby X"
VIMPATCH="411"
inherit vim

DESCRIPTION="Graphical Vim"
KEYWORDS="x86 ~ppc ~sparc alpha"
DEPEND="dev-util/cscope
	>=sys-libs/ncurses-5.2-r2
	>=app-editors/vim-core-6.1-r5
	x11-base/xfree
	gpm?	( >=sys-libs/gpm-1.19.3 )
	gnome?	( gnome-base/gnome-libs )
	gtk?	( =x11-libs/gtk+-1.2* )
	gtk2?	( >=x11-libs/gtk+-2.1
				virtual/xft )
	perl?	( dev-lang/perl )
	python? ( dev-lang/python )
	ruby?	( >=dev-lang/ruby-1.6.4 )"

src_unpack() {
	vim_src_unpack

	use gtk2 \
		&& EPATCH_SUFFIX="gz" EPATCH_FORCE="yes" \
			epatch ${WORKDIR}/gentoo/patches-gvim/*
}
