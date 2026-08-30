#!/bin/bash
# 配置修改

# 1. 修改默认主题
sed -i 's/luci-theme-design/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 2. 修改 feeds 中的时间格式
find feeds/luci/ -path "*/system.lua" -exec sed -i 's/os.date("%c")/os.date("%Y-%m-%d %H:%M:%S")/g' {} \; 2>/dev/null

# 3. 修改默认IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 4.修改主机名字，把herofence修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i s/OpenWrt/herovence/g package/base-files/files/bin/config_generate
# 5.修复第三方 dockerman 版本号（更全面的处理）
if [ -d "package/community/luci-app-dockerman" ]; then
    echo "修复 luci-app-dockerman 版本号格式..."
    # 查找所有 Makefile
    find package/community/luci-app-dockerman -name "Makefile" -type f | while read makefile; do
        echo "处理: $makefile"
        # 备份原始文件
        cp "$makefile" "$makefile.bak"
        # 修复各种可能的版本号格式问题
        # 1. PKG_VERSION:=v0.5.26 -> PKG_VERSION:=0.5.26
        sed -i 's/^PKG_VERSION:=v\([0-9]\)/PKG_VERSION:=\1/' "$makefile"
        # 2. PKG_VERSION = v0.5.26 -> PKG_VERSION = 0.5.26
        sed -i 's/^PKG_VERSION\s*:=\s*v\([0-9]\)/PKG_VERSION:=\1/' "$makefile"
        # 3. 处理可能的引号
        sed -i 's/^PKG_VERSION:="v\([0-9]\)/PKG_VERSION:="\1/' "$makefile"
        # 显示修改结果
        echo "修改后的版本号："
        grep "^PKG_VERSION" "$makefile"
        # 删除备份
        rm -f "$makefile.bak"
    done
    echo "版本号修复完成"
fi
# 确保中文语言包存在
if [ -d "package/community/luci-app-dockerman" ]; then
    echo "检查 dockerman 中文语言包..."
    find package/community/luci-app-dockerman -path "*luci-i18n-dockerman-zh-cn*" -type d | head -5
fi
