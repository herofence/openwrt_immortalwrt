#!/bin/bash
# 配置修改

# 0. 移除Rust包避免LLVM编译问题（编译错误修复）
echo "正在移除Rust相关包以避免LLVM编译问题..."
./scripts/feeds uninstall rust 2>/dev/null || true
# 清理可能存在的Rust配置
if [ -f ".config" ]; then
    sed -i '/CONFIG_PACKAGE_rust/d' .config
    sed -i '/CONFIG_PACKAGE_rust-bootstrap/d' .config
fi
echo "Rust包已移除"

# 1. 修改默认主题
sed -i 's/luci-theme-design/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 2. 修改 feeds 中的时间格式
find feeds/luci/ -path "*/system.lua" -exec sed -i 's/os.date("%c")/os.date("%Y-%m-%d %H:%M:%S")/g' {} \; 2>/dev/null

# 3. 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字
sed -i s/OpenWrt/herofence/g package/base-files/files/bin/config_generate
