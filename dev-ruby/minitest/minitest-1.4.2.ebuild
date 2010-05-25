# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-1.4.2.ebuild,v 1.11 2010/05/25 10:27:34 flameeyes Exp $

EAPI=2
# jruby → tests fail, reported upstream
# http://rubyforge.org/tracker/index.php?func=detail&aid=27657&group_id=1040&atid=4097
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

RUBY_FAKEGEM_EXTRAINSTALL="template"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="http://rubyforge.org/projects/bfts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend "
	doc? ( dev-ruby/hoe )
	test? (
		virtual/ruby-test-unit
		dev-ruby/hoe
	)"
