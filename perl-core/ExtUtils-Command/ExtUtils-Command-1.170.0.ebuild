# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.170.0.ebuild,v 1.7 2012/02/14 11:13:47 aballier Exp $

EAPI=3

MODULE_AUTHOR=FLORA
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST=do
