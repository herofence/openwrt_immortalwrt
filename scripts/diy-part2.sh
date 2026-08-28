#!/bin/bash
# Shared post-feed customisation. Runs inside the source tree, after
# `feeds install` and after .config is in place.

# Default LAN address.
sed -i 's/192.168.1.1/192.168.31.111/g' package/base-files/files/bin/config_generate
