# /lib/rcscripts/addons/lvm2-start.sh
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/files/lvm2-start.sh,v 1.3 2005/05/25 04:25:01 vapier Exp $

# LVM support for /usr, /home, /opt ....
# This should be done *before* checking local
# volumes, or they never get checked.
			        
# NOTE: Add needed modules for LVM or RAID, etc
#       to /etc/modules.autoload if needed
if [[ -z ${CDBOOT} ]] && [[ -x /sbin/vgscan ]] ; then
	if [[ -e /proc/modules ]] && \
	   ! grep -qs 'device-mapper' /proc/{devices,misc}
	then
		modprobe dm-mod &>/dev/null
	fi

	if [[ -d /proc/lvm ]] || grep -qs 'device-mapper' /proc/{devices,misc} ; then
		ebegin "Setting up the Logical Volume Manager"
		#still echo stderr for debugging
		/sbin/vgscan >/dev/null
		if [[ $? == 0 ]] && [[ -x /sbin/vgchange ]] && \
		   [[ -f /etc/lvmtab || -d /etc/lvm ]]
		then
			/sbin/vgchange -a y >/dev/null
		fi
		eend $? "Failed to setup the LVM"
	fi
fi

# vim:ts=4
