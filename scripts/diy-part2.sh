#!/bin/bash
# 配置修改

# 1. 修改默认主题
sed -i 's/luci-theme-design/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 2. 修改 feeds 中的时间格式
find feeds/luci/ -path "*/system.lua" -exec sed -i 's/os.date("%c")/os.date("%Y-%m-%d %H:%M:%S")/g' {} \; 2>/dev/null

# 3. 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把herofence修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i s/OpenWrt/herovence/g package/base-files/files/bin/config_generate

# 4. 修复第三方 dockerman 版本号（APK 包管理器不允许 v 前缀）
if [ -d "package/community/luci-app-dockerman" ]; then
    echo "修复 luci-app-dockerman 版本号格式..."
    find package/community/luci-app-dockerman -name "Makefile" -type f | while read makefile; do
        echo "处理: $makefile"
        # 修复 PKG_VERSION
        sed -i 's/PKG_VERSION:=v\([0-9]\)/PKG_VERSION:=\1/' "$makefile"
        # 修复 PKG_SOURCE_VERSION（如果是 v 开头的 tag）
        sed -i 's/PKG_SOURCE_VERSION:=v/PKG_SOURCE_VERSION:=/' "$makefile"
        # 显示修改后的版本号
        grep -E "PKG_VERSION|PKG_SOURCE_VERSION" "$makefile" | head -5
    done
fi

# 5. 确保中文语言包存在
if [ -d "package/community/luci-app-dockerman" ]; then
    echo "检查 dockerman 中文语言包..."
    find package/community/luci-app-dockerman -path "*luci-i18n-dockerman-zh-cn*" -type d | head -5
fi
