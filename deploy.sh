#!/bin/bash
# ======================================
# 一键部署脚本 for 静态网站 (Apache Ubuntu 22.04)
# 请尤其注意将 WEB_DIR 修改为你的实际目录
# 作者：Kaleid Scoper
# ======================================

# 使用 root 权限执行整个脚本
if [ "$EUID" -ne 0 ]; then
  echo "请使用 sudo 运行此脚本！"
  exit 1
fi

WEB_DIR="/var/www/mc.ahumc.top" # 修改为你的实际目录
GIT_BRANCH="main"   # 改为你的实际分支名

echo "-----------------------------------"
echo "此脚本由 Kaleid Scoper 倾情提供"
echo "开始部署网站..."
echo "工作目录: $WEB_DIR"
echo "分支: $GIT_BRANCH"
echo "-----------------------------------"

cd "$WEB_DIR" || { echo "无法进入目录 $WEB_DIR"; exit 1; }

# 确保干净状态
echo "重置本地修改..."
git reset --hard

# 拉取最新代码
echo "⬇拉取最新代码..."
git fetch --all
git checkout "$GIT_BRANCH"
git pull origin "$GIT_BRANCH"

# 设置正确的文件权限（可选）
echo "修复文件权限..."
chown -R www-data:www-data "$WEB_DIR"
chmod -R 755 "$WEB_DIR"

# 不需要重启 Apache（仅在配置变更时才需要）
echo "部署完成！无需重启 Apache。"
echo "此脚本由 Kaleid Scoper 倾情提供"
echo "-----------------------------------"
