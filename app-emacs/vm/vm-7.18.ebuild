# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-7.18.ebuild,v 1.2 2004/04/06 03:49:26 vapier Exp $

inherit elisp eutils

DESCRIPTION="An emacs major mode for reading and writing e-mail with support for GPG and MIME."
SRC_URI="ftp://ftp.uni-mainz.de/pub/software/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.wonderworks.com/vm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	virtual/emacs"

SITEFILE=50vm-gentoo.el

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/vm-direntry-fix-gentoo.patch
}

src_compile() {
	make prefix=${D}/usr \
		INFODIR=${D}/usr/share/info \
		LISPDIR=${D}/${SITELISP}/vm \
		PIXMAPDIR=${D}/${SITELISP}/etc/${PN} \
		all || die
}

src_install() {
	make prefix=${D}/usr \
		INFODIR=${D}/usr/share/info \
		LISPDIR=${D}/${SITELISP}/vm \
		PIXMAPDIR=${D}/${SITELISP}/etc/${PN} \
		install || die
	elisp-install ${PN} *.el
	elisp-site-file-install ${FILESDIR}/50vm-gentoo.el
	dodoc COPYING README
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
