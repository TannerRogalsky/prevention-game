#!/bin/bash

#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

#----------------------------------------------------------------#
# path to Android SDK folder (on Windows, you MUST use forward
# slashes as directory separators, e.g. C:/android-sdk)
#----------------------------------------------------------------#

	android_sdk_root="/Users/tanner/code/android/android-sdk-macosx"

#----------------------------------------------------------------#
# space-delimited list of source lua directories to add to the
# application bundle and corresponding destination directories in
# the assets directory of the bundle
#----------------------------------------------------------------#

	src_dirs=("src" "src/fonts" "src/images" "src/lib")
	dest_dirs=("lua" "lua/fonts" "lua/images" "lua/lib")

#----------------------------------------------------------------#
# debug & release settings
# you must define key store data in order to build for release
#----------------------------------------------------------------#

	debug=true
	key_store=
	key_alias=
	key_store_password=
	key_alias_password=