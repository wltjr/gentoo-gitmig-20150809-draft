# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/glproto/glproto-1.4.14.ebuild,v 1.2 2011/07/08 22:42:15 abcd Exp $

EAPI=4
inherit xorg-2
DESCRIPTION="X.Org GL protocol headers"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
LICENSE="SGI-B-2.0"
IUSE=""

RDEPEND="app-admin/eselect-opengl"
DEPEND=""

src_install() {
	xorg-2_src_install
	dynamic_libgl_install
}

pkg_postinst() {
	xorg-2_pkg_postinst
	eselect opengl set --use-old xorg-x11
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving GL files for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/xorg-x11/include
		local x=""
		# glext.h added for #54984
		for x in "${ED}"/usr/include/GL/{glxtokens.h,glxmd.h,glxproto.h}; do
			if [[ -f ${x} || -L ${x} ]]; then
				mv -f "${x}" "${ED}"/usr/$(get_libdir)/opengl/xorg-x11/include
			fi
		done
	eend 0
}
