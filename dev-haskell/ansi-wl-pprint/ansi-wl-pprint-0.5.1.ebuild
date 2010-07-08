# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ansi-wl-pprint/ansi-wl-pprint-0.5.1.ebuild,v 1.2 2010/07/08 12:18:38 slyfox Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="The Wadler/Leijen Pretty Printer for colored ANSI terminal output"
HOMEPAGE="http://github.com/batterseapower/ansi-wl-pprint"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		 >=dev-haskell/ansi-terminal-0.4.0"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"
