#!/usr/bin/env bash

print_usage() {
	echo "Usage:"
	echo " $0 patch  path/to/Telegram.app path/to/TGUIKit.framework"
	echo " $0 revert path/to/Telegram.app"
}
if [ $# != 2 -a $# != 3 ]; then
	print_usage
	exit 1
fi

patch() {
	if [ ! -d "$1" -o ! -d "$2" ]; then
		print_usage
		exit 1
	fi

	if [ -d "$1/Contents/Frameworks/TGUIKitORIG.framework" ]; then
		echo "Already patched"
		exit 1
	fi

	OLDPWD="$PWD"

	cd "$1/Contents/Frameworks"

	mv TGUIKit.framework TGUIKitORIG.framework
	cd TGUIKitORIG.framework

	rm TGUIKit
	ln -s Versions/Current/TGUIKitORIG TGUIKitORIG

	cd Versions/A
	mv TGUIKit TGUIKitORIG
	cp TGUIKitORIG TGUIKitORIG.orig
	install_name_tool -id @rpath/TGUIKitORIG.framework/Versions/A/TGUIKitORIG TGUIKitORIG

	unsign TGUIKitORIG
	rm TGUIKitORIG
	mv TGUIKitORIG.unsigned TGUIKitORIG

	cd "$OLDPWD"
	cp -r "$2" "$1/Contents/Frameworks/TGUIKit.framework"
}

revert() {
	if [ ! -d "$1/Contents/Frameworks/TGUIKitORIG.framework" ]; then
	  echo "Not patched"
	  exit 1
	fi

	cd "$1/Contents/Frameworks"

	rm -rf TGUIKit.framework
	mv TGUIKitORIG.framework TGUIKit.framework
	
	cd TGUIKit.framework
	rm TGUIKitORIG
	ln -s Versions/Current/TGUIKit TGUIKit
	
	cd Versions/A
	mv TGUIKitORIG.orig TGUIKit
	rm TGUIKitORIG
}

if [ "$1" == patch ]; then
	patch "$2" "$3"
elif [ "$1" == revert ]; then
	revert "$2"
else
	print_usage
	exit 1
fi
