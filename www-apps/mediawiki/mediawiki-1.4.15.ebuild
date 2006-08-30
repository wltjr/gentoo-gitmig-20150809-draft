# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mediawiki/mediawiki-1.4.15.ebuild,v 1.2 2006/08/30 15:38:14 tchiwam Exp $

inherit webapp depend.php

DESCRIPTION="The MediaWiki wiki web application (as used on wikipedia.org)"
HOMEPAGE="http://www.mediawiki.org"
SRC_URI="mirror://sourceforge/wikipedia/${P/.0_/}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="imagemagick math"

S="${WORKDIR}/${P/.0_/}"

DEPEND="math? ( >=dev-lang/ocaml-3.0.6 )"

RDEPEND="virtual/php
		 >=dev-db/mysql-4
		 math? ( virtual/tetex
		 		 virtual/ghostscript
				 media-gfx/imagemagick )
		 imagemagick? ( media-gfx/imagemagick )"

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use pcre session mysql
	require_gd
}

src_compile() {
	if use math; then
		einfo "Compiling math support"
		cd math || die
		emake || die
	else
		einfo "No math support enabled. Skipping."
	fi

	# TODO: think about includes/zhtable/ support
}

src_install() {
	webapp_src_preinst

	# copy the app's main files excluding math support, docs, and tests
	local DIRS="
		config
		extensions
		images
		includes
		includes/normal
		includes/templates
		includes/zhtable
		irc
		languages
		maintenance
		maintenance/archives
		maintenance/postgresql
		skins
		skins/amethyst
		skins/chick
		skins/common
		skins/common/images
		skins/disabled
		skins/monobook
		skins/myskin
	"
	insinto ${MY_HTDOCSDIR}
	doins *.php *.inc *.phtml
	for DIR in ${DIRS}; do
		dodir ${MY_HTDOCSDIR}/${DIR}
		insinto ${MY_HTDOCSDIR}/${DIR}
		doins ${DIR}/*
		test -f ${DIR}/.htaccess && doins ${DIR}/.htaccess
	done

	# installing some docs
	local DOCS="AdminSettings.sample COPYING FAQ HISTORY INSTALL README RELEASE-NOTES UPGRADE"
	for DOC in ${DOCS}; do
		dodoc "${DOC}"
		rm -f "${DOC}"
	done
	dodoc docs/*.doc
	rm -f docs/*.doc

	docinto php-memcached
	dodoc docs/php-memcached/*

	# If imagemagick is enabled then setup for image upload.
	# We ensure the directory is prepared for writing.  The post-
	# install instructions guide the user to enable the feature.
	if use imagemagick; then
		webapp_serverowned ${MY_HTDOCSDIR}/images
	fi

	# If we've enabled math USE-flag, install math support.
	# We ensure the directories are prepared for writing.  The post-
	# install instructions guide the user to enable the feature.
	if use math; then
		einfo "Installing math support"
		dodir ${MY_HTDOCSDIR}/math
		exeinto ${MY_HTDOCSDIR}/math
		doexe math/texvc

		# Docs
		docinto math
		dodoc math/README math/TODO

		# Working directories.  Server writeable.
		dodir ${MY_HTDOCSDIR}/images/math
		webapp_serverowned ${MY_HTDOCSDIR}/images/math
		dodir ${MY_HTDOCSDIR}/images/tmp
		webapp_serverowned ${MY_HTDOCSDIR}/images/tmp
	fi

	webapp_postinst_txt en ${FILESDIR}/postinstall-1.4-en.txt
	webapp_src_install
}
