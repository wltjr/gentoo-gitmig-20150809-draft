# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.93.94-r1.ebuild,v 1.2 2005/03/02 23:58:19 j4rg0n Exp $

inherit libtool flag-o-matic multilib

DESCRIPTION="An OSF/Motif(R) clone"
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://debian/pool/main/l/lesstif1-1/lesstif1-1_0.93.94-11.diff.gz"

LICENSE="LGPL-2"
SLOT="1.2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~ia64"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	>=x11-libs/motif-config-0.3"

PROVIDE="virtual/motif"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/lesstif1-1_0.93.94-11.diff.gz
}

src_compile() {
	use ppc-macos || elibtoolize

	if use ppc-macos; then
		append-ldflags -L/usr/X11R6/lib -lX11 -lXt
	fi

	econf \
	  --enable-production \
	  --enable-verbose=no \
	  --enable-build-12 \
	  --disable-build-20 \
	  --disable-build-21 \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"


	einfo "Fixing binaries"
	dodir /usr/share/lesstif-1.2
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/share/lesstif-1.2/${file}
	done

	einfo "Fixing libraries"
	dodir /usr/$(get_libdir)/lesstif-1.2
	mv ${D}/usr/lib/* ${D}/usr/$(get_libdir)/lesstif-1.2/

	einfo "Fixing includes"
	dodir /usr/include/lesstif-1.2/
	mv ${D}/usr/include/* ${D}/usr/include/lesstif-1.2

	einfo "Fixing man pages"
	mans="1 3 5"
	for man in $mans; do
		dodir /usr/share/man/man${man}
		for file in `ls ${D}/usr/share/man/man${man}`
		do
			file=${file/.${man}/}
			mv ${D}/usr/share/man/man$man/${file}.${man} ${D}/usr/share/man/man${man}/${file}-lesstif-1.2.${man}
		done
	done


	einfo "Fixing docs"
	dodir /usr/share/doc/
	mv ${D}/usr/LessTif ${D}/usr/share/doc/${P}
	rm -fR ${D}/usr/$(get_libdir)/LessTif

	# cleanup
	rm -f ${D}/usr/share/lesstif-1.2/mxmkmf
	rm -fR ${D}/usr/share/aclocal/
	rm -fR ${D}/usr/$(get_libdir)/lesstif-1.2/LessTif/
	rm -fR ${D}/usr/$(get_libdir)/lesstif-1.2/X11/
	rm -fR ${D}/usr/$(get_libdir)/X11/

}

# Profile stuff
pkg_postinst() {
	motif-config --install lesstif-1.2
}

pkg_prerm() {
	motif-config --uninstall lesstif-1.2
}
