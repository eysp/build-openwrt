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
git clone  https://github.com/gdy666/luci-app-lucky.git package/lucky
git clone https://github.com/kenzok8/small package/small
svn co https://github.com/Hyy2001X/AutoBuild-Packages/trunk/luci-app-npc package/luci-app-npc
git clone https://github.com/ghosthgytop/npc package/npc
sed -i 's/0.26.8/0.26.10/g' package/npc/Makefile

git clone --depth=1 -b main https://github.com/kingyond/luci-app-accesscontrol-plus accesscontrol-plus
mv accesscontrol-plus/luci-app-accesscontrol-plus  package/luci-app-accesscontrol-plus && rm -rf accesscontrol-plus

git clone --depth=1 -b master https://github.com/rufengsuixing/luci-app-zerotier package/luci-app-zerotier

# 换源
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-23.05/package/emortal package/emortal
sed -i 's,mirrors.vsean.net/openwrt,mirrors.pku.edu.cn/immortalwrt,g' package/emortal/default-settings/files/99-default-settings-chinese

# update golang
# pushd feeds/packages/lang
# rm -rf golang && svn co https://github.com/openwrt/packages/trunk/lang/golang
# popd
