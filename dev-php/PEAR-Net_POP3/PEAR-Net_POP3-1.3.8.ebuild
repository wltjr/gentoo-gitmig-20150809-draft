# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_POP3/PEAR-Net_POP3-1.3.8.ebuild,v 1.8 2012/03/18 18:33:07 armin76 Exp $

inherit php-pear-r1

DESCRIPTION="Provides a POP3 class to access POP3 server."

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="sasl"
RDEPEND=">=dev-php/PEAR-Net_Socket-1.0.6-r1
	!sasl? ( >=dev-php/PEAR-Auth_SASL-1.0.2 )"
