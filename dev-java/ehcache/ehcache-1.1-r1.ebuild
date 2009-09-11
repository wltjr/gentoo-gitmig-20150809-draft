# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ehcache/ehcache-1.1-r1.ebuild,v 1.2 2009/09/11 22:19:07 maekke Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ehcache is a pure Java, fully-featured, in-process cache."
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://ehcache.sourceforge.net"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

COMMON_DEPEND="
		dev-java/commons-collections
		dev-java/concurrent-util
		dev-java/commons-logging"
RDEPEND=">=virtual/jre-1.4
		${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
		${COMMON_DEPEND}
		>=dev-java/ant-core-1.5"

src_unpack() {
	unpack ${A}
	cd ${S}
	unzip ${P}-src.zip || die
	rm *.jar
	rm -rf src/net/sf/ehcache/hibernate
}

src_compile() {
	mkdir ${S}/classes
	cd ${S}/src

	ejavac -d ${S}/classes \
		-classpath 	$(java-pkg_getjars commons-logging,commons-collections) \
		$(find . -name "*.java")

	cd ${S}/classes
	jar cf ${S}/${P}.jar * || die
}

src_install() {
	cd ${S}
	java-pkg_newjar ${S}/${P}.jar ${PN}.jar
	dodoc *.txt ehcache.xml ehcache.xsd
	if use doc ; then
		unzip ${P}-javadoc.zip || die
		java-pkg_dohtml -r docs
	fi
}
