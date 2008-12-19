# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PAR-Dist/PAR-Dist-0.41.ebuild,v 1.1 2008/12/19 16:45:44 tove Exp $

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Create and manipulate PAR distributions"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	|| ( dev-perl/YAML-Syck dev-perl/yaml )
	dev-perl/Archive-Zip"
	# || ( YAML::Syck YAML YAML-Tiny YAML-XS Parse-CPAN-Meta )

SRC_TEST="do"
