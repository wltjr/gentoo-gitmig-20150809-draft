# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-MDB2_Driver_mssql/PEAR-MDB2_Driver_mssql-1.3.0_beta2.ebuild,v 1.1 2009/08/26 21:10:31 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Database Abstraction Layer, mssql driver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-MDB2-2.5.0_beta2"
RDEPEND="${DEPEND}"

pkg_setup() {
	require_php_with_use mssql
}
