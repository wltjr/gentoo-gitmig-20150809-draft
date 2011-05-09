# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gio/gio-0.12.0.ebuild,v 1.1 2011/05/09 14:45:16 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

#nocabaldep is for the fancy cabal-detection feature at build-time
CABAL_FEATURES="lib profile haddock hscolour nocabaldep"
inherit haskell-cabal

DESCRIPTION="Haskell bindings to the GIO subsystem of dev-libs/glib."
HOMEPAGE="http://www.haskell.org/gtk2hs/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-haskell/glib-0.12*
		dev-haskell/mtl
		>=dev-lang/ghc-6.10.1
		dev-libs/glib:2"
DEPEND="${RDEPEND}
		dev-haskell/gtk2hs-buildtools"
