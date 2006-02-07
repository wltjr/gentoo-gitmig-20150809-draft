# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/klibc/klibc-1.2.1-r1.ebuild,v 1.1 2006/02/07 08:33:22 azarah Exp $

inherit eutils linux-mod

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

DESCRIPTION="A minimal libc subset for use with initramfs."
HOMEPAGE="http://www.zytor.com/mailman/listinfo/klibc"
SRC_URI="ftp://ftp.kernel.org/pub/linux/libs/klibc/${P}.tar.bz2
	ftp://ftp.kernel.org/pub/linux/libs/klibc/Stable/${P}.tar.bz2
	ftp://ftp.kernel.org/pub/linux/libs/klibc/Testing/${P}.tar.bz2"
LICENSE="|| ( GPL-2 LGPL-2 )"
# Mips patches needs updating ...
KEYWORDS="~amd64 -mips ~ppc ~x86"
IUSE="n32"
RESTRICT="nostrip"

DEPEND="dev-lang/perl
	virtual/linux-sources"
RDEPEND="dev-lang/perl"

if [[ ${CTARGET} != ${CHOST} ]] ; then
	SLOT="${CTARGET}"
else
	SLOT="0"
fi

is_cross() { [[ ${CHOST} != ${CTARGET} ]] ; }

guess_arch() {
	local x
	local host=$(echo "${CTARGET%%-*}" | sed -e 's/i.86/i386/' \
	                                         -e 's/sun4u/sparc64/' \
	                                         -e 's/arm.*/arm/' \
	                                         -e 's/sa110/arm/' \
	                                         -e 's/powerpc/ppc/')

	# Sort reverse so that we will get ppc64 before ppc, etc
	for x in $(ls -1 "${S}/include/arch/" | sort -r) ; do
		if [[ ${host} == "${x}" ]] ; then
			echo "${x}"
			return 0
		fi
	done

	return 1
}

pkg_setup() {
	# Make sure kernel sources are OK
	# (Override for linux-mod eclass)
	check_kernel_built
}

src_unpack() {
	unpack ${A}

	if [[ ! -d /usr/${CTARGET} ]] ; then
		echo
		eerror "It does not look like your cross-compiler is setup properly!"
		die "It does not look like your cross-compiler is setup properly!"
	fi

	if ! guess_arch &>/dev/null ; then
		echo
		eerror "Could not guess klibc's ARCH from your CTARGET!"
		die "Could not guess klibc's ARCH from your CTARGET!"
	fi

	kernel_arch=$(readlink "${KV_OUT_DIR}/include/asm" | sed -e 's:asm-::')
	if [[ ${kernel_arch} != $(guess_arch) ]] ; then
		echo
		eerror "Your kernel sources are not configured for your chosen arch!"
		eerror "(KERNEL_ARCH=\"${kernel_arch}\", ARCH=\"$(guess_arch)\")"
		die "Your kernel sources are not configured for your chosen arch!"
	fi

	cd ${S}

	# Add our linux source tree symlink
	ln -snf ${KV_DIR} linux

	# set the build directory
	echo "KRNLOBJ = ${KV_OUT_DIR}" >> MCONFIG

	# We do not want all the nice prelink warnings
	# NOTE: for amd64, we might change below to '/usr/$(get_libdir)/klibc',
	#       but I do not do it right now, as the build system do not support
	#       the lib64 yet ....
	cat > "${S}/70klibc" <<-EOF
		PRELINK_PATH_MASK="/usr/lib/klibc"
	EOF

	# Export the NOSTDINC_FLAGS to ensure -nostdlib is passed, bug #120678
	epatch ${FILESDIR}/${P}-nostdinc-flags.patch

	# klibc detects mips64 systems as having 64bit userland
	# Force them to 32bit userlands instead
#	if ! use n32; then
#		epatch ${FILESDIR}/${PN}-1.1.16-mips32.patch
#	fi

	# Linker path is awry
#	epatch ${FILESDIR}/${PN}-1.1.16-mips-ldpaths.patch
}

src_compile() {
	if is_cross ; then
		einfo "ARCH = \"$(guess_arch)\""
		einfo "CROSS = \"${CTARGET}-\""
		emake ARCH=$(guess_arch) \
			CROSS="${CTARGET}-" || die "Compile failed!"
	else
		env -u ARCH \
		emake || die "Compile failed!"
	fi
}

src_install() {
	local klibc_prefix

	if is_cross ; then
		make INSTALLROOT=${D} \
			ARCH=$(guess_arch) \
			CROSS="${CTARGET}-" \
			install || die "Install failed!"

		klibc_prefix=$("${S}/klcc/${CTARGET}-klcc" -print-klibc-bindir)
	else
		env -u ARCH \
		make INSTALLROOT=${D} install || die "Install failed!"

		klibc_prefix=$("${S}/klcc/klcc" -print-klibc-bindir)
	fi

	# Hardlinks becoming copies
	for x in gunzip zcat ; do
		rm -f "${D}/${klibc_prefix}/${x}"
		dosym gzip "${klibc_prefix}/${x}"
	done

	if ! is_cross ; then
		insinto /usr/share/aclocal
		doins ${FILESDIR}/klibc.m4

		doenvd ${S}/70klibc

		dodoc ${S}/README ${S}/klibc/{LICENSE,CAVEATS}
		newdoc ${S}/klibc/README README.klibc
		newdoc ${S}/klibc/arch/README README.klibc.arch
		docinto dash; newdoc ${S}/dash/README.klibc README
		docinto gzip; dodoc ${S}/gzip/{COPYING,README}
	fi
}

pkg_postinst() {
	# Override for linux-mod eclass
	return 0
}
