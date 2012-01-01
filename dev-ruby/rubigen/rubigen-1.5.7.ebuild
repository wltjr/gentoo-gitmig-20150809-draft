# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubigen/rubigen-1.5.7.ebuild,v 1.1 2012/01/01 08:47:38 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.rdoc Todo.txt"

RUBY_FAKEGEM_EXTRAINSTALL="app_generators generators rubygems_generators script test_unit_generators"

inherit ruby-fakegem

DESCRIPTION="A framework to allow Ruby applications to generate file/folder stubs."
HOMEPAGE="https://github.com/drnic/rubigen"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

# The presence of a self-dependency is needed as per bug #320781;
# since this is a bad situation, don't close the bug, but try working
# it around.
ruby_add_bdepend "test? (
	>=dev-ruby/mocha-0.9.8
	>=dev-ruby/shoulda-2.10.3
	>=dev-util/cucumber-0.6.2
	>=dev-ruby/hoe-2.5.0
	=${CATEGORY}/${PF}
)"

ruby_add_rdepend "=dev-ruby/activesupport-2.3*"

all_ruby_prepare() {
	# Remove newgem requirement from the Rakefile since it is not
	# needed for our purposes and we don't have it in CVS.
	sed -i '/newgem/d' Rakefile || die "Unable to remove unneeded newgem support."

	# Provide missing file for test_generate_builtin_application.rb
	mkdir -p app_generators/ruby_app/templates/configs || die
	touch app_generators/ruby_app/templates/configs/empty_log || die

	# Needs to be explicit, most likely due to changes in newer cucumber.
	sed -i -e '2 i  include Spec::Matchers' features/support/matchers.rb || die
}

each_ruby_test() {
	each_fakegem_test

	# Run all features not related to creating and distributing the gem itself
	${RUBY} -S cucumber features/help.feature features/rubigen_cli.feature || die "tests failed"
}
