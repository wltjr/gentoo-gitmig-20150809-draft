# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/openafs-kernel/openafs-kernel-1.3.85.ebuild,v 1.2 2005/07/28 12:11:33 seemant Exp $

inherit eutils linux-mod versionator

MY_PN=${PN/-kernel}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
PATCHVER=0.1
DESCRIPTION="The OpenAFS distributed file system kernel module"
HOMEPAGE="http://www.openafs.org/"
SRC_URI="http://openafs.org/dl/${MY_PN}/${PV}/${MY_P}-src.tar.bz2
	mirror://gentoo/${MY_PN}-gentoo-${PATCHVER}.tar.bz2
	http://dev.gentoo.org/~seemant/distfiles/${MY_PN}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="IPL-1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~alpha"

DEPEND="virtual/linux-sources"

PATCHDIR=${WORKDIR}/gentoo/patches/$(get_version_component_range 1-2)/kernel

pkg_setup() {
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}; cd ${S}

	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
}

src_compile() {
	econf --with-linux-kernel-headers=$KERNEL_DIR || die "Failed: econf"
	# unset ARCH, because else it will be used as an incent to start
	# cross-compiling the kernel module
	env -u ARCH make only_libafs || die "Failed: make"
}

src_install() {
	MOD_SRCDIR=$(expr ${S}/src/libafs/MODLOAD-*)
	if [ ! -e ${MOD_SRCDIR}/libafs.${KV_OBJ} ]; then
		cp ${MOD_SRCDIR}/libafs-*.${KV_OBJ} ${MOD_SRCDIR}/libafs.${KV_OBJ} \
			|| die "Couldn't find compiled kernel module"
	fi

	MODULE_NAMES='libafs(openafs:$MOD_SRCDIR)'

	linux-mod_src_install
}

