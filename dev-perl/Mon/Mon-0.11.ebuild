# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mon/Mon-0.11.ebuild,v 1.2 2001/05/03 16:38:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Monitor Perl Module"
SRC_URI="http://www.cpan.org/modules/by-module/Mon/${A}"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mon/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/Convert-BER-1.31
	>=dev-perl/Net-Telnet-3.02"

RDEPEND="$DEPEND
	>=net-misc/fping-2.2_beta1"

src_compile() {

    perl Makefile.PL
    try make 
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc CHANGES COPYING COPYRIGHT README VERSION
}



