# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Damon Conway <damon@3jane.net> 
# $Header: /var/cvsroot/gentoo-x86/incoming/blackdown-1.3.1.ebuild,v 1.1 2001/08/17 20:59:12 danarmak Exp $

A=j2re-1.3.1-FCS-linux-i386.tar.bz2
S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Java Runtime Environment"
SRC_URI="ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/${A}"
HOMEPAGE="http://www.blackdown.org"

DEPEND="virtual/glibc"

src_install () {
	insinto /opt/${P}/bin
	doins bin/.java_wrapper JavaPluginControlPanel awt_robot
	doins bin/j2sdk-config realpath

	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/java
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/keytool
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/policytool
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmid
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/rmiregistry
	dosym /opt/${P}/bin/.java_wrapper /opt/${P}/bin/tnameserv

	insinto /opt/${P}/bin/i386
	doins bin/i386/realpath

	insinto /opt/${P}/bin/i386/green_threads
	doins bin/i386/green_threads/*

	insinto /opt/${P}/bin/i386/native_threads
	doins bin/i386/native_threads/*

	insinto /opt/${P}/lib
	doins lib/*

	insinto /opt/${P}/man/ja/man1
	doins man/ja/man1/*

	insinto /opt/${P}/man/man1
	doins man/man1/*

	insinto /opt/${P}/plugin/i386/mozilla
	doins plugin/i386/mozilla/*

	dosym /opt/${P}/plugin/i386/mozilla /opt/${P}/plugin/i386/netscape6

	insinto /opt/${P}/plugin/i386/netscape4
	doins plugin/i386/netscape4/*

	dodir /usr/share
	dodoc COPYRIGHT LICENSE README INSTALL
}

pkg_postinst () {
	einfo "For instructions on installing the ${P} browser plugin for"
	einfo "Netscape and Mozilla, see /usr/share/doc/${P}/INSTALL."
}
 