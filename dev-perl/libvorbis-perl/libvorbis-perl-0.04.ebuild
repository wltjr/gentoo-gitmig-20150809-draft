# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.04.ebuild,v 1.5 2003/11/20 20:06:23 dholm Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"
SRC_URI_BASE="http://www.cpan.org/modules/by-authors/id/F/FO/FOOF"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="http://synthcode.com/code/vorbis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~sparc ~ppc"

DEPEND="${DEPEND}
	media-libs/libogg
	media-libs/libvorbis"
