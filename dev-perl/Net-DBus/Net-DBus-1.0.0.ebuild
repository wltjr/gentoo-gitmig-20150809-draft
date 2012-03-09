# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DBus/Net-DBus-1.0.0.ebuild,v 1.5 2012/03/09 09:02:35 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=DANBERR
MODULE_VERSION=1.0.0
inherit perl-module

DESCRIPTION="Perl extension for the DBus message system"

SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ~sparc x86"
IUSE="test"

RDEPEND="
	sys-apps/dbus
	dev-perl/XML-Twig
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
