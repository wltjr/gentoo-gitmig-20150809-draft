# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fetchyahoo/fetchyahoo-2.9.0.ebuild,v 1.7 2006/02/13 14:55:47 mcummings Exp $

IUSE=""
DESCRIPTION="Perl script that downloads mail from a Yahoo! webmail account to a local mail spool, an mbox file, or to procmail."
SRC_URI="http://fetchyahoo.twizzler.org/${P}.tar.gz"
HOMEPAGE="http://fetchyahoo.twizzler.org/"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ppc ~sparc x86"

SLOT="0"

DEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-perl/MIME-tools
	virtual/perl-libnet
	dev-perl/Crypt-SSLeay
	dev-perl/URI
	dev-perl/MailTools
	dev-perl/IO-stringy
	virtual/perl-MIME-Base64"

src_install() {
	dobin fetchyahoo
	doman fetchyahoo.1
	insinto /etc
	doins fetchyahoorc
	dodoc ChangeLog Credits INSTALL TODO fetchyahoorc
	dohtml index.html
}

pkg_postinst() {
	einfo "Edit /etc/fetchyahoorc or ~/.fetchyahoorc to configure fetchyahoo"
	einfo "The executable name has changed from fetchyahoo.pl to fetchyahoo"
}
