# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libgphoto2/libgphoto2-2.1.3.ebuild,v 1.2 2003/11/29 23:03:17 brad_mssw Exp $

inherit libtool

MAKEOPTS="${MAKEOPTS} -j1" # or the documentation fails.

DESCRIPTION="Library that implements support for numerous digital cameras."
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc amd64"
IUSE="nls doc jpeg"

# needs >usbutils-0.11-r2 to avoid /usr/lib/libusb* 
# conflicts with dev-libs/libusb
RDEPEND=">=dev-libs/libusb-0.1.6
	>=sys-apps/usbutils-0.11-r2
	sys-apps/hotplug
	jpeg? ( >=media-libs/libexif-0.5.9 )"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.5.9
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )"

# By default, drivers for all supported cards will be compiled.
# If you want to only compile for specific card(s), set GPHOTO_LIBS
# environment to a comma-separated list (no spaces) of drivers that 
# you want to build.
#
# For example:
#
#   env GPHOTO_LIBS='canon,ptp2' emerge libgphoto2
#
# drivers: agfa-cl20, barbie, canon, casio, digita, dimera,
#          directory, fuji, gsmart300, jamcam,
#          jd11, kodak, konica, mustek, largan,
#          minolta, panasonic, pccam300, pccam600,
#          polaroid, ptp2, ricoh, samsung, smal,
#          sierra, sipix, sonydscf1, sonydscf55,
#          soundvision, spca50x, sq905, stv0680, sx330z
#
[ -z "${GPHOTO_LIBS}" ] && GPHOTO_LIBS="all"


src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.1.2-norpm.patch
}

src_compile() {
	elibtoolize

	local myconf

	myconf="--with-rpmbuild=/bin/false"

	myconf="--with-drivers=${GPHOTO_LIBS}"

	use jpeg \
		&& myconf="${myconf} --with-exif-prefix=/usr" \
		|| myconf="${myconf} --without-exif"

	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable doc docs`"

	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} \
		gphotodocdir=/usr/share/doc/${PF} \
		HTML_DIR=/usr/share/doc/${PF}/sgml \
		hotplugdocdir=/usr/share/doc/${PF}/linux-hotplug \
		install || die "install failed"

	# manually move apidocs
	if [ -n "`use doc`" ]; then
		dodir /usr/share/doc/${PF}/api
		mv ${D}/usr/share/doc/libgphoto2/html/api/* ${D}/usr/share/doc/${PF}/api/
		mv ${D}/usr/share/doc/libgphoto2_port/html/api/* ${D}/usr/share/doc/${PF}/api/
	fi
	rm -rf ${D}/usr/share/doc/libgphoto2
	rm -rf ${D}/usr/share/doc/libgphoto2_port

	dodoc ChangeLog NEWS* README AUTHORS TESTERS MAINTAINERS HACKING CHANGES

	# install hotplug support
	insinto /etc/hotplug/usb
	newins ${S}/packaging/linux-hotplug/usbcam.console usbcam
	chmod +x ${D}/etc/hotplug/usb/usbcam

	HOTPLUG_USERMAP="${D}/etc/hotplug/usb/usbcam.usermap"
	${D}/usr/lib/libgphoto2/print-usb-usermap >> ${HOTPLUG_USERMAP}
}
