# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.39-r1.ebuild,v 1.1 2002/07/03 20:02:00 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND="${DEPEND}
	dev-perl/XML-RegExp"
