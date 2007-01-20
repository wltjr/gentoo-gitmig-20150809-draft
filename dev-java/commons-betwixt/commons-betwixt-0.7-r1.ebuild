# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-betwixt/commons-betwixt-0.7-r1.ebuild,v 1.4 2007/01/20 22:03:35 betelgeuse Exp $

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Introspective Bean to XML mapper"
HOMEPAGE="http://jakarta.apache.org/commons/betwixt/"
SRC_URI="mirror://apache/jakarta/commons/betwixt/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0.7"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="doc test source"

COMMON_DEP="
	>=dev-java/commons-logging-1.0.2
	=dev-java/commons-beanutils-1.7*
	>=dev-java/commons-digester-1.6"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.3
	${COMMON_DEP}
	!test? ( dev-java/ant-core )
	test? (
		dev-java/ant
		dev-java/junit
		>=dev-java/xerces-2.7
	)
	source? ( app-arch/zip )"

S="${WORKDIR}/${P}-src/"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-notests.patch

	cd "${S}"
	java-ant_ignore-system-classes
	mkdir -p ${S}/target/lib && cd ${S}/target/lib
	java-pkg_jar-from commons-beanutils-1.7
	java-pkg_jar-from commons-digester
	java-pkg_jar-from commons-logging
	use test && java-pkg_jar-from --build-only xerces-2
	use test && java-pkg_jar-from --build-only junit
}

EANT_BUILD_TARGET="init jar"

src_install() {
	java-pkg_newjar target/${PN}*.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt README.txt
	if use doc; then
		java-pkg_dohtml PROPOSAL.html STATUS.html userguide.html
		java-pkg_dohtml -r dist/docs/
	fi
	use source && java-pkg_dosrc src/java/*
}

src_test() {
	eant test -DJunit.present=true
}
