# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ssmtp/ssmtp-2.60.4.ebuild,v 1.1 2003/09/19 12:50:44 aliz Exp $

DESCRIPTION="Extremely simple MTA to get mail off the system to a Mailhub"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/s/ssmtp/${P/-/_}.tar.gz"
HOMEPAGE="ftp://ftp.debian.org/debian/pool/main/s/ssmtp/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips ~amd64 ~ia64"
LICENSE="GPL-2"
IUSE="ssl ipv6 md5sum"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"
RDEPEND="!virtual/mta
	net-mail/mailbase
	ssl? ( dev-libs/openssl )"
PROVIDE="virtual/mta"

S=${WORKDIR}/ssmtp-2.60

src_unpack() {
	unpack ${A} ; cd ${S}

	use ssl && epatch ${FILESDIR}/starttls.diff
}

src_compile() {
	local myconf

	myconf="$( use_enable ssl ) \
		$( use_enable ipv6 inet6 ) \
		$( use_enable md5sum md5suth )"

	econf \
		--sysconfdir=/etc/ssmtp \
		${myconf} || die

	make clean || die
	make etcdir=/etc || die
}

src_install() {
	dodir /usr/bin /usr/sbin /usr/lib
	dosbin ssmtp
	chmod 755 ${D}/usr/sbin/ssmtp
	dosym /usr/sbin/ssmtp /usr/bin/mailq
	dosym /usr/sbin/ssmtp /usr/bin/newaliases
	# Removed symlink due to conflict with mailx
	# See bug #7448
	#dosym /usr/sbin/ssmtp /usr/bin/mail
	dosym /usr/sbin/ssmtp /usr/sbin/sendmail
	dosym /usr/sbin/ssmtp /usr/lib/sendmail
	doman ssmtp.8
	dosym /usr/share/man/man8/ssmtp.8 /usr/share/man/man8/sendmail.8
	dodoc INSTALL README TLS
	newdoc ssmtp-2.60.lsm
	insinto /etc/ssmtp
	doins ssmtp.conf revaliases

	# Set up config file
	# See bug #22658
	#local conffile="/etc/ssmtp/ssmtp.conf"
	#local hostname=`hostname -f`
	#local domainname=`hostname -d`
	#mv ${conffile} ${conffile}.orig
	#sed -e "s:rewriteDomain=:rewriteDomain=${domainname}:g" \
	#        -e "s:_HOSTNAME_:${hostname}:" \
	#        -e "s:^mailhub=mail:mailhub=mail.${domainname}:g" \
	#        ${conffile}.orig > ${conffile}.pre
	#if [ `use ssl` ];
	#then
	#        sed -e "s:^#UseTLS=YES:UseTLS=YES:g" \
	#                ${conffile}.pre > ${conffile}
	#        mv ${conffile}.pre ${conffile}.orig
	#else
	#        mv ${conffile}.pre ${conffile}
	#fi
}



