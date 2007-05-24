# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_fcgid/mod_fcgid-2.1-r1.ebuild,v 1.2 2007/05/24 20:14:16 phreak Exp $

inherit apache-module eutils multilib

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="mod_fcgid is a binary-compatible alternative to mod_fastcgi with better process management."
HOMEPAGE="http://fastcgi.coremail.cn/"
SRC_URI="mirror://sourceforge/mod-fcgid/${PN}.${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}.${PV}"

#APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FCGID"

APXS2_ARGS="-I ${S} -c ${PN}.c fcgid_bridge.c \
			fcgid_conf.c fcgid_pm_main.c \
			fcgid_spawn_ctl.c mod_fcgid.rc fcgid_bucket.c \
			fcgid_filter.c fcgid_protocol.c \
			arch/unix/fcgid_pm_unix.c \
			arch/unix/fcgid_proctbl_unix.c \
			arch/unix/fcgid_proc_unix.c"

DOCFILES="AUTHOR ChangeLog"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-apr_shm_remove.patch

	# Fix the stupid Makefile, assuming our builddir is in /usr/local
	sed -e "s,^top_dir.*=.*,top_dir = /usr/$(get_libdir)/apache2," -i Makefile
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed!"

	# Once APACHE2_MOD_CONF is able to use newconfd (probably never), this line
	# should go.
	insinto ${APACHE2_MODULES_CONFDIR}
	newins "${FILESDIR}"/20_mod_fcgid-${PV}.conf 20_mod_fcgid.conf
}
