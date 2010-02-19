# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2009.09.13.ebuild,v 1.6 2010/02/19 18:06:48 jer Exp $

EAPI="2"

DESCRIPTION="A small command-line program to download videos from YouTube."
HOMEPAGE="http://bitbucket.org/rg3/youtube-dl/"
SRC_URI="http://bitbucket.org/rg3/${PN}/get/${PV}.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_install() {
	newbin "${PN}/${PN}" ${PN}
}
