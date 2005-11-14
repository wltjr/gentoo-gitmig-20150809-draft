# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/geda-suite/geda-suite-20050820.ebuild,v 1.2 2005/11/14 20:29:33 plasmaroo Exp $

HOMEPAGE="http://www.geda.seul.org"
DESCRIPTION="geda-suite is a metapackage which compiles all the necessary components you would expect for a full-featured gEDA/gaf system"
IUSE=''
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

RDEPEND=">=sci-electronics/geda-20050820
	>=sci-electronics/gerbv-1.0.1
	>=sci-electronics/gnucap-20050808
	>=sci-electronics/gwave-20031224
	>=sci-electronics/pcb-20050609
	>=sci-electronics/iverilog-0.8
	>=sci-electronics/ng-spice-rework-15
	>=sci-electronics/gnetman-0.0.1_pre20041222
	sci-electronics/gtkwave"
