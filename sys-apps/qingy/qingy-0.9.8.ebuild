# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qingy/qingy-0.9.8.ebuild,v 1.1 2009/04/27 14:28:06 s4t4n Exp $

inherit elisp-common eutils pam

GENTOO_THEME_VERSION="2.1"

DESCRIPTION="a DirectFB getty replacement"
HOMEPAGE="http://qingy.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/${PN}-gentoo-theme-${GENTOO_THEME_VERSION}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="crypt directfb emacs gpm opensslcrypt pam static X"

RDEPEND=">=sys-libs/ncurses-5.4-r6
	opensslcrypt? ( >=dev-libs/openssl-0.9.7e )
	crypt?        ( >=dev-libs/libgcrypt-1.2.1 )
	directfb?     ( >=dev-libs/DirectFB-0.9.24 )
	emacs?        ( virtual/emacs )
	pam?          ( >=sys-libs/pam-0.75-r11 )
	X?            ( x11-libs/libX11
					x11-libs/libXScrnSaver
					x11-proto/scrnsaverproto )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=sys-apps/sed-4.1.4-r1"
RDEPEND="${RDEPEND}
	pam? ( sys-auth/pambase )"

SITEFILE=50${PN}-gentoo.el

src_unpack()
{
	if use crypt && use opensslcrypt; then
		echo
		eerror "You can have openssl or libgcrypt as a crypto library, not both."
		eerror "Please check your USE flags..."
		echo
		die "USE flags check failed"
	fi

	if use directfb; then

		if ! built_with_use -a dev-libs/DirectFB fbcon jpeg png truetype; then
			echo
			eerror "qingy expects DirectFB to provide certain capabilities."
			eerror "It depends on the theme you use, but at least the following USE flags"
			eerror "should be enabled in DirectFB: fbcon jpeg png truetype."
			eerror "You must rebuild DirectFB those USE flags enabled!"
			echo
			die "USE flags check failed"
		fi

		if has_version ">=dev-libs/DirectFB-1.2.6"; then
			if built_with_use -a dev-libs/DirectFB X; then
				echo
				eerror "Detected DirectFB version >= 1.2.6."
				eerror "For this version of DirectFB to work with qingy"
				eerror "X USE flag must be disabled."
				eerror "You must rebuild DirectFB with X USE flag disabled!"
				echo
				die "USE flags check failed"
			fi
		fi

	fi

	unpack ${A}
}

src_compile()
{
	local crypto_support="--disable-crypto"
	local emacs_support="--disable-emacs"

	use emacs 		 && emacs_support="--enable-emacs --with-lispdir=${SITELISP}/${PN}"
	use opensslcrypt && crypto_support="--enable-crypto=openssl"
	use crypt        && crypto_support="--enable-crypto=libgcrypt"

	econf                                      \
		--sbindir=/sbin                        \
		--disable-optimizations                \
		`use_enable pam`                       \
		`use_enable static static-build`       \
		`use_enable gpm gpm-lock`              \
		`use_enable X x-support`               \
		`use_enable directfb DirectFB-support` \
		${crypto_support}                      \
		${emacs_support}					   \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install()
{
	# Copy documentation manually as make install only installs info files
	# INSTALL is left because it contains also configuration informations
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO

	# Install the program
	emake DESTDIR="${D}" install || die "Installation failed"

	# Set the settings file umask to 600, in case somebody
	# wants to make use of the autologin feature
	/bin/chmod 600 "${D}/etc/qingy/settings"

	# Install Gentoo theme
	dodir /usr/share/${PN}/themes/gentoo
	cp "${WORKDIR}"/gentoo/* "${D}/usr/share/${PN}/themes/gentoo" \
		|| die "Gentoo theme installation failed"

	# Alter config file so that it uses our theme
	sed -i 's/theme = "default"/theme = "gentoo"/' "${D}/etc/${PN}/settings"

	# Install log rotation policy
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}-logrotate" ${PN} || die "Log rotation policy installation failed"

	use emacs && elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	pamd_mimic system-local-login qingy auth account password session
}

pkg_postinst()
{
	einfo "In order to use qingy you must first edit your /etc/inittab"
	einfo "Check the documentation at ${HOMEPAGE}"
	einfo "for instructions on how to do that."
	echo
	einfo "Also, make sure to adjust qingy settings file (/etc/qingy/settings)"
	einfo "to your preferences/machine configuration..."

	if use crypt; then
		echo
		einfo "You will have to create a key pair using 'qingy-keygen'"
		echo
		ewarn "Note that sometimes a generated key-pair may pass the internal tests"
		ewarn "but fail to work properly. You will get a 'regenerate your keys'"
		ewarn "message. If this is your case, please remove /etc/qingy/public_key"
		ewarn "and /etc/qingy/private_key and run qingy-keygen again..."
	fi

	use emacs && echo && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
