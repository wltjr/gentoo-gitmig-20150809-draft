# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fann/fann-1.2.0-r1.ebuild,v 1.2 2005/08/24 09:31:15 satya Exp $

inherit eutils
#-----------------------------------------------------------------------------
MY_PKG_NAME=${PN}-${PV/-.*/}
DESCRIPTION="Fast Artificial Neural Network Library implements multilayer artificial neural networks in C"
HOMEPAGE="http://fann.sourceforge.net/"
SRC_URI="mirror://sourceforge/fann/${MY_PKG_NAME}.tar.bz2"
#-----------------------------------------------------------------------------
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc python"
#-----------------------------------------------------------------------------
DEPEND="sys-devel/autoconf
	sys-apps/sed
	doc? ( app-text/docbook-sgml-utils )
	python? ( dev-lang/python dev-lang/swig )"
#-----------------------------------------------------------------------------
S=${WORKDIR}/${MY_PKG_NAME}
#=============================================================================
src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	epatch ${FILESDIR}/${PF}.patch
}
#=============================================================================
src_compile() {
	local myconf
	myconf="--prefix=/usr"
	cd ${S} || die
	econf ${myconf} || die
	emake || die
	if use python; then
		einfo "python ------------------------------"
		cd ${S}/python || die
		#mkdir fann
		#for f in `ls *py |grep -v setup.py`; do
		#	mv $f fann || die
		#done
		python setup_unix.py build
	fi
}
#=============================================================================
src_install() {
	cd ${S}
	make install DESTDIR=${D} || die
	if use doc; then
		einfo "doc ---------------------------------"
		dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
		insinto /usr/share/doc/${PF}/benchmarks
		cp -pPR ${S}/benchmarks/* ${D}/usr/share/doc/${PF}/benchmarks
		insinto /usr/share/doc/${PF}/examples/c
		doins ${S}/examples/*
		insinto /usr/share/doc/${PF}/html
		cp -pPR doc/html/* ${D}/usr/share/doc/${PF}/html
		insinto /usr/share/doc/${PF}/pdf
		doins doc/*pdf
	fi
	if use python; then
		einfo "python ------------------------------"
		cd ${S}/python || die
		python setup_unix.py install --root=${D} || die "No python"
		if use doc; then
			local python_doc_dir="/usr/share/doc/${PF}/examples/python"
			insinto ${python_doc_dir}
			doins examples/*py
			dosym ../../benchmarks/datasets ${python_doc_dir}/
		fi
	fi
}

