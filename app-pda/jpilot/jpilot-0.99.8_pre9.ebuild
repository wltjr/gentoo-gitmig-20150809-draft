# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot/jpilot-0.99.8_pre9.ebuild,v 1.4 2007/01/24 03:30:21 genone Exp $

inherit eutils multilib

MY_PV=${PV/_/-}
DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
HOMEPAGE="http://jpilot.org/"
#SRC_URI="http://jpilot.org/${P}.tar.gz"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/jpilot/jpilot-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="nls gtk"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	>=app-pda/pilot-link-0.11.5"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S} || die
	# There are four icons available.  Use the third.
	sed -i 's/jpilot.xpm/jpilot-icon3.xpm/' jpilot.desktop || die
}

src_compile() {
	econf $(use_enable gtk gtk2) $(use_enable nls) || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR=${D} \
		libdir=/usr/$(get_libdir) \
		docdir=/usr/share/doc/${PF} \
		icondir=/usr/share/pixmaps \
		desktopdir=/usr/share/applications || die "install failed"

	dodoc README TODO UPGRADING ABOUT-NLS BUGS ChangeLog COPYING INSTALL
	doman docs/*.1

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins ${S}/jpilotrc.*
}

pkg_postinst() {
	elog
	elog "The jpilot-syncmal plugin has moved to its own ebuild."
	elog "If you want to use that plugin, please run"
	elog "    emerge jpilot-syncmal"
	elog
	elog "There are other plugins available as well.  To see the"
	elog "list, please run"
	elog "    emerge -s jpilot"
	elog
}
