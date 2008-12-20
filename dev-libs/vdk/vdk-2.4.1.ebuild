# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vdk/vdk-2.4.1.ebuild,v 1.9 2008/12/20 23:46:12 loki_val Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A Visual Development Kit for RAD"
SRC_URI="mirror://sourceforge/vdklib/${P}.tar.gz"
HOMEPAGE="http://www.mariomotta.it/vdklib/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~hppa ppc sparc x86"
IUSE="doc debug"

DEPEND=">x11-libs/gtk+-2.4
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/vdk-2.4.1-gcc4.patch
	epatch "${FILESDIR}"/vdk-2.4.1-gcc43.patch
}



src_compile() {
	local myconf=""

	# gnome and sigc USE flags need to be added later
	# when upstream decides to re-support them - ChrisWhite

	use doc && \
		myconf="${myconf} --enable-doc-html=yes \
						  --enable-doc-latex=yes \
						  --enable-doc-man=yes" \
		|| myconf="${myconf} --enable-doc-html=no \
							 --enable-doc-latex=no \
							 --enable-doc-man=no"

	use debug && \
		myconf="${myconf} --enable-debug=yes" \
		|| myconf="${myconf} --enable-debug=no"

	econf \
		${myconf} \
		--enable-testvdk=no \
		|| die "econf failed"

		# die non user custom CFLAGS!
		sed -e "s/CFLAGS = .*/CFLAGS = ${CFLAGS}/" -i Makefile
		sed -e "s/CXXFLAGS = .*/CXXFLAGS = ${CXXFLAGS}/" -i Makefile
		sed -e "s/CFLAGS = .*/CFLAGS = ${CFLAGS}/" -i vdk/Makefile
		sed -e "s/CXXFLAGS = .*/CXXFLAGS = ${CXXFLAGS}/" -i vdk/Makefile

		emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO
}
