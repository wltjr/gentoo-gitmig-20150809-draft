# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/metaclass/metaclass-0.0.1.ebuild,v 1.4 2012/02/09 18:06:16 grobian Exp $

EAPI=4
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Adds a __metaclass__ method to all Ruby objects."
HOMEPAGE="https://github.com/floehopper/metaclass"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

all_ruby_prepare() {
	sed -i -e '/bundler/ s:^:#:' Rakefile test/test_helper.rb || die
}
