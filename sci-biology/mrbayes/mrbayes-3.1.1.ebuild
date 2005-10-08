# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mrbayes/mrbayes-3.1.1.ebuild,v 1.2 2005/10/08 20:10:26 fuzzyray Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Bayesian Inference of Phylogeny"
HOMEPAGE="http://mrbayes.csit.fsu.edu/"
SRC_URI="mirror://sourceforge/${PN}/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc-macos x86"
IUSE="mpi"

DEPEND="mpi? ( virtual/mpi )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s:OPTFLAGS ?= -O3:OPTFLAGS = ${CFLAGS}:" \
		-e "s:CC = gcc:CC = $(tc-getCC):" \
		-i Makefile || die
	if use mpi; then
		sed -e "s:MPI ?= no:MPI=yes:" -i Makefile || die
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin mb
	dodoc readme.txt
}
