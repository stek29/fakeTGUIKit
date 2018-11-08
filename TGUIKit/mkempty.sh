#!/bin/sh
cd "$(dirname "$0")"
echo > empty.c
clang -shared empty.c -install_name @rpath/TGUIKitORIG.framework/Versions/A/TGUIKitORIG -o empty.dylib
rm empty.c
