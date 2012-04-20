# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rails/rails-3.2.3.ebuild,v 1.1 2012/04/20 07:35:17 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem versionator

DESCRIPTION="ruby on rails is a web-application and persistance framework"
HOMEPAGE="http://www.rubyonrails.org"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE="+asset-pipeline"

ruby_add_rdepend "
	~dev-ruby/actionmailer-${PV}
	~dev-ruby/actionpack-${PV}
	~dev-ruby/activerecord-${PV}
	~dev-ruby/activeresource-${PV}
	~dev-ruby/activesupport-${PV}
	=dev-ruby/bundler-1*
	~dev-ruby/railties-${PV}
	asset-pipeline? (
		dev-ruby/jquery-rails
		>=dev-ruby/sass-rails-3.2.3:3.2
		>=dev-ruby/uglifier-1.0.3
		>=dev-ruby/coffee-rails-3.2.1:3.2
	)"
