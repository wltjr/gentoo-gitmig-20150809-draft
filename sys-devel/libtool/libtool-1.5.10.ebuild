# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.5.10.ebuild,v 1.4 2004/11/12 15:21:00 vapier Exp ${P}-r1.ebuild,v 1.8 2002/10/04 06:34:42 kloeri Exp $

inherit eutils gnuconfig libtool

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.5"
# breaks building .so completely (emerge fam)
KEYWORDS="-*"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="uclibc"

DEPEND="virtual/libc
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.8.3"
# the autoconf dep is due to it complaining 'configure.ac:55: error: Autoconf version 2.58 or higher is required'
# the automake dep is due to Bug #46037

lt_setup() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
}

gen_ltmain_sh() {
	local date=
	local PACKAGE=
	local VERSION=

	rm -f ltmain.shT
	date=`./mkstamp < ./ChangeLog` && \
	eval `egrep '^[[:space:]]*PACKAGE' configure` && \
	eval `egrep '^[[:space:]]*VERSION' configure` && \
	sed -e "s/@PACKAGE@/${PACKAGE}/" -e "s/@VERSION@/${VERSION}/" \
		-e "s%@TIMESTAMP@%$date%" ./ltmain.in > ltmain.shT || return 1

	mv -f ltmain.shT ltmain.sh || {
		(rm -f ltmain.sh && cp ltmain.shT ltmain.sh && rm -f ltmain.shT)
		return 1
	}

	return 0
}

src_unpack() {
	lt_setup

	unpack ${A}

	cd ${S}

	# Make sure non of the patches touch ltmain.sh, but rather ltmain.in
	rm -f ltmain.sh*

	# Redhat patches
	epatch ${FILESDIR}/1.4.3/${PN}-1.4-nonneg.patch
	# Fix the relink problem where the relinked libs do not get
	# installed.  It is *VERY* important that you get a updated
	# 'libtool-1.4.3-relink.patch' if you update this, as it
	# fixes a very serious bug.  Please not that this patch is
	# included in 'libtool-1.4.3-gentoo.patch' for this ebuild.
	#
	# NOTE: all affected apps should get a 'libtoolize --copy --force'
	#      added to update libtool
	#
# Seems to be included in shipped tarball ...
#	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-relink-58664.patch

	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-multilib.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-demo.patch
# Seems to be included in shipped tarball ...
#	epatch ${FILESDIR}/1.5.2/${PN}-1.5-libtool.m4-x86_64.patch
	epatch ${FILESDIR}/1.5.2/${PN}-1.5-testfailure.patch
	# Mandrake patches
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.3-lib64.patch
# Fix bug #43244
#	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-fix-linkage-of-cxx-code-with-gcc.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-archive-shared.patch
	epatch ${FILESDIR}/1.5.6/${PN}-1.5.6-ltmain-SED.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-expsym-linux.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.3-amd64-alias.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.3-libtoolize--config-only.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.3-pass-thread-flags.patch

	# Gentoo Patches
	# Do not create bogus entries in $dependency_libs or $libdir
	# with ${D} or ${S} in them.
	# <azarah@gentoo.org> - (07 April 2002)
	epatch ${FILESDIR}/1.4.3/${PN}-1.4.2-portage.patch
	# If a package use an older libtool, and libtool.m4 for that
	# package is updated, but not libtool, then we run into an
	# issue where $shared_ext is not set.  This results in libraries
	# being built without '.so' extension, bug #40901
	# <azarah@gentoo.org> - (11 Feb 2004)
	epatch ${FILESDIR}/1.5.6/${PN}-1.5.6-libtool_m4-shared_ext.patch
	# For older autoconf setups's that do not support libtool.m4,
	# $max_cmd_len are never set, causing all tests against it to
	# fail, resulting in 'integer expression expected' errors and
	# possible misbehaviour.
	# <azarah@gentoo.org> - (11 Feb 2004)
	epatch ${FILESDIR}/1.5.2/${PN}-1.5.2-ltmain_sh-max_cmd_len.patch

	# Libtool's autoguessing at tag's sucks ... it get's confused 
	# if the tag's CC says '<CHOST>-gcc' and the env CC says 'gcc'
	# or vice versa ... newer automakes specify the tag so no
	# guessing is needed #67692
	epatch ${FILESDIR}/1.5.6/libtool-1.5-filter-host-tags.patch

	einfo "Generate ltmain.sh ..."
	gen_ltmain_sh || die "Failed to generate ltmain.sh!"

	uclibctoolize
	gnuconfig_update ${WORKDIR}
}

src_compile() {
	lt_setup
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	if use uclibc ; then
		for x in $(find ${D} -name config.guess -o -name config.sub) ; do
			rm -f ${x}; ln -sf ../gnuconfig/$(basename ${x}) ${x}
		done
		cd ${D}/usr/share/libtool/libltdl
		for x in config.guess config.sub ; do
			rm -f ${x} ; ln -sfn ../${x} ${x}
		done
	fi
}
