# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gda-sharp/gda-sharp-1.0.8.ebuild,v 1.4 2005/05/12 13:01:23 dertobi123 Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=gnome-extra/libgda-1.0.0"
