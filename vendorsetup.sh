#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2023 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="X01AD"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep \"$FDEVICE\")
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
   	export TW_DEFAULT_LANGUAGE="en"
   	export DEVICE_PATH="device/asus/X01AD"
	export INCLUDE_PATH="$DEVICE_PATH/include"
    export LC_ALL="C"
	export OF_KEEP_FORCED_ENCRYPTION=1
	export FOX_ENABLE_APP_MANAGER=1
	export OF_USE_MAGISKBOOT=1
	export OF_USE_NEW_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_USE_GREEN_LED=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_ZIP_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_REPLACE_BUSYBOX_PS=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021
    export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
	export OF_UNBIND_SDCARD_F2FS=1

    # use system (ROM) fingerprint where available
    export OF_USE_SYSTEM_FINGERPRINT=1

	# vanilla build
	export OF_VANILLA_BUILD=1
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

    # Screen Setting
    export OF_SCREEN_H=2280
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export ALLOW_DISABLE_NAVBAR=0
    export OF_CLOCK_POS=2
    export OF_HIDE_NOTCH=1

    #R
    export OF_MAINTAINER_AVATAR="$INCLUDE_PATH/zain.jpg"
    export OF_MAINTAINER="AssunZain"
    export FOX_VERSION="R11.1"
	export FOX_BUILD_TYPE="Beta"

    # Magisk
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk.zip
	if [ -n "${FOX_USE_SPECIFIC_MAGISK_ZIP}" ]; then
		if [ ! -e "${FOX_USE_SPECIFIC_MAGISK_ZIP}" ]; then
			echo "Downloading the Latest Release of Magisk..."
			LATEST_MAGISK_URL="$(curl -sL https://api.github.com/repos/topjohnwu/Magisk/releases/latest | grep browser_download_url | grep Magisk- | cut -d : -f 2,3 | sed 's/"//g')"
			wget -q ${LATEST_MAGISK_URL} -O ${FOX_USE_SPECIFIC_MAGISK_ZIP} || wget ${LATEST_MAGISK_URL} -O ${FOX_USE_SPECIFIC_MAGISK_ZIP}
			[ "$?" = "0" ] && echo "Magisk Downloaded Successfully"
			echo "Done!"
		fi
	fi

	# dispense with the entire OTA menu
	export OF_DISABLE_OTA_MENU=1

	# run a process after formatting data to work-around MTP issues
	export OF_RUN_POST_FORMAT_PROCESS=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
#
