# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.11.ebuild,v 1.1 2004/08/18 13:12:43 karltk Exp $

inherit flag-o-matic

DESCRIPTION="Stratego term-rewriting language"
HOMEPAGE="http://www.stratego-language.org/"
SRC_URI="ftp://ftp.stratego-language.org/pub/stratego/StrategoXT/strategoxt-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-libs/aterm-2.2
	>=dev-libs/sdf2-bundle-2.2"
#	>=dev-libs/cpl-stratego-0.4"
S=${WORKDIR}/strategoxt-${PV}

src_compile() {
	filter-flags -fomit-frame-pointer
	econf || die "econf failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	insinto /etc/env.d
	doins ${FILESDIR}/42stratego
}
