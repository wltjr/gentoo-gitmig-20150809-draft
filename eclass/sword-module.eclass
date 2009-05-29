# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/sword-module.eclass,v 1.2 2009/05/29 18:46:24 beandog Exp $

#
# eclass to simplify installation of Sword modules
# Bugs to theology@gentoo.org
#

HOMEPAGE="http://www.crosswire.org/sword/modules/"

# Sword packages are generally released as FooBar.zip in their 'rawzip' form
# The files are also unversioned, so the packager will need to rename the
# original file to something else and host it somewhere to avoid breaking
# the digest when new versions are released.

SRC_URI="mirror://gentoo/${SWORD_MODULE}-${PV}.zip"

SLOT="0"
IUSE=""

S="${WORKDIR}"

RDEPEND="app-text/sword"
DEPEND="app-arch/unzip"

sword-module_src_install() {
	insinto /usr/share/sword/modules
	doins -r "${S}"/modules/*
	insinto /usr/share/sword/mods.d
	doins "${S}"/mods.d/*
}

EXPORT_FUNCTIONS src_install
