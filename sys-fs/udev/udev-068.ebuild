# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-068.ebuild,v 1.8 2005/09/08 17:39:09 ka0ttic Exp $

inherit eutils flag-o-matic

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="static selinux"

DEPEND="sys-apps/hotplug-base"
RDEPEND="${DEPEND}
	>=sys-apps/baselayout-1.8.6.12-r3"
# We need some changes for devfs type layout
PROVIDE="virtual/dev-manager"

if use static
then
	USE_KLIBC=true
else
	USE_KLIBC=false
fi
export USE_KLIBC


pkg_setup() {
	[ "${USE_KLIBC}" = "true" ] && check_KV

	return 0
}

src_unpack() {
	unpack ${A}

	cd ${S}

	# patches go here...
	#epatch ${FILESDIR}/${P}-udev_volume_id.patch

	# No need to clutter the logs ...
	sed -ie '/^DEBUG/ c\DEBUG = false' Makefile
	# Do not use optimization flags from the package
	sed -ie 's|$(OPTIMIZATION)||g' Makefile

	# Make sure there is no sudden changes to udev.rules.gentoo
	# (more for my own needs than anything else ...)
	if [ "`md5sum < "${S}/etc/udev/gentoo/udev.rules"`" != \
	     "cb5c7232b311b8ce5c46b11b7ea2253f  -" ]
	then
		echo
		eerror "gentoo/udev.rules has been updated, please validate!"
		die "gentoo/udev.rules has been updated, please validate!"
	fi
}

src_compile() {
	filter-flags -fprefetch-loop-arrays
	local myconf=
	local extras="extras/scsi_id extras/volume_id extras/ata_id extras/run_directory extras/usb_id extras/floppy extras/cdrom_id"

	use selinux && myconf="${myconf} USE_SELINUX=true"

	# Not everyone has full $CHOST-{ld,ar,etc...} yet
	local mycross=""
	type -p ${CHOST}-ar && mycross=${CHOST}-

	# Do not work with emake
	make \
		EXTRAS="${extras}" \
		udevdir="/dev/" \
		CROSS=${mycross} \
		${myconf} || die
}

src_install() {
	dobin udevinfo
	dobin udevtest
	dobin udevmonitor
	into /
	dosbin udev
	dosbin udevd
	dosbin udevsend
	dosbin udevstart
	dosbin udeveventrecorder
	dosbin udevcontrol
	dosbin extras/run_directory/udev_run_devd
	dosbin extras/run_directory/udev_run_hotplugd
	dosbin extras/ata_id/ata_id
	dosbin extras/volume_id/vol_id
	dosbin extras/scsi_id/scsi_id
	dosbin extras/usb_id/usb_id
	dosbin extras/cdrom_id/cdrom_id
	dosbin extras/path_id
	dosbin extras/floppy/create_floppy_devices

	exeinto /etc/udev/scripts
	doexe extras/ide-devfs.sh
	doexe extras/scsi-devfs.sh
	doexe extras/dvb.sh


	insinto /etc/udev
	newins ${FILESDIR}/udev.conf.post_059 udev.conf

	# For devfs style layout
	insinto /etc/udev/rules.d/
	newins etc/udev/gentoo/udev.rules 50-udev.rules

	# Our own custom udev.permissions
	#insinto /etc/udev/permissions.d/
	#newins etc/udev/gentoo/udev.permissions 50-udev.permissions

	# scsi_id configuration
	insinto /etc
	doins extras/scsi_id/scsi_id.config

	# set up symlinks in /etc/hotplug.d/default
	dodir /etc/hotplug.d/default
	dosym ../../../sbin/udevsend /etc/hotplug.d/default/10-udev.hotplug

	# set up the /etc/dev.d directory tree
	dodir /etc/dev.d/default
	dodir /etc/dev.d/net
	exeinto /etc/dev.d/net
	doexe extras/run_directory/dev.d/net/hotplug.dev

	doman *.8
	doman extras/scsi_id/scsi_id.8

	dodoc COPYING ChangeLog FAQ HOWTO-udev_for_dev README TODO RELEASE-NOTES
	dodoc docs/{overview,udev_vs_devfs,libsysfs.txt}
	dodoc docs/persistent_naming/* docs/writing_udev_rules/*

	newdoc extras/volume_id/README README_volume_id
}

pkg_preinst() {
	if [ -f "${ROOT}/etc/udev/udev.config" -a \
	     ! -f "${ROOT}/etc/udev/udev.rules" ]
	then
		mv -f ${ROOT}/etc/udev/udev.config ${ROOT}/etc/udev/udev.rules
	fi

	# delete the old udev.hotplug symlink if it is present
	if [ -h "${ROOT}/etc/hotplug.d/default/udev.hotplug" ]
	then
		rm -f ${ROOT}/etc/hotplug.d/default/udev.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [ -h "${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug" ]
	then
		rm -f ${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug
	fi
}

pkg_postinst() {
	if [ "${ROOT}" = "/" -a -n "`pidof udevd`" ]
	then
		killall -15 udevd &>/dev/null
		sleep 1
		killall -9 udevd &>/dev/null
	fi

	# people want reminders, I'll give them reminders.  Odds are they will
	# just ignore them anyway...
	ewarn "Note: If you are upgrading from a version of udev prior to 046"
	ewarn "      and you rely on the output of udevinfo for anything, please"
	ewarn "      either run 'udevstart' now, or reboot, in order to get a"
	ewarn "      up-to-date udev database."
	ewarn
	ewarn "Note: If you are upgrading from a version of udev prior to 050"
	ewarn "      and you had written some custom permissions rules, please"
	ewarn "      realize that the permission rules are now part of the main"
	ewarn "      udev rules files and are not stand-alone anymore.  This means"
	ewarn "      you need to rewrite them."
	ewarn
	ewarn "Note: If you are upgrading from a version of udev prior to 057"
	ewarn "      and you have written custom rules, and rely on the etc/dev.d/"
	ewarn "      functionality, please read the RELEASE-NOTES file for details"
	ewarn "      on what has changed with this feature, and how to change your"
	ewarn "      rules to work properly."
	ewarn
	ewarn "Note: If you are upgrading from a version of udev prior to 059"
	ewarn "      and you have written custom rules, and rely on the etc/dev.d/"
	ewarn "      functionality, or the etc/hotplug.d functionality, or just"
	ewarn "      want to write some very cool and power udev rules, please "
	ewarn "      read the RELEASE-NOTES file for details on what has changed"
	ewarn "      with this feature, and how to change your rules to work properly."
	ewarn
	ewarn "Note: If you are upgrading from a version of udev prior to 063"
	ewarn "      and you use the devfs-style names for your block devices"
	ewarn "      or use devfs-style names in /etc/inittab or /etc/securetty or"
	ewarn "      your GRUB or LILO kernel boot command line, you need to"
	ewarn "      change them back to LSB compliant names, as the devfs names are"
	ewarn "      now gone.  If you wish to use some persistent names for your"
	ewarn "      block devices, look at the symlinks in /dev/disk/ for the names"
	ewarn "      you can use."

	einfo
	einfo "For more information on udev on Gentoo, writing udev rules, and"
	einfo "         fixing known issues visit:"
	einfo "         http://www.gentoo.org/doc/en/udev-guide.xml"
}
