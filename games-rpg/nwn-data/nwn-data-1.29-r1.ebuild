# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/nwn-data/nwn-data-1.29-r1.ebuild,v 1.3 2006/11/29 15:36:58 wolf31o2 Exp $

inherit eutils games

# Diamond DVD - NWN, SoU, HotU (1 disk)
# Platinum CD/DVD - NWN, SoU (4 disks/1 disk)
# Deluxe CD - NWN, SoU, HotU (5 disks)
# Gold CD - NWN, SoU
# Original CD - NWN (1 disk)

LANGUAGES="linguas_fr linguas_it linguas_es linguas_de linguas_en"

MY_PV=${PV//.}
CLIENT_BASEURL="http://nwdownloads.bioware.com/neverwinternights/linux"
UPDATE_BASEURL="http://files.bioware.com/neverwinternights/updates/linux"

NOWIN_SRC_URI="${UPDATE_BASEURL}/nwresources${MY_PV}.tar.gz
	http://bsd.mikulas.com/nwresources${MY_PV}.tar.gz
	http://163.22.12.40/FreeBSD/distfiles/nwresources${MY_PV}.tar.gz"

LINGUAS_SRC_URI="linguas_fr? (
		${UPDATE_BASEURL}/${MY_PV}/nwfrench${MY_PV}.tar.gz )
	linguas_it? (
		${UPDATE_BASEURL}/${MY_PV}/nwitalian${MY_PV}.tar.gz )
	linguas_es? (
		${UPDATE_BASEURL}/${MY_PV}/nwspanish${MY_PV}.tar.gz )
	linguas_de? (
		${UPDATE_BASEURL}/${MY_PV}/nwgerman${MY_PV}.tar.gz )"

DESCRIPTION="Neverwinter Nights Data Files"
HOMEPAGE="http://nwn.bioware.com/downloads/linuxclient.html"
SRC_URI="${CLIENT_BASEURL}/${MY_PV}/nwclient${MY_PV}.tar.gz
	cdinstall? ( ${LINGUAS_SRC_URI} )
	nowin? ( ${NOWIN_SRC_URI} ${LINGUAS_SRC_URI} )
	mirror://gentoo/nwn.png"

LICENSE="NWN-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdinstall hou nowin sou ${LANGUAGES}"
RESTRICT="strip mirror"

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.5
	amd64? (
		app-emulation/emul-linux-x86-baselibs )"
DEPEND="${RDEPEND}
	cdinstall? (
		games-util/biounzip
		app-arch/unshield )
	amd64? ( cdinstall? ( ~app-arch/unshield-0.2 ) )
	app-arch/unzip"

QA_TEXTRELS="${GAMES_PREFIX_OPT:1}/nwn/lib/libSDL-1.2.so.0.0.5
	${GAMES_PREFIX_OPT:1}/nwn/miles/msssoft.m3d
	${GAMES_PREFIX_OPT:1}/nwn/miles/libmss.so.6.5.2
	${GAMES_PREFIX_OPT:1}/nwn/miles/mssmp3.asi
	${GAMES_PREFIX_OPT:1}/nwn/miles/mssdsp.flt"

S=${WORKDIR}/nwn

GAMES_LICENSE_CHECK=yes
dir=${GAMES_PREFIX_OPT}/nwn
Ddir=${D}/${dir}

NWN_SET=

# This is my fun section where I try to determine which CD/DVD set we have.
# Expect this to be very messy and ugly, and hopefully it all works as we want
# it to on all of the various media.
get_nwn_set() {
	# First we check to see if we have CD_ROOT defined already.  If we do,
	# this will make our lives so much easier.
	if [ -n "${CD_ROOT}" ]
	then
		if [ -f "${CD_ROOT}"/KingmakerSetup.exe ]
		then
			NWN_SET="diamond_dvd"
			einfo "Neverwinter Nights Diamond DVD found..."
		elif [ -f "${CD_ROOT}"/ArcadeInstallNWNXP213f.EXE ]
		then
			NWN_SET="platinum_cd"
			einfo "Neverwinter Nights Platinum DVD/CD set found..."
		elif [ -f "${CD_ROOT}"/ArcadeInstallNWN109.exe ]
		then
			NWN_SET="original_cd"
			einfo "Neverwinter Nights Original/Deluxe CD set found..."
		fi
	# Now we check to see if we have CD_ROOT_1 set, which means we have a CD
	# set, or even a DVD set.
	elif [ -n "${CD_ROOT_1}" ]
	then
		if [ -f "${CD_ROOT_1}"/KingmakerSetup.exe ]
		then
			NWN_SET="diamond_dvd"
			einfo "Neverwinter Nights Diamond DVD found..."
		elif [ -f "${CD_ROOT_1}"/ArcadeInstallNWNXP213f.EXE ]
		then
			NWN_SET="platinum_cd"
			einfo "Neverwinter Nights Platinum DVD/CD set found..."
		elif [ -f "${CD_ROOT_1}"/ArcadeInstallNWN109.exe ]
		then
			NWN_SET="original_cd"
			einfo "Neverwinter Nights Original/Deluxe CD set found..."
		fi
	# OK.  Neither were set, so now we're going to start our detection and try
	# to figure out what we have to work from.
	else
		local mline=
		for mline in $(mount | egrep -e '(iso|cdrom)' | awk '{print $3}')
		do
			if [ -f "${mline}"/KingmakerSetup.exe ]
			then
				NWN_SET="diamond_dvd"
				einfo "Neverwinter Nights Diamond DVD found..."
			elif [ -f "${mline}"/ArcadeInstallNWNXP213f.EXE ]
			then
				NWN_SET="platinum_cd"
				einfo "Neverwinter Nights Platinum DVD/CD set found..."
			elif [ -f "${mline}"/ArcadeInstallNWN109.exe ]
			then
				NWN_SET="original_cd"
				einfo "Neverwinter Nights Original/Original CD set found..."
			fi
		done
	fi
}

get_cd_set() {
	while `[ -z "${NWN_SET}" ]`
	do
		echo "Please insert your Neverwinter Nights CD/DVD into your drive and"
		echo "press any key to continue"
		read -n
		get_nwn_set
	done
	# Here is where we start our CD/DVD detection for changing disks.
	case "${NWN_SET}" in
	diamond_dvd)
		einfo "Both Shadows of Undrentide and Hordes of the Underdark will"
		einfo "be installed from your DVD along with Neverwinter Nights."
		touch .metadata/sou || die "touch sou"
		touch .metadata/hou || die "touch hou"
		touch .metadata/orig || die "touch orig"
		cdrom_get_cds KingmakerSetup.exe
		;;
	platinum_cd)
		einfo "Shadows of the Undentride will be installed along with"
		einfo "Neverwinter Nights.  If you also have Hordes of the"
		einfo "Underdark, it will be installed afterwards."
		touch .metadata/orig || die "touch orig"
		touch .metadata/sou || die "touch sou"
		if use hou
		then
			einfo "You will also need the HoU CD for this installation."
			cdrom_get_cds ArcadeInstallNWNXP213f.EXE \
				disk2.zip disk3.zip disk4.zip \
				ArcadeInstallNWNXP213f.EXE
		else
			cdrom_get_cds ArcadeInstallNWNXP213f.EXE \
				disk2.zip disk3.zip disk4.zip
		fi
		;;
	original_cd)
		einfo "We will be installing the original Neverwinter Nights.  If"
		einfo "you also have the Shadows of Undrentide or Hordes of the"
		einfo "Underdark expansions, they will be installed afterwards."
		touch .metadata/orig || die "touch orig"
		if use sou && use hou
		then
			einfo "You will also need the SoU and HoU CDs for this installation."
			cdrom_get_cds ArcadeInstallNWN109.exe disk2.bzf \
				movies/NWNintro.bik NWNSoUInstallGuide.rtf \
				ArcadeInstallNWNXP213f.EXE
		elif use sou
		then
			einfo "You will also need the SoU CD for this installation."
			cdrom_get_cds ArcadeInstallNWN109.exe disk2.bzf \
				movies/NWNintro.bik NWNSoUInstallGuide.rtf
		elif use hou
		then
			einfo "You will also need the HoU CD for this installation."
			cdrom_get_cds ArcadeInstallNWN109.exe disk2.bzf \
				movies/NWNintro.bik ArcadeInstallNWNXP213f.EXE
		else
			cdrom_get_cds ArcadeInstallNWN109.exe disk2.bzf \
				movies/NWNintro.bik
		fi
		;;
	esac
}

src_unpack() {
	mkdir -p "${S}"
	cd "${S}"
	# We create this .metadata directory so we can keep track of what we have
	# installed without needing to keep all of these multiple USE flags in all
	# of the ebuilds.
	mkdir -p .metadata || die "Creating .metadata"
	# Since we don't *always* want to do this, we check for USE=cdinstall
	if use cdinstall
	then
		# Here, we determine which CD/DVD set that we have.  This will seem a
		# bit odd, since we'll be doing the detection a few times.
		get_nwn_set
		# Now that we know what we're looking for, let's look for the media.
		get_cd_set

		case ${NWN_SET} in
		diamond_dvd)
			# This is probably the simplest NWN to install.
			mkdir -p "${S}"
			cd "${S}"
			einfo "Unpacking files..."
			unzip -qo "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
			# I think these are not needed.  Can someone verify this?
#			unzip -qo "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
#			unzip -qo "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
			unzip -qo "${CDROM_ROOT}"/Data_Linux.zip || die "unpacking"
			# We don't give the user the option to install SoU/HotU.  While some
			# people might complain about this, most newer NWN stuff requires
			# them both anyway, so it makes no sense not to install them.
			unzip -qo "${CDROM_ROOT}"/data/XP1.zip
			unzip -qo "${CDROM_ROOT}"/data/XP2.zip
			;;
		platinum_cd)
			# This one isn't too bad, either.  Luckily, everything in in a ZIP.
			mkdir -p "${S}"
			cd "${S}"
			einfo "Unpacking files..."
			unzip -qo "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
			unzip -qo "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
			unzip -qo "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
			einfo "Please insert disk 2"
			cdrom_load_next_cd
			einfo "Unpacking files..."
			unzip -qo "${CDROM_ROOT}"/disk2.zip || die "unpacking"
			einfo "Please insert disk 3"
			cdrom_load_next_cd
			einfo "Unpacking files..."
			unzip -qo "${CDROM_ROOT}"/disk3.zip || die "unpacking"
			einfo "Please inert disk 4"
			cdrom_load_next_cd
			einfo "Unpacking files..."
			unzip -qo "${CDROM_ROOT}"/disk4.zip || die "unpacking"
			unzip -qo "${CDROM_ROOT}"/xp1.zip || die "unpacking"
			unzip -qo "${CDROM_ROOT}"/xp1_data.zip || die "unpacking"
			if use hou
			then
				einfo "Please insert the HoU disk"
				cdrom_load_next_cd
				rm -f xp1patch.key data/xp1patch.bif override/*
				einfo "Unpacking files..."
				unzip -qo "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
				touch .metadata/hou || die "touching hou"
			fi
			;;
		original_cd)
			# Now, we need to create our directories, since we know we'll end up
			# needing them for our install.
			mkdir -p ambient data dmvault docs lib localvault miles modules \
				music nwm override texturepacks scripttemplates movies

			# Handle NWN CD1
			mkdir "${S}"/disc1_tmp
			cd "${S}"/disc1_tmp
			einfo "Unpacking files..."
			unshield x ${CDROM_ROOT}/data1.cab || die "unpacking files"
			rm -f miles/Mss32.dll
			mv -f */* .
			cd "${S}"

			mv -f disc1_tmp/*.bif data
			mv -f disc1_tmp/dungeonmaster.bic dmvault
			mv -f disc1_tmp/*.bic localvault
			mv -f disc1_tmp/*.{pdf,txt} docs
			mv -f disc1_tmp/*.erf texturepacks
			rm -rf disc1_tmp

			# NWN CD2
			einfo "Please insert disk 2"
			cdrom_load_next_cd
			biounzip ${CDROM_ROOT}/disk2.bzf . || die "unpacking files"

			# NWN CD3
			einfo "Please insert disk 3"
			cdrom_load_next_cd
			einfo "Copying files from cd..."
			for i in ambient data movies music
			do
				cp ${CDROM_ROOT}/${i}/* "${S}"/${i} || die "error copying data"
			done

			# Now, we install HoU and SoU, if necessary
			if use sou
			then
				einfo "Please insert the SoU disk"
				cdrom_load_next_cd
				einfo "Unpacking files..."
				unzip -qo "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Data_Linux.zip || die "unpacking"
				touch .metadata/sou || die "touching sou"
			fi
			if use hou
			then
				einfo "Please insert the HoU disk"
				cdrom_load_next_cd
				if use sou && use hou
				then
					rm -f xp1patch.key data/xp1patch.bif override/*
				fi
				einfo "Unpacking files..."
				unzip -qo "${CDROM_ROOT}"/Data_Shared.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_data.zip || die "unpacking"
				unzip -qo "${CDROM_ROOT}"/Language_update.zip || die "unpacking"
				touch .metadata/hou || die "touching hou"
			fi
			unpack nwclient${MY_PV}.tar.gz
			cd "${WORKDIR}"
			unpack nwresources${MY_PV}.tar.gz \
				|| die "unpacking nwresources${MY_PV}.tar.gz"
			cd "${S}"
			;;
		esac
	elif use nowin
	then
		unpack nwclient${MY_PV}.tar.gz
		cd "${WORKDIR}"
		unpack nwresources${MY_PV}.tar.gz \
			|| die "unpacking nwresources${MY_PV}.tar.gz"
		cd "${S}"
	fi

	rm -rf override/*
	for a in ${A}
	do
	    currentlocale=""
	    if [ -z ${a/*german*/} ]
	    then
	        currentlocale=de
	    elif [ -z ${a/*spanish*/} ]
	    then
	    	currentlocale=es
		elif [ -z ${a/*italian*/} ]
		then
			currentlocale=it
		elif [ -z ${a/*french*/} ]
		then
			currentlocale=fr
		fi
		if [ -n "$currentlocale" ]
		then
			touch ".metadata/linguas_$currentlocale"
			mkdir -p $currentlocale
			cd ${currentlocale}
			unpack ${a} || die "unpacking ${a}"
		fi
	done
	if use linguas_en
	then
		touch ".metadata/linguas_en"
	fi
	# These files aren't needed and come from the patches (games-rpg/nwn)
	rm -f data/patch.bif patch.key
	sed -i -e 's,/bin/sh,/bin/bash,g' -e '\:^./nwmain .*:i \
'"dir='${dir}';LINGUAS='${LINGUAS}'"' \
die() { \
	echo "$*" 1>&2 \
	exit 1 \
} \
cd "${dir}" || die "cd ${dir}" \
if [[ -d "$LANG" ]] \
then \
	p=${HOME}/.nwn/${LANG} \
elif [[ -d "en" ]] \
then \
	LANG=en \
	p=${HOME}/.nwn/${LANG} \
else \
	LANG="" \
	p=${HOME}/.nwn \
	for i in ${LINGUAS} \
	do \
		if [ -z "${LANG}" -a -r ".metadata/linguas_$i" -a -d "$i" ] \
		then \
			LANG=$i \
			p=${HOME}/.nwn \
		fi \
	done \
fi \
mkdir -p "${p}" \
find "${p}" -type l -delete \
for i in * ; do \
	if [[ ! -f ".metadata/linguas_${i}" ]] \
	then \
		cp -rfs ${dir}/${i} ${p}/. || die "copy ${i}" \
	fi \
done \
if [[ -n "$LANG" ]] \
then \
	cd "${LANG}" || die "cd ${LANG}" \
	for i in * ; do \
		cp -rfs ${dir}/${LANG}/${i} ${p}/. || die "copy ${LANG}/${i}" \
	done \
fi \
cd "${p}" || die "cd ${p}" \
if [[ -r ./nwmouse.so ]]; then \
	export XCURSOR_PATH="$(pwd)" \
	export XCURSOR_THEME=nwmouse \
	export LD_PRELOAD=./nwmouse.so:$LD_PRELOAD \
fi \
	' "${S}"/nwn || die "sed nwn"
}

src_install() {
	dodir "${dir}"
	mkdir -p "${S}"/dmvault "${S}"/hak "${S}"/portraits "${S}"/localvault
	rm -rf "${S}"/dialog.tlk "${S}"/dialog.TLK "${S}"/dialogf.tlk \
		"${S}"/dmclient "${S}"/nwmain "${S}"/nwserver  "${S}"/nwm/* \
		"${S}"/SDL-1.2.5 "${S}"/fixinstall
	mv "${S}"/* "${Ddir}"
	mv "${S}"/.metadata "${Ddir}"
	keepdir "${dir}"/servervault
	keepdir "${dir}"/scripttemplates
	keepdir "${dir}"/saves
	keepdir "${dir}"/portraits
	keepdir "${dir}"/hak
	cd "${Ddir}"
	for d in ambient data dmvault hak localvault music override portraits
	do
		if [ -d ${d} ]
		then
			( cd ${d}
			for f in $(find . -name '*.*') ; do
				lcf=$(echo ${f} | tr [:upper:] [:lower:])
				if [ ${f} != ${lcf} ] && [ -f ${f} ]
				then
					mv ${f} ${lcf}
				fi
			done )
		fi
	done
	if ! use sou && ! use hou && use nowin
	then
		if [ -f data/patch.bif ]
		then
			chmod a-x data/patch.bif
		fi
		if [ -f patch.key ]
		then
			chmod a-x patch.key
		fi
	fi
	doicon "${DISTDIR}"/nwn.png

	prepgamesdirs
	chmod -R g+rwX ${Ddir}/saves ${Ddir}/localvault ${Ddir}/dmvault \
		2>&1 > /dev/null || die "could not chmod"
	chmod g+rwX ${Ddir} || die "could not chmod"
}

pkg_postinst() {
	games_pkg_postinst
	if ! use cdinstall || ! use nowin ; then
		elog "The NWN linux client data is now installed."
		elog "Proceed with the following steps in order to get it working:"
		elog "1) Copy the following directories/files from your installed and"
		elog "   patched (1.68) Neverwinter Nights to ${dir}:"
		elog "    ambient/"
		elog "    data/"
		elog "    dmvault/"
		elog "    hak/"
		elog "    localvault/"
		elog "    modules/"
		elog "    music/"
		elog "    portraits/"
		elgo "    saves/"
		elog "    servervault/"
		elog "    texturepacks/"
		elog "    chitin.key"
		elog "2) Remove some files to make way for the patch"
		elog "    rm ${dir}/music/mus_dd_{kingmaker,shadowgua,witchwake}.bmu"
		elog "    rm ${dir}/override/iit_medkit_001.tga"
		elog "    rm ${dir}/data/patch.bif"
		if use sou
		then
			elog "    rm ${dir}/xp1patch.key ${dir}/data/xp1patch.bif"
		fi
		if use hou
		then
			elog "    rm ${dir}/xp2patch.key ${dir}/data/xp2patch.bif"
		fi
		elog "3) Chown and chmod the files with the following commands"
		elog "    chown -R ${GAMES_USER}:${GAMES_GROUP} ${dir}"
		elog "    chmod -R g+rwX ${dir}"
		echo
		elog "Or try emerging with USE=nowin"
		echo
	else
		einfo "The NWN linux client data is now installed."
		echo
	fi
	elog "This is only the data portion, you will also need games-rpg/nwn to"
	elog "play Neverwinter Nights."
	echo
}
