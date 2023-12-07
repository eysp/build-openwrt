#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.123.2/g' package/base-files/files/bin/config_generate
 
# add custom packages
# echo 'src-git xYx https://github.com/xYx-c/openwrt-luci' >>feeds.conf.default

# openclash packages
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git openclash
mv openclash/luci-app-openclash package/luci-app-openclash && rm -rf openclash

git clone --depth=1 -b master https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 -b main https://github.com/gdy666/luci-app-lucky.git package/luci-app-lucky
git clone --depth=1 -b master https://github.com/kenzok8/small package/small
git clone --depth=1 -b master https://github.com/Hyy2001X/AutoBuild-Packages package/AutoBuild-Packages
git clone https://github.com/ghosthgytop/npc package/npc
sed -i 's/0.26.8/0.26.10/g' package/npc/Makefile

git clone --depth=1 -b main https://github.com/kingyond/luci-app-accesscontrol-plus accesscontrol-plus
mv accesscontrol-plus/luci-app-accesscontrol-plus  package/luci-app-accesscontrol-plus && rm -rf accesscontrol-plus

git clone --depth=1 -b master https://github.com/rufengsuixing/luci-app-zerotier package/luci-app-zerotier

# 换源
#git clone --depth=1 -b main https://github.com/eysp/emortal package/emortal
sed -i 's,mirrors.vsean.net/openwrt,mirrors.pku.edu.cn/immortalwrt,g' package/emortal/default-settings/files/99-default-settings-chinese

# update golang
# pushd feeds/packages/lang
# rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
# popd

# 预置openclash内核
mkdir -p files/etc/openclash/core
# dev内核
CLASH_DEV_URL="https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux-amd64.tar.gz"
# premium内核
CLASH_TUN_URL="https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux-amd64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
CLASH_META_URL="https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux-amd64.tar.gz"

wget -qO- $CLASH_DEV_URL | gunzip -c > files/etc/openclash/core/clash
wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | gunzip -c > files/etc/openclash/core/clash_meta
# 给内核权限
chmod +x files/etc/openclash/core/clash*

# meta 要GeoIP.dat 和 GeoSite.dat
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat

# Country.mmdb
COUNTRY_LITE_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb
# COUNTRY_FULL_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
wget -qO- $COUNTRY_LITE_URL > files/etc/openclash/Country.mmdb
# wget -qO- $COUNTRY_FULL_URL > files/etc/openclash/Country.mmdb
