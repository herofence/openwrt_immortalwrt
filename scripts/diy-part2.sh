#!/bin/bash
#配置修改
#1、修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# 2. 更改boot分区大小为1M
sed -i 's/256/1024/g' target/linux/x86/image/Makefile
