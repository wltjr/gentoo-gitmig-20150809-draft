# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.0.4.1-r1.ebuild,v 1.3 2003/02/13 12:10:18 vapier Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="x86 ~ppc ~sparc alpha"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/gnome-mime-data-2.0.1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/bonobo-activation-1.0.3
	>=sys-devel/gettext-0.10.40
	>=dev-libs/openssl-0.9.5
	>=sys-apps/bzip2-1.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.22
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"

src_compile() {
		export DESTDIR=${D}
		gnome2_src_compile 
}

src_install() {
		gnome2_src_install
#there are bettere ways, but that is the quicker
echo "trash:	libvfolder-desktop.so">>${D}/etc/gnome-vfs-2.0/modules/default-modules.conf

}

pkg_preinst () {
	## this check is there because gnome-vfs still adheres the file, though it doesn't need it. backwards compliance isnt always good
	REMOVE="${ROOT}/etc/gnome-vfs-2.0/vfolders/applications.vfolder-info"
	if [ -f ${REMOVE} ] ; then
		rm -f ${REMOVE}
	fi
}

