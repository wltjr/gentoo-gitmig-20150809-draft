#!/bin/bash
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake-wrapper/files/am-wrapper-1.sh,v 1.2 2004/11/14 05:46:07 vapier Exp $

# Based on the am-wrapper.pl script provided by MandrakeSoft
# Rewritten in bash by Gregorio Guidi
#
# Executes the correct automake version.
#
# - defaults to automake-1.8
# - runs automake-1.7 if:
#   - envvar WANT_AUTOMAKE is set to `1.7'
#     -or-
#   - `Makefile.in' was generated by automake-1.7
#     -or-
#   - 'aclocal.m4' contain AM_AUTOMAKE_VERSION, specifying the use of 1.7
# - runs automake-1.6 if:
#   - envvar WANT_AUTOMAKE is set to `1.6'
#     -or-
#   - `Makefile.in'
#     -or-
#   - 'aclocal.m4' contain AM_AUTOMAKE_VERSION, specifying the use of 1.6
# - runs automake-1.5 if:
#   - envvar WANT_AUTOMAKE is set to `1.5'
#     -or-
#   - `Makefile.in' was generated by automake-1.5
#     -or-
#   - 'aclocal.m4' contain AM_AUTOMAKE_VERSION, specifying the use of 1.5
# - runs automake-1.4 if:
#   - envvar WANT_AUTOMAKE is set to `1.4'
#     -or-
#   - `Makefile.in' was generated by automake-1.4
#     -or-
#   - 'aclocal.m4' contain AM_AUTOMAKE_VERSION, specifying the use of 1.4

if [ "${0##*/}" = "am-wrapper.sh" ] ; then
	echo "Don't call this script directly." >&2
	exit 1
fi

vers="1.9 1.8 1.7 1.6 1.5 1.4)"

for v in ${vers} ; do
	eval binary_${v/./_}="${0}-${v}"
done
binary="${binary_1_9}"

#
# autodetect routine
#
for v in ${vers} x ; do
	if [ "${v}" = "x" ] ; then
		unset WANT_AUTOMAKE
		break
	fi

	if [ "${WANT_AUTOMAKE}" = "${v}" ] ; then
		binary="binary_${v/./_}"
		binary="${!binary}"
		break
	fi
done

do_awk() {
	local file=$1 ; shift
	local arg=$1 ; shift
	echo $(awk "{ if (match(\$0, \"$*\", res)) { print res[${arg}]; exit } }" ${file})
}

if [ -z "${WANT_AUTOMAKE}" ] ; then
	if [ -r "Makefile.in" ] ; then
		confversion_mf=$(do_awk Makefile.in 2 "^# Makefile.in generated (automatically )?by automake ([0-9].[0-9])")
	fi
	if [ -r "aclocal.m4" ] ; then
		confversion_ac=$(do_awk aclocal.m4 1 'generated automatically by aclocal ([0-9].[0-9])')
		confversion_am=$(do_awk aclocal.m4 1 '[[:space:]]*\\[?AM_AUTOMAKE_VERSION\\(\\[?([0-9].[0-9])[^)]*\\]?\\)')
	fi

	for v in ${vers} ; do
		if [ "${confversion_mf}" = "${v}" ] \
		   || [ "${confversion_ac}" = "${v}" ] \
		   || [ "${confversion_am}" = "${v}" ] ; then
			binary="binary_${v/./_}"
			binary="${!binary}"
			break
		fi
	done
fi

if [ "${WANT_AMWRAPPER_DEBUG}" ] ; then
	if [ "${WANT_AUTOMAKE}" ] ; then
		echo "am-wrapper: DEBUG: WANT_AUTOMAKE is set to ${WANT_AUTOMAKE}" >&2
	fi
	echo "am-wrapper: DEBUG: will execute <$binary>" >&2
fi

#
# for further consistency
#
for v in ${vers} ; do
	mybin="binary_${v/./_}"
	if [ "${binary}" = "${!mybin}" ] ; then
		export WANT_AUTOMAKE="${v}"
	fi
done

#
# Now try to run the binary
#
if [ ! -x "${binary}" ] ; then
	echo "am-wrapper: $binary is missing or not executable." >&2
	echo "            Please try emerging the correct version of automake." >&2
	exit 1
fi

exec "$binary" "$@"

echo "am-wrapper: was unable to exec $binary !?" >&2
exit 1
