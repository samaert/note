#!/bin/bash

# 检查当前分支
branch=$(git symbolic-ref --short -q HEAD)

# 拉取最新的远程更改
echo "正在拉取远程仓库的最新更改..."
git pull origin "$branch"

# 检查是否有冲突
if [ $? -ne 0 ]; then
  echo "拉取时发生冲突，请解决冲突后再提交更改。"
  exit 1
fi

# 添加所有更改到暂存区
git add .

# 提示用户输入提交信息
echo "请输入提交描述："
read commit_message

# 提交更改，使用用户输入的提交信息
git commit -m "$commit_message"

# 推送更改到远程仓库
git push origin "$branch"

echo "代码已成功拉取、提交并推送到远程仓库"
