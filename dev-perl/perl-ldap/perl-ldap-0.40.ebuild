# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perl-ldap/perl-ldap-0.40.ebuild,v 1.2 2010/03/18 18:54:02 darkside Exp $

EAPI=2

MODULE_AUTHOR=GBARR
inherit perl-module

DESCRIPTION="A collection of perl modules which provide an object-oriented interface to LDAP servers."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="sasl xml ssl"

RDEPEND="dev-perl/Convert-ASN1
	dev-perl/URI
	sasl? ( virtual/perl-Digest-MD5 dev-perl/Authen-SASL )
	xml? ( dev-perl/XML-Parser
			dev-perl/XML-SAX
			dev-perl/XML-SAX-Writer )
	ssl? ( >=dev-perl/IO-Socket-SSL-0.93 )"
DEPEND="${RDEPEND}"
