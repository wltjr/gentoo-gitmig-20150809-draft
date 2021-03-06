# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/sanitize/sanitize-4.0.0-r1.ebuild,v 1.3 2015/07/29 18:54:41 grobian Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Sanitize is a whitelist-based HTML sanitizer"
HOMEPAGE="https://github.com/rgrove/sanitize"
SRC_URI="https://github.com/rgrove/sanitize/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

ruby_add_rdepend "
	>=dev-ruby/crass-1.0.2 =dev-ruby/crass-1.0*
	>=dev-ruby/nokogiri-1.4.4
	>=dev-ruby/nokogumbo-1.4.1 =dev-ruby/nokogumbo-1.4*"
ruby_add_bdepend "test? ( dev-ruby/minitest )"

all_ruby_prepare() {
	sed -i -e '/nokogumbo/ s/1.4.1/~> 1.4.1/' ${RUBY_FAKEGEM_GEMSPEC} || die
}

each_ruby_test() {
	${RUBY} -Ilib test/test_sanitize.rb || die
}
