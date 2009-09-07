# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/libffi/libffi-0.ebuild,v 1.17 2009/09/07 14:00:23 armin76 Exp $

EAPI=2

DESCRIPTION="Virtual for dev-libs/libffi"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="static-libs"

RDEPEND="dev-libs/libffi[static-libs?]"
DEPEND=""
