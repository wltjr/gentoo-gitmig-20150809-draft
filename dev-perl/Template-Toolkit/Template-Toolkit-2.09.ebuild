# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Toolkit/Template-Toolkit-2.09.ebuild,v 1.5 2004/05/26 20:28:22 kloeri Exp $

inherit perl-module

DESCRIPTION="The Template Toolkit"
SRC_URI="http://www.template-toolkit.org/download/${P}.tar.gz"
HOMEPAGE="http://www.template-toolkit.org"
IUSE=""
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/AppConfig-1.52"

#The installer tries to install to /usr/local/tt2...,
#and asks for user input, so we change myconf to ensure that
# 1) make install doesn't violate the sandbox rule
# 2) perl Makefile.pl just uses reasonable defaults, and doesn't ask for input
myconf="${myconf} TT_PREFIX=${D}/usr/share/template-toolkit2 TT_ACCEPT='y'"
