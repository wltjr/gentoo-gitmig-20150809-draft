# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.2.1-r1.ebuild,v 1.2 2004/08/14 18:37:04 swegener Exp $

inherit eutils ssl-cert

MY_P=Unreal${PV}

DESCRIPTION="aimed to be an advanced (not easy) IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="http://www.gower.net/unrealircd/${MY_P}.tar.gz
	ftp://unreal.secure-tech.net/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="hub ipv6 ssl zlib"

RDEPEND="ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/Unreal3.2

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:ircd\.pid:/var/run/unrealircd/ircd.pid:" \
		-e "s:ircd\.log:/var/log/unrealircd/ircd.log:" \
		-e "s:debug\.log:/var/log/unrealircd/debug.log:" \
		-e "s:ircd\.tune:/var/lib/unrealircd/ircd.tune:" \
		include/config.h
}

src_compile() {
	econf \
		--with-listen=5 \
		--with-dpath=${D}/etc/unrealircd \
		--with-spath=/usr/bin/unrealircd \
		--with-nick-history=2000 \
		--with-sendq=3000000 \
		--with-bufferpool=18 \
		--with-hostname=$(hostname -f) \
		--with-permissions=0600 \
		--with-fd-setsize=1024 \
		--enable-dynamic-linking \
		$(use_enable zlib ziplinks) \
		$(use_enable ssl) \
		$(use_enable hub) \
		$(use_enable ipv6 inet6) \
		|| die "econf failed"

	sed -i \
		-e "s:${D}::" \
		include/setup.h \
		ircdcron/ircdchk

	emake IRCDDIR=/etc/unrealircd || die "emake failed"
}

src_install() {
	keepdir /var/{lib,log,run}/unrealircd

	newbin src/ircd unrealircd

	exeinto /usr/lib/unrealircd/modules
	doexe src/modules/*.so

	dodir /etc/unrealircd
	dosym /var/lib/unrealircd /etc/unrealircd/tmp

	insinto /etc/unrealircd
	doins badwords.*.conf help.conf spamfilter.conf
	newins doc/example.conf unrealircd.conf

	use ssl \
		&& docert server.cert \
		&& dosym server.cert.key /etc/unrealircd/server.key.pem

	sed -i \
		-e s:src/modules:/usr/lib/unrealircd/modules: \
		-e s:ircd\\.log:/var/log/unrealircd/ircd.log: \
		${D}/etc/unrealircd/unrealircd.conf

	dodoc Changes Donation Unreal.nfo ircdcron/{ircd.cron,ircdchk}
	dohtml doc/*.html

	exeinto /etc/init.d
	newexe ${FILESDIR}/unrealircd.rc unrealircd
	insinto /etc/conf.d
	newins ${FILESDIR}/unrealircd.confd unrealircd

	fperms 700 /etc/unrealircd
}

pkg_postinst() {
	enewuser unrealircd
	chown unrealircd \
		${ROOT}/{etc,var/{lib,log,run}}/unrealircd \
		${ROOT}/etc/unrealircd/server.cert.{key,pem} \
		${ROOT}/etc/unrealircd/*.conf

	einfo
	einfo "UnrealIRCd will not run until you've set up /etc/unrealircd/unrealircd.conf"
	einfo
	einfo "You can find example cron scripts here:"
	einfo "   /usr/share/doc/${PF}/ircd.cron.gz"
	einfo "   /usr/share/doc/${PF}/ircdchk.gz"
	einfo
	einfo "You can also use /etc/init.d/unrealircd to start at boot"
	einfo
	einfo "With this revision the hub support in UnrealIRCd is optional."
	einfo "Set USE=\"hub\" if you need it."
	einfo
}
