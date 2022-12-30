#!/bin/bash
set -e

PKG_NAME="com.secuchart.android.jarvis"
DEVICE="R39M30DEZZW"
frida -D $DEVICE -f $PKG_NAME --no-pause -l agent.js
