# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public Form License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfphoto/cmfphoto-0.1.ebuild,v 1.3 2003/03/27 05:28:19 vladimir Exp $

inherit zproduct

DESCRIPTION="Zope product to have photos."
HOMEPAGE="http://sourceforge.net/projects/collective/"
SRC_URI="mirror://sourceforge/collective/CMFPhoto-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
RDEPEND="dev-python/Imaging-py21
		>=net-zope/cmf-1.3
	    ${RDEPEND}"

ZPROD_LIST="CMFPhoto"

