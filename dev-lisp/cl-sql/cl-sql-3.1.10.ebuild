# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-sql/cl-sql-3.1.10.ebuild,v 1.3 2005/05/24 18:48:35 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="A multi-platform SQL interface for Common Lisp"
HOMEPAGE="http://clsql.b9.com/
	http://packages.debian.org/unstable/devel/cl-sql.html
	http://www.cliki.net/CLSQL"
SRC_URI="http://files.b9.com/clsql/clsql-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="postgres mysql sqlite odbc"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-md5
	dev-lisp/cl-uffi
	postgres? ( dev-db/postgresql )
	mysql? ( dev-db/mysql )
	sqlite? ( =dev-db/sqlite-2* )
	odbc? ( dev-db/unixODBC )"

S=${WORKDIR}/clsql-${PV}

# Have to do this in a static manner, it seems.

CLPACKAGE='clsql clsql-uffi clsql-postgresql clsql-postgresql-socket clsql-mysql clsql-odbc clsql-sqlite'

src_compile() {
	make -C uffi || die
	use mysql && make -C db-mysql
}

src_install() {
	dodir $CLSYSTEMROOT
	dodir $CLSOURCEROOT

	insinto $CLSOURCEROOT/clsql/sql; doins sql/*.lisp
	insinto $CLSOURCEROOT/clsql; doins clsql.asd
	dosym $CLSOURCEROOT/clsql/clsql.asd $CLSYSTEMROOT/clsql.asd

	insinto $CLSOURCEROOT/clsql-uffi/uffi; doins uffi/*.lisp
	insinto $CLSOURCEROOT/clsql-uffi; doins clsql-uffi.asd
	dosym $CLSOURCEROOT/clsql-uffi/clsql-uffi.asd $CLSYSTEMROOT/clsql-uffi.asd
	exeinto /usr/lib/clsql/; doexe uffi/uffi.so

	if use postgres; then
		insinto $CLSOURCEROOT/clsql-postgresql/db-postgresql; doins db-postgresql/*.lisp
		insinto $CLSOURCEROOT/clsql-postgresql; doins clsql-postgresql.asd
		dosym $CLSOURCEROOT/clsql-postgresql/clsql-postgresql.asd $CLSYSTEMROOT/clsql-postgresql.asd
	fi

	insinto $CLSOURCEROOT/clsql-postgresql-socket/db-postgresql-socket
	doins db-postgresql-socket/*.lisp
	insinto $CLSOURCEROOT/clsql-postgresql-socket
	doins clsql-postgresql-socket.asd
	dosym $CLSOURCEROOT/clsql-postgresql-socket/clsql-postgresql-socket.asd \
		$CLSYSTEMROOT/clsql-postgresql-socket.asd

	if use mysql; then
		insinto $CLSOURCEROOT/clsql-mysql/db-mysql; doins db-mysql/*.lisp db-mysql/*.c
		insinto $CLSOURCEROOT/clsql-mysql; doins clsql-mysql.asd
		dosym $CLSOURCEROOT/clsql-mysql/clsql-mysql.asd $CLSYSTEMROOT/clsql-mysql.asd
		exeinto /usr/lib/clsql/; doexe db-mysql/mysql.so
	fi

	if use odbc; then
		insinto $CLSOURCEROOT/clsql-odbc/db-odbc; doins db-odbc/*.lisp
		insinto $CLSOURCEROOT/clsql-odbc; doins clsql-odbc.asd
		dosym $CLSOURCEROOT/clsql-odbc/clsql-odbc.asd $CLSYSTEMROOT/clsql-odbc.asd
	fi

	if use sqlite; then
		insinto $CLSOURCEROOT/clsql-sqlite/db-sqlite; doins db-sqlite/*.lisp
		insinto $CLSOURCEROOT/clsql-sqlite; doins clsql-sqlite.asd
		dosym $CLSOURCEROOT/clsql-sqlite/clsql-sqlite.asd $CLSYSTEMROOT/clsql-sqlite.asd
	fi

	dodoc BUGS CONTRIBUTORS COPYING* ChangeLog INSTALL LATEST-TEST-RESULTS NEWS README TODO
	dodoc doc/clsql.pdf
	tar xfz doc/html.tar.gz -C ${D}/usr/share/doc/${PF}/
	do-debian-credits
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}
