# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/nanoblogger/nanoblogger-3.1-r1.ebuild,v 1.2 2005/02/01 17:14:57 agriffis Exp $

inherit bash-completion

DESCRIPTION="Small and simple weblog engine written in Bash for the command-line"
HOMEPAGE="http://nanoblogger.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64"
IUSE=""

RDEPEND="app-shells/bash"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's|^\(BASE_DIR=\).*$|\1"/usr/share/nanoblogger"|' \
		-e 's|"$BASE_DIR"/\(nb\.conf\)|/etc/\1|' \
			nb || die "sed nb failed"
}

src_install() {
	dobin nb
	insinto /usr/share/nanoblogger
	doins -r default moods plugins
	insinto /etc
	doins nb.conf
	dodoc ChangeLog
	dohtml docs/nanoblogger.html
	dobashcompletion ${FILESDIR}/nb.bashcomp
}

pkg_postinst() {
	echo
	einfo "Documentation for getting started with nanoblogger may be found at"
	einfo "/usr/share/doc/${PF}/html/nanoblogger.html."
	einfo
	einfo "To create and configure a new weblog, run the following as your user:"
	einfo "   nb -b /some/dir -a"
	einfo "where /some/dir is a directory that DOES NOT exist."
	einfo
	einfo "To prevent having to specify your blog directory every time you use"
	einfo "nanoblogger (with the -b switch), you can set a default value in your"
	einfo "~/.nb.conf.  For example:"
	einfo '   BLOG_DIR="$HOME/public_html/blog"'
	bash-completion_pkg_postinst
}
