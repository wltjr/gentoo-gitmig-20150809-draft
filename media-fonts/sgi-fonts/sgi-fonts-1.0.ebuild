# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/sgi-fonts/sgi-fonts-1.0.ebuild,v 1.11 2010/02/11 15:28:31 ulm Exp $

inherit rpm font

RPM_P="${P}-705.noarch"

DESCRIPTION="SGI fonts collection"
HOMEPAGE="http://www.suse.com/us/private/products/suse_linux/prof/packages_professional/sgi-fonts.html"
SRC_URI="ftp://ftp.suse.com/pub/suse/i386/9.1/suse/noarch/${RPM_P}.rpm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ia64 ~ppc ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/usr/X11R6/lib/X11/fonts/misc/sgi"
FONT_S=${S}

FONT_SUFFIX="pcf.gz"
