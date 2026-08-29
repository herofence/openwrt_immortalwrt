#!/bin/bash

# 定义目标主题目录（注意路径需与克隆位置一致）
ARGON_THEME_DIR="package/community/luci-theme-argon"
TARGET_BG="$ARGON_THEME_DIR/htdocs/luci-static/argon/background/background.jpg"

# 本地背景图片源
LOCAL_BG="$GITHUB_WORKSPACE/background.jpg"

# 确保目标目录存在
mkdir -p "$(dirname "$TARGET_BG")"

# 检查本地图片是否存在
if [ -f "$LOCAL_BG" ]; then
    echo "正在复制本地背景图片: $LOCAL_BG"
    cp -f "$LOCAL_BG" "$TARGET_BG"
    echo "背景图片复制成功: $TARGET_BG"
else
    echo "警告: 本地背景图片不存在 ($LOCAL_BG)，将使用主题默认背景"
    # 不退出，允许编译继续
fi
