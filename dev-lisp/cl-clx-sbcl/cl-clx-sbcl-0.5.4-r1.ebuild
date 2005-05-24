# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-clx-sbcl/cl-clx-sbcl-0.5.4-r1.ebuild,v 1.5 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CLX for SBCL"
HOMEPAGE="http://ftp.linux.org.uk/pub/lisp/sbcl/ http://www.cliki.net/CLX"
SRC_URI="http://ftp.linux.org.uk/pub/lisp/sbcl/clx_${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/sbcl"

CLPACKAGE=clx

S=${WORKDIR}/clx_${PV}

src_unpack() {
	unpack ${A}
	# this patch prevents building on clisp or cmucl
	epatch ${FILESDIR}/${PV}-gentoo.patch
	find ${S} -type d -name CVS -exec rm -rf \;
}

src_install() {
	for i in . demo test debug; do
		insinto /usr/share/common-lisp/source/clx/${i}
		doins ${S}/${i}/*.lisp
	done
	insinto /usr/share/common-lisp/source/clx
	doins clx.asd
	common-lisp-system-symlink
	dodoc CHANGES NEWS README*
}
