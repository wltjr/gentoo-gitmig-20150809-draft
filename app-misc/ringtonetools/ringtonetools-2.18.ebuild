# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ringtonetools/ringtonetools-2.18.ebuild,v 1.4 2004/06/28 04:09:54 vapier Exp $

DESCRIPTION="Ringtone Tools is a program for creating ringtones and logos for mobile phones"
HOMEPAGE="http://ringtonetools.mikekohn.net/"
SRC_URI="http://www.mikekohn.com/ringtonetools/${P}.tar.gz"

LICENSE="ringtonetools"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake FLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ringtonetools || die
	dodoc docs/*
	docinto samples
	dodoc samples/*
}
