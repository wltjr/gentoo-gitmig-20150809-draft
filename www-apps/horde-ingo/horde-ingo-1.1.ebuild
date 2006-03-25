# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-ingo/horde-ingo-1.1.ebuild,v 1.3 2006/03/25 06:17:35 josejx Exp $

HORDE_PHP_FEATURES="imap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="e-mail filter rules manager for Horde IMP"

KEYWORDS="~alpha ~amd64 ~hppa ppc sparc ~x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
