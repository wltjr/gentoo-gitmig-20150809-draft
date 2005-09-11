# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmldb/xmldb-20011111.ebuild,v 1.4 2005/09/11 19:58:22 betelgeuse Exp $

inherit java-pkg eutils

MY_PN="${PN}-api"
MY_PV="11112001"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Java implementation for specifications made by XML:DB."
HOMEPAGE="http://sourceforge.net/projects/xmldb-org/"
SRC_URI="mirror://sourceforge/xmldb-org/${MY_P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc jikes source"

#When someone has the time, please make compiling the junit tests optional
DEPEND=">=virtual/jdk-1.4
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )
	dev-java/ant-core
	=dev-java/junit-3.8*"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm *.jar

	epatch ${FILESDIR}/${P}-unreachable.patch

	mkdir src && mv org src
	cp ${FILESDIR}/build-${PVR}.xml build.xml
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="-Dbuild.compiler=jikes ${antflags}"
	use doc && antflags="${antflags} javadoc"

	ant ${antflags} || die "Compilation failed"
}

src_install() {
	java-pkg_dojar dist/*.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}
