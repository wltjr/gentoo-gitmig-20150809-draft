# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.1.23-r3.ebuild,v 1.1 2005/05/21 20:27:42 lanius Exp $

inherit eutils flag-o-matic pam

MY_P=${P/_/}

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"
SRC_URI="ftp://ftp2.easysw.com/pub/cups/test/${MY_P}-source.tar.bz2
ftp://ftp.easysw.com/pub/cups/test/${MY_P}-source.tar.bz2
ftp://ftp.funet.fi/pub/mirrors/ftp.easysw.com/pub/cups/test/${MY_P}-source.tar.bz2
http://www.srz.de/Members/bla/cups/filter/pdftops/pdftops.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="ssl slp pam samba nls cjk"

DEP="pam? ( virtual/pam )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	slp? ( >=net-libs/openslp-1.0.4 )
	nls? ( sys-devel/gettext )
	>=media-libs/libpng-1.2.1
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b"
DEPEND="${DEP}
	>=sys-devel/autoconf-2.58"
RDEPEND="${DEP}
	!virtual/lpr
	app-text/xpdf"
PDEPEND="samba? ( >=net-fs/samba-3.0.8 )"
PROVIDE="virtual/lpr"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/disable-strip.patch
	epatch ${FILESDIR}/cups-gcc4-amd64.patch #79791
	WANT_AUTOCONF=2.5 autoconf || die

	# disable builtin xpdf
	sed -i -e "s:pdftops::" Makefile
}

src_compile() {

	local myconf
	use amd64 && replace-flags -Os -O2
	use pam || myconf="${myconf} --disable-pam"
	use ssl || myconf="${myconf} --disable-ssl"
	use slp || myconf="${myconf} --disable-slp"
	use nls || myconf="${myconf} --disable-nls"

	./configure \
		--with-cups-user=lp \
		--with-cups-group=lp \
		--host=${CHOST} ${myconf} || die "bad ./configure"

	make || die "compile problem"
}

src_install() {
	dodir /var/spool /var/log/cups /etc/cups

	make \
	LOCALEDIR=${D}/usr/share/locale \
	DOCDIR=${D}/usr/share/cups/docs \
	REQUESTS=${D}/var/spool/cups \
	SERVERBIN=${D}/usr/$(get_libdir)/cups \
	DATADIR=${D}/usr/share/cups \
	INCLUDEDIR=${D}/usr/include \
	AMANDIR=${D}/usr/share/man \
	PMANDIR=${D}/usr/share/man \
	MANDIR=${D}/usr/share/man \
	SERVERROOT=${D}/etc/cups \
	LOGDIR=${D}/var/log/cups \
	SBINDIR=${D}/usr/sbin \
	PAMDIR=${D}/etc/pam.d \
	EXEC_PREFIX=${D}/usr \
	LIBDIR=${D}/usr/$(get_libdir) \
	BINDIR=${D}/usr/bin \
	bindir=${D}/usr/bin \
	INITDIR=${D}/etc \
	PREFIX=${D} \
	install || die "install problem"

	dodoc {CHANGES,CREDITS,ENCRYPTION,LICENSE,README}.txt
	dosym /usr/share/cups/docs /usr/share/doc/${PF}/html

	# cleanups
	rm -rf ${D}/etc/init.d
	rm -rf ${D}/etc/pam.d
	rm -rf ${D}/etc/rc*
	rm -rf ${D}/usr/share/man/cat*
	rm -rf ${D}/etc/cups/{certs,interfaces,ppd}
	rm -rf ${D}/var

	sed -i -e "s:^#\(DocumentRoot\).*:\1 /usr/share/cups/docs:" \
		-e "s:^#\(SystemGroup\).*:\1 lp:" \
		-e "s:^#\(User\).*:\1 lp:" \
		-e "s:^#\(Group\).*:\1 lp:" \
		${D}/etc/cups/cupsd.conf

	pamd_mimic_system cups auth account

	newinitd ${FILESDIR}/cupsd.rc6 cupsd
	insinto /etc/xinetd.d ; newins ${FILESDIR}/cups.xinetd cups-lpd

	# allow raw printing
	dosed "s:#application/octet-stream:application/octet-stream" /etc/cups/mime.types /etc/cups/mime.conv

	# Let foreign charset PDF's print. (Bug: 67493)
	dosym /etc/xpdfrc /etc/cups/pdftops.conf

	# install pdftops filter
	exeinto /usr/lib/cups/filter/
	newexe ${DISTDIR}/pdftops.pl pdftops
	dosed "s:/usr/local:/usr:" /usr/lib/cups/filter/pdftops
}

pkg_postinst() {
	install -d -m0755 ${ROOT}/var/log/cups
	install -d -m0755 ${ROOT}/var/spool
	install -m0700 -o lp -d ${ROOT}/var/spool/cups
	install -m1700 -o lp -d ${ROOT}/var/spool/cups/tmp
	install -m0711 -o lp -d ${ROOT}/etc/cups/certs
	install -d -m0755 ${ROOT}/etc/cups/{interfaces,ppd}

	einfo "If you're using a USB printer, \"emerge coldplug; rc-update add"
	einfo "coldplug boot\" is something you should probably do. This"
	einfo "will allow any USB kernel modules (if present) to be loaded"
	einfo "automatically at boot."
	einfo
	einfo "For more information about installing a printer take a look at:"
	einfo "http://www.gentoo.org/doc/en/printing-howto.xml."

	if useq cjk ; then
		einfo
		einfo "If you want CJK support on PDF's you'll need to re-emerge"
		einfo "appt-text/xpdf with your LINGUAS variable set instead of"
		einfo "the CJK flag. (Bug: 67493)"
	fi
}
