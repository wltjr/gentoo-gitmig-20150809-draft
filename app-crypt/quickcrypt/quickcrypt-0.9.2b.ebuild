# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/quickcrypt/quickcrypt-0.9.2b.ebuild,v 1.7 2004/04/28 22:16:18 avenj Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="gives you a quick MD5 Password from any string"
HOMEPAGE="http://linux.netpimpz.com/quickcrypt/"
SRC_URI="http://linux.netpimpz.com/quickcrypt/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha amd64 ~ia64 hppa ~mips"

DEPEND=">=dev-lang/perl-5.6*
	dev-perl/Digest-MD5"

src_install() {
	dobin quickcrypt || die
	dodoc README BUGS
}
