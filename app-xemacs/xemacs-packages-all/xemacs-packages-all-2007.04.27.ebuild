# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/xemacs-packages-all/xemacs-packages-all-2007.04.27.ebuild,v 1.1 2008/04/23 19:12:19 graaff Exp $

DESCRIPTION="Meta package for XEmacs elisp packages, similar to the sumo archives."
HOMEPAGE="http://www.xemacs.org/"

LICENSE="as-is"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

IUSE="mule"

RDEPEND="
	>=app-xemacs/ada-1.14
	>=app-xemacs/apel-1.32
	>=app-xemacs/auctex-1.47
	>=app-xemacs/bbdb-1.32
	>=app-xemacs/build-1.14
	>=app-xemacs/c-support-1.22
	>=app-xemacs/calc-1.26
	>=app-xemacs/calendar-1.32
	>=app-xemacs/cc-mode-1.45
	>=app-xemacs/clearcase-1.10
	>=app-xemacs/cookie-1.15
	>=app-xemacs/crisp-1.15
	>=app-xemacs/debug-1.18
	>=app-xemacs/dictionary-1.16
	>=app-xemacs/dired-1.17
	>=app-xemacs/docbookide-0.08
	>=app-xemacs/ecb-1.22
	>=app-xemacs/ecrypto-0.20
	>=app-xemacs/edebug-1.22
	>=app-xemacs/ediff-1.68
	>=app-xemacs/edit-utils-2.37
	>=app-xemacs/edt-1.13
	>=app-xemacs/efs-1.33
	>=app-xemacs/eieio-1.05
	>=app-xemacs/elib-1.11
	>=app-xemacs/emerge-1.11
	>=app-xemacs/erc-0.21
	>=app-xemacs/escreen-1.01
	>=app-xemacs/eshell-1.10
	>=app-xemacs/eudc-1.39
	>=app-xemacs/footnote-1.16
	>=app-xemacs/forms-1.15
	>=app-xemacs/fortran-modes-1.05
	>=app-xemacs/frame-icon-1.11
	>=app-xemacs/fsf-compat-1.15
	>=app-xemacs/games-1.17
	>=app-xemacs/general-docs-1.04
	>=app-xemacs/gnats-1.17
	>=app-xemacs/gnus-1.91
	>=app-xemacs/haskell-mode-1.11
	>=app-xemacs/hm-html-menus-1.23
	>=app-xemacs/hyperbole-1.16
	>=app-xemacs/ibuffer-1.09
	>=app-xemacs/idlwave-1.32
	>=app-xemacs/igrep-1.14
	>=app-xemacs/ilisp-1.34
	>=app-xemacs/jde-1.51
	>=app-xemacs/mail-lib-1.79
	>=app-xemacs/mailcrypt-2.14
	>=app-xemacs/mew-1.19
	>=app-xemacs/mh-e-1.29
	>=app-xemacs/mine-1.16
	>=app-xemacs/misc-games-1.19
	>=app-xemacs/mmm-mode-1.02
	>=app-xemacs/net-utils-1.52
	>=app-xemacs/ocaml-0.06
	>=app-xemacs/oo-browser-1.04
	>=app-xemacs/os-utils-1.39
	>=app-xemacs/pc-1.28
	>=app-xemacs/pcl-cvs-1.67
	>=app-xemacs/pcomplete-1.04
	>=app-xemacs/perl-modes-1.09
	>=app-xemacs/pgg-1.06
	>=app-xemacs/prog-modes-2.10
	>=app-xemacs/ps-print-1.11
	>=app-xemacs/psgml-1.44
	>=app-xemacs/psgml-dtds-1.03
	>=app-xemacs/python-modes-1.08
	>=app-xemacs/re-builder-1.05
	>=app-xemacs/reftex-1.34
	>=app-xemacs/riece-1.23
	>=app-xemacs/rmail-1.14
	>=app-xemacs/ruby-modes-1.02
	>=app-xemacs/sasl-1.16
	>=app-xemacs/scheme-1.15
	>=app-xemacs/semantic-1.20
	>=app-xemacs/sgml-1.11
	>=app-xemacs/sh-script-1.22
	>=app-xemacs/sieve-1.18
	>=app-xemacs/slider-1.15
	>=app-xemacs/sml-mode-0.12
	>=app-xemacs/sounds-au-1.12
	>=app-xemacs/sounds-wav-1.12
	>=app-xemacs/speedbar-1.28
	>=app-xemacs/strokes-1.10
	>=app-xemacs/sun-1.16
	>=app-xemacs/supercite-1.21
	>=app-xemacs/texinfo-1.30
	>=app-xemacs/text-modes-1.92
	>=app-xemacs/textools-1.15
	>=app-xemacs/time-1.14
	>=app-xemacs/tm-1.38
	>=app-xemacs/tooltalk-1.15
	>=app-xemacs/tpu-1.14
	>=app-xemacs/tramp-1.37
	>=app-xemacs/vc-1.41
	>=app-xemacs/vc-cc-1.22
	>=app-xemacs/vhdl-1.22
	>=app-xemacs/view-process-1.13
	>=app-xemacs/viper-1.55
	>=app-xemacs/vm-7.22
	>=app-xemacs/w3-1.33
	>=app-xemacs/x-symbol-1.10
	>=app-xemacs/xemacs-base-2.10
	>=app-xemacs/xemacs-devel-1.75
	>=app-xemacs/xemacs-eterm-1.17
	>=app-xemacs/xemacs-ispell-1.32
	>=app-xemacs/xetla-1.01
	>=app-xemacs/xlib-1.14
	>=app-xemacs/xslide-1.09
	>=app-xemacs/xslt-process-1.12
	>=app-xemacs/xwem-1.22
	>=app-xemacs/zenirc-1.16

	mule? (
	>=app-xemacs/latin-unity-1.20
	>=app-xemacs/egg-its-1.27
	>=app-xemacs/lookup-1.15
	>=app-xemacs/skk-1.23
	>=app-xemacs/edict-1.16
	>=app-xemacs/latin-euro-standards-1.07
	>=app-xemacs/leim-1.24
	>=app-xemacs/locale-1.24
	>=app-xemacs/mule-base-1.49
	>=app-xemacs/mule-ucs-1.14
	)

	!app-xemacs/xemacs-packages-sumo
"

