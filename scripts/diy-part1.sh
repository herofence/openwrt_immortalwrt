#!/bin/bash
# Feed setup for immortalwrt/immortalwrt. Runs inside the source tree, before
# `feeds update`.

# ImmortalWrt ships luci-app-passwall in its own luci feed but has no ssr-plus,
# so pull in the helloworld feed for it. Appended rather than uncommented:
# ImmortalWrt's feeds.conf.default has no helloworld line to uncomment.
grep -q '^src-git helloworld ' feeds.conf.default || \
  echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default
