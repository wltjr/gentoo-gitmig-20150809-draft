# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/daemontools-man/daemontools-man-20020131.ebuild,v 1.17 2005/01/01 13:05:32 eradicator Exp $

DESCRIPTION="Man pages for daemontools"
HOMEPAGE="http://smarden.org/pape/djb/manpages/"
SRC_URI="http://smarden.org/pape/djb/manpages/daemontools-0.76-man-20020131.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips sparc ppc ppc64 x86"
IUSE=""

DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/man"

S=${WORKDIR}/${PN}

src_install() {
	dodoc README
	doman *.8
}
