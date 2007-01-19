# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-startkde/kdebase-startkde-3.5.6.ebuild,v 1.3 2007/01/19 17:27:11 flameeyes Exp $

KMNAME=kdebase
KMNOMODULE=true
KMEXTRACTONLY="kdm/kfrontend/sessions/kde.desktop.in startkde"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-03.tar.bz2"

DESCRIPTION="startkde script, which starts a complete KDE session, and associated scripts"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

# The kde apps called from the startkde script.
# kdesktop, kicker etc are started because they put files in $KDEDIR/share/autostart
# and so in theory they aren't strictly necessary deps.
RDEPEND="|| ( (		x11-apps/xmessage
			x11-apps/xsetroot
			x11-apps/xset
			x11-apps/xrandr
			x11-apps/mkfontdir
			x11-apps/xprop
		) <virtual/x11-7 )
$(deprange $PV $MAXKDEVER kde-base/kdesktop)
$(deprange $PV $MAXKDEVER kde-base/kcminit)
$(deprange $PV $MAXKDEVER kde-base/ksmserver)
$(deprange $PV $MAXKDEVER kde-base/kwin)
$(deprange $PV $MAXKDEVER kde-base/kpersonalizer)
$(deprange $PV $MAXKDEVER kde-base/kreadconfig)
$(deprange $PV $MAXKDEVER kde-base/ksplashml)"


src_compile() { :; }

src_install() {
	# startkde script
	exeinto "${KDEDIR}/bin"
	doexe startkde

	# startup and shutdown scripts
	insinto "${KDEDIR}/env"
	doins "${FILESDIR}/agent-startup.sh"

	exeinto "${KDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# x11 session script
	cat <<EOF > "${T}/kde-${SLOT}"
#!/bin/sh
exec ${KDEDIR}/bin/startkde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/kde-${SLOT}"

	# freedesktop compliant session script
	sed -e "s:@KDE_BINDIR@:${KDEDIR}/bin:g;s:Name=KDE:Name=KDE ${SLOT}:" \
		"${S}/kdm/kfrontend/sessions/kde.desktop.in" > "${T}/kde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/kde-${SLOT}.desktop"
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in KDE sessions,"
	elog "edit ${KDEDIR}/env/agent-startup.sh and"
	elog "${KDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
