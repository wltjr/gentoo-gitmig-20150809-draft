# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jaxrpc-bin/sun-jaxrpc-bin-1.1.3.01.ebuild,v 1.2 2006/09/10 15:34:34 nelchael Exp $

JWSDP_VERSION="2.0"
JWSDP_DESC="Java API for XML-based RPC"

inherit java-wsdp

KEYWORDS="~ppc ~x86"

DEPEND="${DEPEND}
	dev-java/sun-saaj-bin"
