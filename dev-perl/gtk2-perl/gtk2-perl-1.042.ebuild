# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-perl/gtk2-perl-1.042.ebuild,v 1.3 2004/07/14 17:44:43 agriffis Exp $

inherit perl-module

MY_P=Gtk2-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl bindings for GTK2"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${MY_P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2*
	>=dev-perl/glib-perl-${PV}
	>=dev-perl/extutils-depends-0.2*
	dev-perl/extutils-pkgconfig"
