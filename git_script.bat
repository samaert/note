@echo off

:: 检查当前目录是否是一个Git仓库
if not exist ".git" (
    echo 当前目录不是一个Git仓库。正在初始化新的Git仓库...
    git init
    
    :: 提示用户输入远程仓库URL
    set /p remote_url=请输入远程仓库的URL：
    git remote add origin "%remote_url%"
) else (
    :: 显示当前的远程仓库URL
    echo 当前配置的远程仓库URL是：
    git remote -v

    :: 显示当前分支
    echo 当前所在的分支是：
    git branch
)

:: 拉取最新的远程仓库代码
git pull origin main --allow-unrelated-histories

:: 添加所有更改到暂存区
git add .\*

:: 提示用户输入提交信息
set /p commit_message=请输入提交描述：

:: 提交更改，使用用户输入的提交信息
git commit -m "%commit_message%"

:: 推送更改到远程仓库
git push origin main

echo 代码已成功初始化（如果需要）、拉取、提交并推送到远程仓库
pause
