# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-hmmer/embassy-hmmer-2.1.1-r1.ebuild,v 1.6 2005/08/07 21:41:10 ribosome Exp $

EBOV="2.10.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of HMMER - Biological sequence analysis with profile HMMs"

KEYWORDS="ppc ppc-macos x86"

src_install() {
	embassy_src_install
	insinto /usr/include/emboss/hmmer
	doins src/*.h
}
