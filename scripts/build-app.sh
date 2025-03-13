#!/bin/bash

fastlane build_dmg
create-dmg './build/ShutterMac.app' './build/' --overwrite