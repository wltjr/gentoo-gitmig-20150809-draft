# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-2.5.ebuild,v 1.2 2011/10/31 06:07:54 radhermit Exp $

EAPI="4"

inherit eutils

STUPID_NUM="3487"

DESCRIPTION="Serial Communication Program"
HOMEPAGE="http://alioth.debian.org/projects/minicom"
SRC_URI="http://alioth.debian.org/download.php/${STUPID_NUM}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="nls"

COMMON_DEPEND="sys-libs/ncurses"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	net-dialup/lrzsz"

DOCS="AUTHORS ChangeLog NEWS README doc/minicom.FAQ"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs da de es fi fr hu id ja nb pl pt_BR ro ru rw sv vi zh_TW"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3-gentoo-runscript.patch
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		$(use_enable nls)
}

src_install() {
	default
	insinto /etc/minicom
	doins "${FILESDIR}"/minirc.dfl
}

pkg_preinst() {
	[[ -s ${EROOT}/etc/minicom/minirc.dfl ]] \
		&& rm -f "${ED}"/etc/minicom/minirc.dfl
}
