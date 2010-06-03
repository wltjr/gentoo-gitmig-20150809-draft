# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/tinyproxy/tinyproxy-1.8.1.ebuild,v 1.5 2010/06/03 21:46:23 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="A lightweight HTTP/SSL proxy"
HOMEPAGE="http://www.banu.com/tinyproxy/"
SRC_URI="http://www.banu.com/pub/${PN}/1.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="debug +filter-proxy minimal reverse-proxy transparent-proxy
	+upstream-proxy +xtinyproxy-header"

DEPEND="minimal? ( app-text/asciidoc )"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
	use minimal && epatch "${FILESDIR}/${P}-minimal.patch"
	eautoreconf
}

src_configure() {
	if use minimal; then
		ln -s /bin/true ${T}/a2x
		export PATH="${T}:${PATH}"
	fi
	econf \
		$(use_enable filter-proxy filter) \
		$(use_enable reverse-proxy reverse) \
		$(use_enable transparent-proxy transparent) \
		$(use_enable upstream-proxy upstream) \
		$(use_enable xtinyproxy-header xtinyproxy) \
		$(use_enable debug) \
		|| die "econf failed"
}

src_install() {
	sed -i \
		-e 's:mkdir $(datadir)/tinyproxy:mkdir -p $(DESTDIR)$(datadir)/tinyproxy:' \
		Makefile
	emake DESTDIR="${D}" install || die "install failed"

	if ! use minimal; then
		dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	fi

	newinitd "${FILESDIR}/tinyproxy.initd" tinyproxy
}

pkg_postinst() {
	einfo "For filtering domains and URLs, enable filter option in the configuration file"
	einfo "and add them to the filter file (one domain or URL per line)."
}
