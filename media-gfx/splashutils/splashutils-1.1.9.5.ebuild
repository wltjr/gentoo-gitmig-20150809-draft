# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/splashutils/splashutils-1.1.9.5.ebuild,v 1.1 2005/04/29 23:06:25 spock Exp $

MISCSPLASH="miscsplashutils-0.1.3"
GENTOOSPLASH="splashutils-gentoo-0.1.9"
KLIBC_VERSION="1.0.8"

IUSE="hardened png truetype kdgraphics"

DESCRIPTION="Framebuffer splash utilities."
HOMEPAGE="http://dev.gentoo.org/~spock/"
SRC_URI="mirror://gentoo/${P/_/-}.tar.bz2
	 mirror://gentoo/${GENTOOSPLASH}.tar.bz2
	 mirror://gentoo/${MISCSPLASH}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
RDEPEND="truetype? ( >=media-libs/freetype-2 )
	png? ( >=media-libs/libpng-1.2.7 )
	>=media-libs/jpeg-6b
	>=sys-apps/baselayout-1.9.4-r5
	!media-gfx/bootsplash"
DEPEND="${RDEPEND}
	virtual/linux-sources"

S="${WORKDIR}/${P/_/-}"
SG="${WORKDIR}/${GENTOOSPLASH}"
SM="${WORKDIR}/${MISCSPLASH}"

pkg_setup() {
	if use hardened; then
		ewarn "Due to problems with klibc, it is currently impossible to compile splashutils"
		ewarn "with 'hardened' GCC flags. As a workaround, the package will be compiled with"
		ewarn "-fno-stack-protector. Hardened GCC features will not be used while building"
		ewarn "the fbsplash kernel helper."
	else
		if [[ -n "`echo ${GCC_SPECS} | grep hardened`" ]]; then
			ewarn "It appears that you're using a hardened gcc, even though the 'hardened'"
			ewarn "USE flag is not set. This is a common source of compilation problems with"
			ewarn "splashutils. Please use 'gcc-config' to set a non-hardened profile and"
			ewarn "make sure the environment is up-to-date (especially, that the GCC_SPECS"
			ewarn "env. variable is set correctly)."
		fi
	fi
}

spl_conf() {
	sed -i -re "s/#.* $2([^_].*|$)//g" ${S}/config.h

	if [[ "$1" == "yes" ]]; then
		echo "#define	$2 1" >> ${S}/config.h
	else
		echo "#undef	$2" >> ${S}/config.h
	fi
}

spl_conf_use() {
	if use $1; then
		spl_conf yes $2
	else
		spl_conf no $2
	fi
}

src_unpack() {
	unpack ${A}
	ln -s /usr/src/linux ${S}/linux

	# Check whether the kernel tree has been patched with fbsplash.
	if [[ ! -e /usr/src/linux/include/linux/console_splash.h ]]; then
		ewarn "Your kernel in /usr/src/linux has not been patched with a compatible version"
		ewarn "of fbsplash. You can download the latest patch from http://dev.gentoo.org/~spock/"
		echo ""
		ewarn "Splashutils will be compiled without fbsplash support. Verbose mode will not"
		ewarn "be supported."
		spl_conf no CONFIG_FBSPLASH
	else
		spl_conf yes CONFIG_FBSPLASH
	fi

	# Make sure the kernel is configured. This is necessary for klibc to build.
	if [ ! -e /usr/src/linux/include/asm ]; then
		if [ -z "${KBUILD_OUTPUT}" ] ||
		   [ ! -e "${KBUILD_OUTPUT}/include/asm" ]; then
			eerror "It appears that your kernel has not been configured. Please run at least"
			eerror "\`make prepare\` before merging splashutils."
			die "Kernel not configured"
		else
			t=$(readlink ${KBUILD_OUTPUT}/include/asm)
			ln -s /usr/src/linux/include/${t} ${T}/asm
		fi
	fi

	# This should make splashutils compile on hardened systems.
	if use hardened; then
		sed -e 's@K_CFLAGS =@K_CFLAGS = -fno-stack-protector@' -i ${S}/Makefile
		sed -e 's@CFLAGS  =@CFLAGS  = -fno-stack-protector@' -i ${S}/libs/klibc-${KLIBC_VERSION}/klibc/MCONFIG
	fi

	mkdir ${S}/kernel
}

src_compile() {
	local miscincs

	if [ -n "${KBUILD_OUTPUT}" ]; then
		miscincs="-I${T} -I${KBUILD_OUTPUT}/include"
	fi

	spl_conf_use png CONFIG_PNG
	spl_conf_use truetype CONFIG_TTF
	spl_conf_use truetype CONFIG_TTF_KERNEL
	spl_conf_use kdgraphics CONFIG_SILENT_KD_GRAPHICS
	sed -i -e "s/^CFLAGS[ \t]*=.*/CFLAGS = ${CFLAGS}/" Makefile
	emake -j1 MISCINCS="${miscincs}" || die "failed to build splashutils"

	cd ${SM}
	emake || die "failed to build miscsplashutils"
}

src_install() {
	cd ${SM}
	make DESTDIR=${D} install || die

	cd ${S}
	make DESTDIR=${D} install || die

	keepdir /lib/splash/{tmp,cache,bin}
	dosym /lib/splash/bin/fbres /sbin/fbres

	dodir /etc/env.d
	echo 'CONFIG_PROTECT_MASK="/etc/splash"' > ${D}/etc/env.d/99splash

	exeinto /sbin
	doexe ${SG}/splash

	exeinto /etc/init.d
	newexe ${SG}/init-splash splash

	insinto /sbin
	doins ${SG}/splash-functions.sh

	insinto /etc/conf.d
	newins ${SG}/splash.conf splash

	insinto /etc/splash
	doins ${SM}/fbtruetype/luxisri.ttf

	dodoc docs/* README AUTHORS
}

pkg_postinst() {
	ebegin "Checking whether /dev/tty1 is in place"
	mount --bind / ${T}
	if [[ ! -c ${T}/dev/tty1 ]]; then
		eend 1
		ewarn "It appears that the /dev/tty1 character device doesn't exist on"
		ewarn "the root filesystem. This will prevent the silent mode from working"
		ewarn "properly. You can fix the problem by doing:"
		ewarn "  mount --bind / /lib/splash/tmp"
		ewarn "  mkdev /lib/splash/tmp/dev/tty1 c 4 1"
		ewarn "  umount /lib/splash/tmp"
	else
		eend 0
	fi
	umount ${T}

	echo ""
	ewarn "Due to a change in the splash protocol you will have to rebuild"
	ewarn "all initrds created with splashutils < 1.1.9. This can be done"
	ewarn "with the splash_geninitramsfs script."
	echo ""
	ewarn "It is required that you add 'CONSOLE=/dev/tty1', to make sure all"
	ewarn "init messages are printed to the first tty, and not the foreground one."
	ewarn "It is advised that you add 'quiet' as an additional, standalone"
	ewarn "parameter to suppress non-critical kernel messages."
	echo ""
	einfo "After these modifications, the relevant part of the kernel command"
	einfo "line might look like:"
	einfo "    splash=silent,fadein,theme:emergence quiet CONSOLE=/dev/tty1"
	echo ""
	einfo "The sample Gentoo themes (emergence, gentoo) have been removed from the"
	einfo "core splashutils package. To get some themes you might want to emerge:"
	einfo "    media-gfx/splash-themes-livecd"
	einfo "    media-gfx/splash-themes-gentoo"
	echo ""
}
