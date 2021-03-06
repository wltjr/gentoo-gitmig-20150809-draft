# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/labltk/labltk-8.06.0.ebuild,v 1.5 2014/12/19 08:44:08 aballier Exp $

EAPI=5

inherit findlib eutils

DESCRIPTION="OCaml interface to the Tcl/Tk GUI framework"
HOMEPAGE="https://forge.ocamlcore.org/projects/labltk/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/1455/${P}.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd ~x86-linux"
IUSE="+ocamlopt X"

RDEPEND=">=dev-lang/tk-8.0.3
	>=dev-lang/ocaml-4.02:=[ocamlopt?,X?]"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-1.5.5-r1"

src_prepare() {
	epatch "${FILESDIR}/findlib.patch"
}

src_configure() {
	./configure --use-findlib --verbose $(use X || echo "--tk-no-x11") || die "configure failed!"
}

src_compile() {
	emake
	use ocamlopt && emake opt
}

src_install() {
	findlib_src_preinst
	dodir /usr/bin
	emake \
		INSTALLDIR="${D}$(ocamlc -where)/labltk" \
		INSTALLBINDIR="${ED}/usr/bin/" \
		install
	dodoc Changes README.mlTk
}
