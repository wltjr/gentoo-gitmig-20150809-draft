# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-puppet/selinux-puppet-2.20120215-r14.ebuild,v 1.1 2012/07/17 14:27:28 swift Exp $
EAPI="4"

IUSE=""
MODS="puppet"
BASEPOL="2.20120215-r14"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for puppet"

KEYWORDS="~amd64 ~x86"
