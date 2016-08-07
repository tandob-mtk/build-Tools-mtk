#!/bin/bash

# Script based on ResurrectionRemix

normal='tput sgr0'              # White
red='tput setaf 1'              # Red
green='tput setaf 2'            # Green
yellow='tput setaf 3'           # Yellow
blue='tput setaf 4'             # Blue
violet='tput setaf 5'           # Violet
cyan='tput setaf 6'             # Cyan
white='tput setaf 7'            # White
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) # Bold Red
bldgrn=${txtbld}$(tput setaf 2) # Bold Green
bldblu=${txtbld}$(tput setaf 4) # Bold Blue
bldylw=$(txtbld)$(tput setaf 3) # Bold Yellow
bldvlt=${txtbld}$(tput setaf 5) # Bold Violet
bldcya=${txtbld}$(tput setaf 6) # Bold Cyan
bldwht=${txtbld}$(tput setaf 7) # Bold White
clear
        echo -e "${bldcya}           Building Custom ROM!        "
tput setaf 3
        sleep 1
        echo
        echo Repo Sync the sources...
        echo
	sleep 2
tput setaf 2
        repo init -u git://github.com/tandob-mtk/android-mtk.git -b cm-13.0-mt6592
        repo sync -j1 -f --force-sync --no-clone-bundle
tput setaf 3
        sleep 3
        echo
        echo Setting up Build Environment...
        echo
	sleep 4
tput setaf 2
        source build/envsetup.sh
        make clean && make clobber
tput setaf 3
	echo  
	if [ ! $1 ];
	then
	echo What is your device code name?
	tput setaf 4
	read device
	else
	device=$1
	fi
tput setaf 3
	echo -e "You have chosen to build for ${bldred} ${device}"
	echo  
	echo -e "${bldvlt}Building Rom now!"
	echo  
	sleep 5
tput setaf 2
	logfile="$device-$(date +%Y%m%d).log"
	breakfast $device && time mka bacon 2>&1 | tee $logfile
	if [ $? -eq 0 ]; then
	printf "Build Suceeded, grab your zip at $(ls ${OUT}/tandob_*.zip)\nBuild log is at ${logfile} incase you need it\n";
	else
	printf "Build failed, check the log at ${logfile}\n";
	exit 1;
	fi
