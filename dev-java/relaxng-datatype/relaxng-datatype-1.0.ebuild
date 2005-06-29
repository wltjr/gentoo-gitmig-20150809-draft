# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/relaxng-datatype/relaxng-datatype-1.0.ebuild,v 1.1 2005/06/29 18:37:51 axxo Exp $

inherit java-pkg eutils

MY_PN="relaxngDatatype"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Interface between RELAX NG validators and datatype libraries"
HOMEPAGE="http://relaxng.org/"
SRC_URI="mirror://sourceforge/relaxng/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	source? ( app-arch/zip )
	jikes? ( dev-java/jikes )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.3"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	epatch ${FILESDIR}/${P}-build_xml.patch
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar ${MY_PN}.jar
	dodoc README.txt

	use doc && java-pkg_dohtml -r doc/api
	use source && java-pkg_dosrc src/*
}
