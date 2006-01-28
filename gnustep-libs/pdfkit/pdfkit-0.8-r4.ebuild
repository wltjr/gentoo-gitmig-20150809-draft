# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/pdfkit/pdfkit-0.8-r4.ebuild,v 1.4 2006/01/28 18:10:51 blubb Exp $

inherit gnustep

S=${WORKDIR}/${PN/pdfk/PDFK}

DESCRIPTION="PDFKit is a framework that supports rendering of PDF content in GNUstep applications"
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/${P/pdfk/PDFK}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	!gnustep-libs/imagekits"
RDEPEND="${GS_RDEPEND}
	!gnustep-libs/imagekits"

egnustep_install_domain "System"

src_unpack()
{
	unpack ${A}
	cd ${S}
	( cd xpdf/xpdf-3.00/xpdf; epatch ${FILESDIR}/xpdf-3.00-CESA-2004-007.diff )
	( cd xpdf/xpdf-3.00/goo; epatch ${FILESDIR}/xpdf-goo-sizet.patch )
	( cd xpdf/xpdf-3.00/xpdf; epatch ${FILESDIR}/xpdf-3.00pl2.patch )
	( cd xpdf/xpdf-3.00/xpdf; epatch ${FILESDIR}/xpdf-3.00pl3.patch )
}
