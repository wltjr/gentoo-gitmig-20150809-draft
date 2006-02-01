# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sancho/sancho-0.11.ebuild,v 1.4 2006/02/01 20:19:06 weeve Exp $

inherit distutils

MY_P=${P/s/S}
DESCRIPTION="Sancho is a unit testing framework"
HOMEPAGE="http://www.mems-exchange.org/software/sancho/"
SRC_URI="http://cheeseshop.python.org/packages/source/S/Sancho/${MY_P}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

S=${WORKDIR}/${MY_P}

src_install() {
	mydoc="CHANGES.txt README.txt"
	distutils_src_install
}
