# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-pear/horde-pear-1.3-r1.ebuild,v 1.1 2004/08/15 12:36:30 stuart Exp $

inherit horde

DESCRIPTION="Horde Application Framework PHP PEAR files"
HOMEPAGE="http://www.horde.org/"

KEYWORDS="x86 ppc sparc alpha hppa amd64"

DEPEND=""
RDEPEND=">=dev-php/mod_php-4.1.0
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.21-r1"

S=${WORKDIR}/${HORDE_PN}

pkg_setup() { :;}

src_unpack() {
	unpack ${A}
	sed -i 's:/home/jan/pear_root/share/pear:/usr/lib/php:g' ${S}/pearcmd.php || die
}

src_install() {
	dodir /usr/lib
	cp -a ${S} ${D}/usr/lib/php
	rm ${D}/usr/lib/php/PEAR/Downloader.php #54610
}

pkg_postinst() { :;}
