#!/bin/bash
set -e

PKG_NAME="com.your.application.name"
DEVICE="R39M30DEZZW"
frida -D $DEVICE -f $PKG_NAME --no-pause -l agent.js
