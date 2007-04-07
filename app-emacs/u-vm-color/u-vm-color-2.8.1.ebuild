# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/u-vm-color/u-vm-color-2.8.1.ebuild,v 1.1 2007/04/07 19:59:59 opfer Exp $

inherit elisp

DESCRIPTION="Color schemes for VM"
HOMEPAGE="http://ulf.epplejasper.de/EmacsVM.html"
# taken from http://ulf.epplejasper.de/downloads/${PN}.el
SRC_URI="mirror://gentoo/${P}.el.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="app-emacs/vm"
RDEPEND="${DEPEND}"

SIMPLE_ELISP=t
SITEFILE=51${PN}-gentoo.el
