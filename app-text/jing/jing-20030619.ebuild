# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jing/jing-20030619.ebuild,v 1.9 2005/01/14 15:49:37 luckyduck Exp $

inherit java-pkg

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://www.thaiopensource.com/download/jing-${PV}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND=">=virtual/jdk-1.3
	dev-java/saxon-bin
	=dev-java/xerces-1.3*"
DEPEND="app-arch/unzip"


src_install() {
	java-pkg_dojar bin/jing.jar
	cat >jing <<'EOF'
#!/bin/sh
exec `java-config --java` -classpath `java-config -p xerces-1.3,saxon-bin` -jar `java-config -p jing` "$@"
EOF
	dobin jing
	java-pkg_dohtml -r doc/* readme.html
}
