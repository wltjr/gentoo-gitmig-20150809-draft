# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/mldonkey/mldonkey-1.16.ebuild,v 1.1 2002/06/16 00:09:09 bass Exp $

myarch=`uname -m`
S="${WORKDIR}/${PN}-shared"
DESCRIPTION="A new client for eDonkey, for file sharing."
SRC_URI="http://freesoftware.fsf.org/download/mldonkey/${P}.shared.${myarch}-Linux.tar.bz2"
HOMEPAGE="http://go.to/mldonkey"
LICENSE="GPL-2"
DEPEND="${RDEPEND}"
RDEPEND="gtk? ( x11-libs/gtk+ )"
SLOT="0"

src_compile() {
	einfo "Nothing to compile for ${P}."
}
src_install () {
	dodoc ChangeLog Readme.txt TODO
	rm -f ${WORKDIR}/mldonkey-shared/ChangeLog
	rm -f ${WORKDIR}/mldonkey-shared/Readme.txt
	rm -f ${WORKDIR}/mldonkey-shared/TODO
	rm -f ${WORKDIR}/mldonkey-shared/mldonkey_gui_started_for_macosx
	dodir /opt/mldonkey
	cp -r ${WORKDIR}/mldonkey-shared/* ${D}/opt/mldonkey
	insinto /etc/env.d
	doins ${FILESDIR}/97mldonkey
}
pkg_postinst () {
	einfo "The client command is mldonkey."
	einfo "The GUI needs GTK and the command is mldonkey_gui"
	einfo "mldonkey read the config from the dir where you are, and"
	einfo "create it if don't exist, so run the command ever in the"
	einfo "ever in the same dir. I spear to solve it in next relase"
}
