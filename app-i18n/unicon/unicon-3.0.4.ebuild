# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/unicon/unicon-3.0.4.ebuild,v 1.8 2005/01/02 19:39:51 dsd Exp $

inherit eutils

# This release was taken from debian sources. For some reason I can't
# find this release on turbolinux's site. Even Mandrake is using the
# older 3.0.3.

# TODO: Figure out how to build the kernel-modules.

DESCRIPTION="CJK (Chinese/Japanese/Korean) console input, display system and input modules."
HOMEPAGE="http://www.gnu.org/directory/UNICON.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/linux-sources
	dev-libs/newt
	dev-libs/pth"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/unicon-3.0.4-debian.patch
	epatch ${FILESDIR}/unicon-3.0.4-gentoo.patch
}

src_compile() {
	econf || die "econf failed"

	emake -j1 || die "make failed"
	emake data -j1 || die "make data failed"

	cd ${S}/tools
	emake -j1 || die "make tools failed"

	# still has gcc-3.2 issues
	# make -C sfonts/tools || die "make tools failed"
}

src_install() {
	make prefix=${D}/usr install || die "install failed"

	# still has gcc-3.2 issues
	# dobin sfonts/tools/sfont
	dobin tools/uniconcfg
	dobin tools/uniconctrl

	make prefix=${D}/usr data-install || die "install data failed"

	dobin scripts/unicon-start

}
