# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.1.3-r2.ebuild,v 1.4 2000/10/29 20:37:00 achim Exp $

P=glibc-2.1.3
A="glibc-2.1.3.tar.gz glibc-crypt-2.1.tar.gz 
   glibc-linuxthreads-2.1.3.tar.gz glibc-compat-2.1.2.tar.gz
   glibc_2.1.3-13.diff.gz"

S=${WORKDIR}/${P}
DESCRIPTION="GNU libc6 (also called glibc2) C library"
SRC_URI="ftp://prep.ai.mit.edu/gnu/glibc/glibc-2.1.3.tar.gz
	ftp://prep.ai.mit.edu/gnu/glibc/glibc-crypt-2.1.tar.gz
	ftp://prep.ai.mit.edu/gnu/glibc/glibc-linuxthreads-2.1.3.tar.gz
	ftp://gatekeeper.dec.com/pub/GNU/glibc/glibc-2.1.3.tar.gz
	ftp://gatekeeper.dec.com/pub/GNU/glibc/glibc-crypt-2.1.tar.gz
	ftp://gatekeeper.dec.com/pub/GNU/glibc/glibc-linuxthreads-2.1.3.tar.gz
	ftp://jurix.jura.uni-sb.de/pub/linux/source/libc/glibc/glibc-compat-2.1.2.tar.gz
	http://security.debian.org/dists/potato/updates/main/source/glibc_2.1.3-13.diff.gz"

HOMEPAGE="http://www.gnu.org/software/libc/libc.html"

src_compile() {                           
	if [ "$CHOST" = "i686-pc-linux-gnu" ]
	then
		CHOST=i586-pc-linux-gnu #this is so there's no PII specific stuff
	fi
        rm -rf buildhere
	mkdir buildhere
	cd buildhere
	try ../configure --host=${CHOST} --without-cvs \
		--enable-add-ons=linuxthreads,glibc-compat,crypt \
		 --disable-profile --prefix=/usr
	try make 
#	try make check
}

src_unpack() {
    unpack glibc-2.1.3.tar.gz
    cd ${S}
    gzip -dc ${DISTDIR}/glibc_2.1.3-13.diff.gz | patch -p1
    unpack glibc-crypt-2.1.tar.gz
    unpack glibc-linuxthreads-2.1.3.tar.gz
    unpack glibc-compat-2.1.2.tar.gz

    # This patch is required to compile with binutils higher than
    # 2.9.5.0.42
    cp ${O}/files/setjmp.S ${S}/sysdeps/i386/elf/setjmp.S

    for i in alpha-dwarf2-dl-machine glibcbug hurd-ldflags \
	     i386-linux-sys-io-c++ i386-linux-ucontext \
	     linuxthreads-lock locale-C-ctype-c-big-endian \
	     localedata-charmap-BIG5_1984 localedata-eo_EO \
	     localedata-zh_TW.Big5 manual-texinfo4 pthread_create-manpage \
	     string2-pointer-arith tzdata2000c zic-l
    do
        patch -p0 < ${S}/debian/patches/$i.dpatch
    done
}

src_install() {
    cd ${S}
    rm -rf ${D}
    mkdir ${D}	
    dodir /etc/rc.d/init.d
    try make install_root=${D} install -C buildhere
    try make -C linuxthreads/man
    mkdir -p ${D}/usr/man/man3
    install -m 0644 linuxthreads/man/*.3thr ${D}/usr/man/man3
    chmod 755 ${D}/usr/libexec/pt_chown
    install -m 644 nscd/nscd.conf ${D}/etc
    install -m 755 ${O}/files/nscd ${D}/etc/rc.d/init.d/nscd
    dodir /var/db
    install -m 644 nss/db-Makefile ${D}/var/db/Makefile
    preplib /usr
    preplib /
    rm -rf documentation
    mkdir documentation
    mkdir documentation/html
    cp linuxthreads/ChangeLog  documentation/ChangeLog.threads
    cp linuxthreads/Changes documentation/Changes.threads
    cp linuxthreads/README documentation/README.threads
    cp linuxthreads/FAQ.html documentation/html/FAQ-threads.html
    cp crypt/README documentation/README.crypt
    cp db2/README documentation/README.db2
    cp db2/mutex/README documentation/README.db2.mutex
    cp timezone/README documentation/README.timezone
    cp ChangeLog* documentation
    dodoc documentation/*
    docinto html
    dodoc documentation/html/*.html
    dodir /usr/doc/${PF}/examples.threads
    install -m0644 linuxthreads/Examples/*.c ${D}/usr/doc/${PF}/examples.threads
    install -m0644 linuxthreads/Examples/Makefile ${D}/usr/doc/${PF}/examples.threads
    # Patch ucontext.h (needed for lynx, xfree)
    cd ${D}/usr/include/sys
    cp ucontext.h ucontext.h.orig
    sed -e "s/ERR/GLIBCBUG/g" ucontext.h.orig > ucontext.h
}



