# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/quanta/quanta-3.2.1.ebuild,v 1.4 2004/05/03 22:28:29 centic Exp $

inherit kde
need-kde 3.2

DESCRIPTION="A superb web development tool for KDE 3.x"
HOMEPAGE="http://quanta.sourceforge.net/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"
IUSE="doc"

DEPEND="doc? ( app-doc/quanta-docs )"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

SLOT="0"

