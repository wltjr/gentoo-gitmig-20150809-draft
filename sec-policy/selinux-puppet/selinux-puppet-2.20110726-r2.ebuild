# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-puppet/selinux-puppet-2.20110726-r2.ebuild,v 1.1 2011/09/17 16:20:16 swift Exp $
EAPI="4"

IUSE=""
MODS="puppet"
BASEPOL="2.20110726-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for puppet"
KEYWORDS="~amd64 ~x86"
