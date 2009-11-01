# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/linuxwacom/linuxwacom-0.8.3_p6.ebuild,v 1.3 2009/11/01 14:41:59 ikelos Exp $

inherit eutils autotools toolchain-funcs linux-mod

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_p/-}.tar.bz2"

IUSE="gtk tcl tk usb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"

RDEPEND="x11-proto/inputproto
	<x11-base/xorg-server-1.7
	gtk? ( >=x11-libs/gtk+-2 )
	tcl? ( dev-lang/tcl )
	tk?  ( dev-lang/tk )
	sys-fs/udev
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	usb? ( >=sys-kernel/linux-headers-2.6 )"
S=${WORKDIR}/${P/_p/-}

MODULE_NAMES="wacom(input:${S}/src:${S}/src)"

wacom_check() {
	if use module ; then
		ebegin "Checking for wacom module"
		linux_chkconfig_module TABLET_USB_WACOM
		eend $?

		if [[ $? -ne 0 ]] || ! [ -f "/lib/modules/${KV}/kernel/drivers/input/tablet/wacom.ko" ]; then
			eerror "You need to have your kernel compiled with wacom as a module"
			eerror "to let linuxwacom overwrite it."
			eerror "Enable it in the kernel, found at:"
			eerror
			eerror " Device Drivers"
			eerror "    Input device support"
			eerror "        Tablets"
			eerror "            <M> Wacom Intuos/Graphire tablet support (USB)"
			eerror
			eerror "(in the "USB support" page it is suggested to include also:"
			eerror "EHCI , OHCI , USB Human Interface Device+HID input layer)"
			eerror
			eerror "Then recompile kernel. Otherwise, remove the module USE flag."
			die "Wacom not compiled in kernel as a module!"
		fi
	fi
}

pkg_setup() {
	if use module; then
		linux-mod_pkg_setup
		wacom_check
		# echo "kernel version is ${KV} , name is ${KV%%-*}"
	fi
	ewarn "Versions of linuxwacom >= 0.7.9 require gcc >= 4.2 to compile."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix multilib-strict error for Tcl/Tk library install
	sed -i -e "s:WCM_EXECDIR/lib:WCM_EXECDIR/$(get_libdir):" configure.in

	# Remove warning parameters for gcc < 4, bug 205139
	if [[ $(gcc-major-version) -lt 4 ]]; then
		sed -i -e "s:-Wno-variadic-macros::" src/xdrv/Makefile.am
	fi

	epatch "${FILESDIR}/${P}-xf86config.patch"

	eautoreconf
}

src_compile() {
	if use module; then
		myconf="${myconf} --enable-wacom"
		myconf="${myconf} --with-kernel=${KV_OUT_DIR}"
	fi

	econf ${myconf} \
		$(use_with tcl tcl) \
		$(use_with tk tk) \
		--enable-wacomdrv --enable-wacdump \
		--disable-xf86config \
		--enable-xsetwacom --enable-dlloader || die "econf failed"

	unset ARCH
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."

	# Inelegant attempt to work around a nasty build system
	if use module; then
		cp "${S}"/src/*/wacom.{o,ko} "${S}"/src/
		linux-mod_src_install
	fi

	insinto /etc/udev/rules.d/
	doins "${S}/src/util/60-wacom.rules"

	exeinto /lib/udev/
	doexe "${FILESDIR}"/check_driver
	doman "${FILESDIR}"/check_driver.1

	dohtml -r docs/*
	dodoc AUTHORS ChangeLog NEWS README

	ewarn "Please remove any HAL .FDI files you may"
	ewarn "previously have installed fr linuxwacom."
}
