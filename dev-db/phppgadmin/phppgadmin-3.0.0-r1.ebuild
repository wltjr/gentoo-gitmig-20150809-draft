# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/phppgadmin/phppgadmin-3.0.0-r1.ebuild,v 1.2 2003/07/11 21:04:17 aliz Exp $

IUSE=""
S=${WORKDIR}/${PN}
DESCRIPTION="Web-based administration for Postgres database in php"
SRC_URI="mirror://sourceforge/${PN}/${P}-dev-2.tar.bz2"
HOMEPAGE="http://phppgadmin.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

DEPEND=">=net-www/apache-1.3.24-r1
	>=dev-db/postgresql-7.0.3-r3
	>=dev-php/mod_php-4.1.2-r5"

src_compile() { :; }

src_install() {
	for doc in DEVELOPERS FAQ HISTORY INSTALL LICENSE TODO TRANSLATORS
	do
		dodoc $doc
		rm $doc
	done

	dodir /home/httpd/htdocs/phppgadmin
	cp -ar * ${D}/home/httpd/htdocs/phppgadmin/
}

pkg_postinst() {
	einfo
	einfo "Make sure you edit /home/httpd/htdocs/phppgadmin/conf/config.inc.php"
	einfo
}
