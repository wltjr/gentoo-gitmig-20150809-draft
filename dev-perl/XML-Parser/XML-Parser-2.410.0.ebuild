# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Parser/XML-Parser-2.410.0.ebuild,v 1.3 2012/04/02 16:44:22 ago Exp $

EAPI=4

MODULE_AUTHOR=TODDR
MODULE_VERSION=2.41
inherit perl-module multilib

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-libs/expat-1.95.1-r1"
DEPEND="${RDEPEND}"

SRC_TEST=do
myconf="EXPATLIBPATH='${EPREFIX}/usr/$(get_libdir)' EXPATINCPATH='${EPREFIX}/usr/include'"
