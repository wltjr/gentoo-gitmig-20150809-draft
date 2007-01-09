# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/irqbalance/irqbalance-0.55.ebuild,v 1.2 2007/01/09 02:28:22 ticho Exp $

inherit eutils

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="http://www.irqbalance.org/"
SRC_URI="http://www.irqbalance.org/releases/${P}.tar.gz"

LICENSE="OSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="=dev-libs/glib-2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	into /
	dosbin irqbalance || die "dosbin failed"
	newinitd "${FILESDIR}"/irqbalance.init irqbalance
}
