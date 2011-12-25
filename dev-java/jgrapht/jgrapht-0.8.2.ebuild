# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgrapht/jgrapht-0.8.2.ebuild,v 1.1 2011/12/25 21:15:11 fordfrog Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Graph library that is a simpler and faster alternative to JGraph"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://jgrapht.sourceforge.net"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="test"

CDEPEND="dev-java/touchgraph-graphlayout:0
	dev-java/jgraph:0"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.6
	test? ( dev-java/ant-junit
		dev-java/xmlunit:1 )"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="touchgraph-graphlayout jgraph"
EANT_DOC_TARGET="javadoc"

java_prepare() {
	rm -rf "${S}/lib" || die
	rm -v "${S}"/*.jar || die
	epatch "${FILESDIR}"/DOTExporter-nullpointer.patch
}

src_install() {
	java-pkg_newjar ${PN}*.jar || die

	dohtml README.html || die
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/org
}

src_test() {
	EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH} xmlunit:1" ANT_TASKS="ant-junit" eant test
}
