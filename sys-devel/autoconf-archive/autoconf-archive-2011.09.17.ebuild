# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2011.09.17.ebuild,v 1.2 2011/11/21 15:17:05 jlec Exp $

EAPI=4

DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://www.gnu.org/software/autoconf-archive/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_install() {
	default
	rm -rf "${ED}/usr/share/${PN}" || die
}
