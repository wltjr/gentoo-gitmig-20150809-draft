# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WrapI18N/Text-WrapI18N-0.60.0.ebuild,v 1.1 2011/08/28 12:47:10 tove Exp $

EAPI=4

MODULE_AUTHOR=KUBOTA
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Internationalized substitute of Text::Wrap"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Text-CharWidth"
DEPEND="${RDEPEND}"

SRC_TEST="do"
