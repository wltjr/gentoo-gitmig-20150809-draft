# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.5-r2.ebuild,v 1.5 2004/06/25 01:15:17 agriffis Exp $

inherit eutils

W3M_CVS_PV="1.912"
W3M_CVS_P="${PN}-cvs-${W3M_CVS_PV}"

DESCRIPTION="Text based WWW browser, supports tables and frames"
HOMEPAGE="http://w3m.sourceforge.net/
	http://www.page.sannet.ne.jp/knabe/w3m/w3m.html"
PATCH_PATH="http://www.page.sannet.ne.jp/knabe/w3m/"
SRC_URI="mirror://sourceforge/w3m/${P}.tar.gz
	async? ( ${PATCH_PATH}/${W3M_CVS_P}-async-1.diff.gz )
	nls? ( ${PATCH_PATH}/${W3M_CVS_P}-nlscharset-1.diff )"
# w3m color patch:
#	http://homepage3.nifty.com/slokar/w3m/${P}-cvs-1.895_256-001.patch.gz
# w3n canna inline patch:
#	canna? ( http://www.j10n.org/files/${W3M_CVS_P}-canna.patch )
# w3m bookmark charset patch:
#	nls? ( ${PATCH_PATH}/${W3M_CVS_P}-bkmknls-1.diff )

LICENSE="w3m"
SLOT="0"
KEYWORDS="x86 alpha ~ppc sparc"
IUSE="X gtk imlib imlib2 xface ssl migemo gpm cjk nls async"
#IUSE="canna unicode"

# canna? ( app-i18n/canna )
DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	>=dev-libs/boehm-gc-6.2
	X? ( gtk? ( >=media-libs/gdk-pixbuf-0.22.0 )
		!gtk? ( imlib2? ( >=media-libs/imlib2-1.1.0 )
			!imlib2? ( >=media-libs/imlib-1.9.8 ) )
	)
	!X? ( imlib2? ( >=media-libs/imlib2-1.1.0 ) )
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	migemo? ( >=app-text/migemo-0.40 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"
PROVIDE="virtual/textbrowser
	virtual/w3m"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${PN}-w3mman-gentoo.diff
	epatch ${FILESDIR}/${PN}-m17n-search-gentoo.diff
	epatch ${FILESDIR}/${PN}-libwc-gentoo.diff
	if use nls ; then
		#epatch ${DISTDIR}/${W3M_CVS_P}-bkmknls-1.diff
		epatch ${DISTDIR}/${W3M_CVS_P}-nlscharset-1.diff
	fi
	if use async ; then
		epatch ${DISTDIR}/${W3M_CVS_P}-async-1.diff.gz
		epatch ${FILESDIR}/${PN}-0.4.2-async-m17n-gentoo.diff
	fi
	#epatch ${DISTDIR}/${P}-cvs-1.895_256-001.patch.gz
	#use canna && epatch ${DISTDIR}/${W3M_CVS_P}-canna.patch
}

src_compile() {
	local myconf migemo_command imagelib

	if use X ; then
		myconf="${myconf} --enable-image=x11,fb `use_enable xface`"
		if use gtk ; then
			imagelib="gdk-pixbuf"
		elif use imlib2 ; then
			imagelib="imlib2"
		else
			imagelib="imlib"
		fi
	else	# no X
		if use imlib2 ; then
			myconf="${myconf} --enable-image=fb"
			imagelib="imlib2"
		else
			myconf="${myconf} --enable-image=no"
			imagelib="no"
		fi
	fi

	if use migemo ; then
		migemo_command="migemo -t egrep /usr/share/migemo/migemo-dict"
	else
		migemo_command="no"
	fi

	# emacs-w3m doesn't like "--enable-m17n --disable-unicode,"
	# so we better enable or disable both. Default to enable
	# m17n and unicode, see bug #47046.
	if use cjk ; then
		myconf="${myconf}
			--enable-japanese=E
			--with-charset=EUC-JP"
	else
		myconf="${myconf}
			--with-charset=US-ASCII"
	fi

	econf --enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		--with-imagelib="${imagelib}" \
		--with-migemo="${migemo_command}" \
		--enable-m17n \
		--enable-unicode \
		`use_enable gpm mouse` \
		`use_enable ssl digest-auth` \
		`use_with ssl` \
		`use_enable nls` \
		${myconf} "$@" || die
		# `use_with canna`

	# emake borked
	emake -j1 all || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	if use cjk ; then
		docinto doc-jp ; dodoc doc-jp/*
	else
		rm -rf ${D}/usr/share/man/ja
	fi
}
