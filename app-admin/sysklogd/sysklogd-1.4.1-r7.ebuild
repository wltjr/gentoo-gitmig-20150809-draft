# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysklogd/sysklogd-1.4.1-r7.ebuild,v 1.10 2004/06/25 23:01:49 vapier Exp $

inherit eutils

DESCRIPTION="Standard log daemons"
HOMEPAGE="http://www.infodrom.org/projects/sysklogd/"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/daemons/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="dev-lang/perl sys-apps/debianutils"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O3:${CFLAGS}:" Makefile
	if [ "${ARCH}" = "mips" ]
	then
		cd ${S}
		epatch ${FILESDIR}/${PN}-1.4.1-mips.patch
	fi
}

src_compile() {
	emake LDFLAGS="" || die
}

src_install() {
	dosbin syslogd klogd ${FILESDIR}/syslogd-listfiles
	doman *.[1-9] ${FILESDIR}/syslogd-listfiles.8
	exeinto /etc/cron.daily
	newexe ${FILESDIR}/syslog-cron syslog.cron
	dodoc ANNOUNCE CHANGES MANIFEST NEWS README.1st README.linux
	dodoc ${FILESDIR}/syslog.conf
	insinto /etc
	doins ${FILESDIR}/syslog.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/sysklogd.rc6 sysklogd
	insinto /etc/conf.d
	newins ${FILESDIR}/sysklogd.confd sysklogd
}
