# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/shadow/shadow-4.0.3-r2.ebuild,v 1.4 2002/12/03 20:33:01 azarah Exp $

IUSE=""

inherit libtool

FORCE_SYSTEMAUTH_UPDATE="no"

S="${WORKDIR}/${P}"
HOMEPAGE="http://shadow.pld.org.pl/"
DESCRIPTION="Utilities to deal with user accounts"
SRC_URI="ftp://ftp.pld.org.pl/software/shadow/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3
	sys-devel/gettext"
	
RDEPEND=">=sys-libs/pam-0.75-r4
	>=sys-libs/cracklib-2.7-r3"


pkg_preinst() { 
	rm -f ${ROOT}/etc/pam.d/system-auth.new
}

src_unpack() {
	unpack ${A}

	# Get su to call pam_open_session(), and also set DISPLAY and XAUTHORITY,
	# else the session entries in /etc/pam.d/su never get executed, and
	# pam_xauth for one, is then never used.  This should close bug #8831.
	#
	# <azarah@gentoo.org> (19 Oct 2002)
	cd ${S}; patch -p1 < ${FILESDIR}/${P}-su-pam_open_session.patch-v2 || die
}

src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"

	./configure --disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--with-libpam \
		--enable-shared=no \
		--enable-static=yes \
		--host=${CHOST} \
		${myconf} || die "bad configure"
		
	# Parallel make fails sometimes
	make || die "compile problem"
}

src_install() {
	dodir /etc/default /etc/skel

	make prefix=${D}/usr \
		exec_prefix=${D} \
		mandir=${D}/usr/share/man \
		install || die "install problem"

	# Do not install this login, but rather the one from
	# pam-login, as this one have a serious root exploit
	# with pam_limits in use.
	rm ${D}/bin/login

	mv ${D}/lib ${D}/usr
	dosed "s:/lib':/usr/lib':g" /usr/lib/libshadow.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libshadow.la
	dosed "s:/lib':/usr/lib':g" /usr/lib/libmisc.la
	dosed "s:/lib/:/usr/lib/:g" /usr/lib/libmisc.la
	dosym /usr/bin/newgrp /usr/bin/sg
	dosym /usr/sbin/useradd /usr/sbin/adduser
	dosym /usr/sbin/vipw /usr/sbin/vigr
	# Remove dead links
	rm -f ${D}/bin/{sg,vipw}

	insinto /etc
	# Using a securetty with devfs device names added
	# (compat names kept for non-devfs compatibility)
	insopts -m0600 ; doins ${FILESDIR}/securetty
	insopts -m0600 ; doins ${S}/etc/login.access
	insopts -m0644 ; doins ${S}/etc/limits

	# needed for 'adduser -D'
	keepdir /etc/default

# From sys-apps/pam-login now
#	insopts -m0644 ; doins ${FILESDIR}/login.defs
	insinto /etc/pam.d ; insopts -m0644
	cd ${FILESDIR}/pam.d
	for x in *
	do
		[ -f ${x} ] && doins ${x}
	done
	newins system-auth system-auth.new
	newins shadow chage
	newins shadow chsh
	newins shadow chfn
	newins shadow useradd
	newins shadow groupadd
	cd ${S}

	# The manpage install is beyond my comprehension, and
	# also broken. Just do it over.
	rm -rf ${D}/usr/share/man/*
	for x in man/*.[0-9]
	do
		[ -f ${x} ] || continue
		local dir="${D}/usr/share/man/man${x##*.}"
		mkdir -p ${dir}
		cp ${x} ${dir}
	done
	
	# Dont install the manpage, since we dont use
	# login with shadow
	rm -f ${D}/usr/share/man/man1/login.*
	# We use pam, so this is not applicable.
	rm -f ${D}/usr/share/man/man5/suauth.*
	
	cd ${S}/doc
	dodoc ANNOUNCE INSTALL LICENSE README WISHLIST
	docinto txt
	dodoc HOWTO LSM README.* *.txt

	# Fix sparc serial console
	if [ "${ARCH}" = "sparc" -o "${ARCH}" = "sparc64" ]
	then
		# ttyS0 and its devfsd counterpart (Sparc serial port "A")
		dosed 's:\(vc/1\)$:tts/0\n\1:' /etc/securetty
		dosed 's:\(tty1\)$:ttyS0\n\1:' /etc/securetty
	fi
}

pkg_postinst() {
	
	ewarn "Due to a security issue, ${ROOT}etc/pam.d/system-auth "
	ewarn "is being updated automatically. Your old "
	ewarn "system-auth will be backed up as:"
	ewarn "${ROOT}etc/pam.d/system-auth.bak"
	echo

	local CHECK1="$(md5sum ${ROOT}/etc/pam.d/system-auth | cut -d ' ' -f 1)"
	local CHECK2="$(md5sum ${ROOT}/etc/pam.d/system-auth.new | cut -d ' ' -f 1)"

	if [ "${CHECK1}" != "${CHECK2}" -a "${FORCE_SYSTEMAUTH_UPDATE}" = "yes" ]
	then
		cp -a ${ROOT}/etc/pam.d/system-auth \
	              ${ROOT}/etc/pam.d/system-auth.bak;
		mv -f ${ROOT}/etc/pam.d/system-auth.new \
	              ${ROOT}/etc/pam.d/system-auth
	else
		rm -f ${ROOT}/etc/pam.d/system-auth.new
	fi
}

