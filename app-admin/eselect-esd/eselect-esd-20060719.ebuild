# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-esd/eselect-esd-20060719.ebuild,v 1.6 2006/07/29 13:10:05 grobian Exp $

DESCRIPTION="Manages configuration of ESounD implementation or PulseAudio wrapper."
HOMEPAGE="http://www.gentoo.org/"

SRC_URI="mirror://gentoo/esd.eselect-${PVR}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.2
	!<media-sound/esound-0.2.36-r2"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${WORKDIR}/esd.eselect-${PVR}" esd.eselect
}
