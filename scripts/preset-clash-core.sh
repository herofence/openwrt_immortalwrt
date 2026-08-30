#!/bin/bash
# OpenClash 核心文件下载脚本 - 精简版 (只下载 Meta 核心)
# 用法: ./preset-clash-core.sh [架构]
# 架构参数: amd64, arm64, armv7 等

set -e

ARCH="${1:-amd64}"
echo "目标架构: $ARCH"

mkdir -p files/etc/openclash/core

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 下载 GeoIP 数据
print_info "下载 GeoIP 数据..."
wget -q --timeout=30 --tries=3 \
    "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" \
    -O files/etc/openclash/GeoIP.dat || print_warn "GeoIP.dat 下载失败"
wget -q --timeout=30 --tries=3 \
    "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" \
    -O files/etc/openclash/GeoSite.dat || print_warn "GeoSite.dat 下载失败"

# 只下载 Meta 核心 (这是最稳定且功能最全的版本)
META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-${ARCH}.tar.gz"
print_info "下载 Meta 核心: $META_URL"

if wget -q --timeout=30 --tries=3 "$META_URL" -O /tmp/clash_meta.tar.gz; then
    # 解压后重命名为 clash (OpenClash 默认查找 clash)
    tar -xzf /tmp/clash_meta.tar.gz -O 2>/dev/null > files/etc/openclash/core/clash
    chmod +x files/etc/openclash/core/clash
    print_info "Meta 核心下载成功"
    rm -f /tmp/clash_meta.tar.gz
else
    print_error "Meta 核心下载失败"
    exit 1
fi

# 显示最终文件列表
print_info "OpenClash 核心文件:"
ls -lh files/etc/openclash/core/

print_info "脚本执行完成"
