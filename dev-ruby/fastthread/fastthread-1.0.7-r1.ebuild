# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fastthread/fastthread-1.0.7-r1.ebuild,v 1.3 2009/12/26 08:30:01 graaff Exp $

EAPI=2

USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG"

inherit ruby-fakegem

DESCRIPTION="Optimized replacement for thread.rb primitives"
HOMEPAGE="http://gemcutter.org/gems/fastthread"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend '>=dev-ruby/echoe-2.7.11 dev-ruby/rake'
ruby_add_bdepend test virtual/ruby-test-unit

all_ruby_prepare() {
	sed -i -e 's|if Platform|if Echoe::Platform|' Rakefile || die
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "build failed"
}
