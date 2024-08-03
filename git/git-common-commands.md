当然，以下是一些常用的Git命令及其含义：

1. **初始化和配置**
   - `git init`: 初始化一个新的Git仓库。
   - `git clone <repo-url>`: 克隆一个远程仓库到本地。
   - `git config --global user.name "Your Name"`: 配置全局用户名。
   - `git config --global user.email "youremail@example.com"`: 配置全局用户邮箱。

2. **状态和日志**
   - `git status`: 显示工作目录的状态，包括未暂存的更改和未跟踪的文件。
   - `git log`: 显示提交日志。
   - `git log --oneline`: 以单行简洁格式显示提交日志。

3. **添加和提交**
   - `git add <file>`: 将文件添加到暂存区。
   - `git add .`: 将所有更改的文件添加到暂存区。
   - `git commit -m "commit message"`: 提交暂存区的更改并附上提交信息。
   - `git commit -a -m "commit message"`: 跳过`git add`步骤，直接提交已跟踪文件的所有更改。

4. **分支操作**
   - `git branch`: 列出所有本地分支，当前分支前有星号标记。
   - `git branch <branch-name>`: 创建一个新分支。
   - `git checkout <branch-name>`: 切换到指定分支。
   - `git checkout -b <branch-name>`: 创建并切换到新分支。
   - `git merge <branch-name>`: 合并指定分支到当前分支。
   - `git branch -d <branch-name>`: 删除指定的本地分支。

5. **远程操作**
   - `git remote -v`: 查看已配置的远程仓库及其URL。
   - `git remote add <name> <url>`: 添加一个新的远程仓库。
   - `git fetch <remote>`: 从远程仓库获取数据，但不合并。
   - `git pull <remote> <branch>`: 从远程仓库获取并合并分支。
   - `git push <remote> <branch>`: 将本地分支推送到远程仓库。

6. **暂存和恢复**
   - `git stash`: 将当前工作目录的更改暂存，恢复到干净状态。
   - `git stash list`: 查看所有暂存的更改。
   - `git stash apply`: 应用最近一次暂存的更改。
   - `git stash pop`: 应用并删除最近一次暂存的更改。

7. **查看和比较**
   - `git diff`: 查看工作目录中的更改。
   - `git diff --staged`: 查看已暂存的更改。
   - `git show <commit>`: 显示指定提交的详细信息。

8. **其他**
   - `git tag <tag-name>`: 为当前提交打标签。
   - `git reset --hard <commit>`: 重置当前分支到指定提交，并且丢弃所有未提交的更改。
   - `git revert <commit>`: 创建一个新的提交，撤销指定提交的更改。

这些命令覆盖了Git的基础操作和一些高级功能，可以帮助你管理和操作Git仓库。









---



**git 提交流程**

```sh
第一步：git add -A
第二步：git commit -m "合并文件"
第三步：git pull --rebase origin feature/2.1.0-customer
第四步：git push origin feature/2.1.0-customer
```







**更新远程分支**

```sh
git fetch 
```

 

**git 冲突使用命令**

```sh
git checkout . #本地所有修改的。没有的提交的，都返回到原来的状态
git stash #把所有没有提交的修改暂存到stash里面。可用git stash pop回复。
git reset --hard HASH #返回到某个节点，不保留修改。
git reset --soft HASH #返回到某个节点。保留修改
```



```sh
git clone www.xxx.xxx  从服务器拉取代码
```

```sh
git pull origin xxx/xxx 从服务器更新代码
```

```sh
git status 查看本分支是否还有没提交的代码
```





**git 解决冲突**



```sh
git rebase --continue | --skip | --abort still do not work: Git ReBase-继续-跳过-中止仍然不工作：
```





**手动合并上线** 

 

```sh
git status --查看当前分支是否有提交的文件，如果有先提交或者回退
git checkout develop -- 切换到要合并的分支
git merge --no-ff feature/header -- 合并分支
```

```sh
如果出现冲突，需要先解决冲突，然后git add 提交
再git rebase --continue 继续操作
```

```sh
git push origin develop 把修改推送的合并的分支管
```

 

```sh
1. 查看远程分支 $ git branch -a
2. 查看本地分支 $ git branch
3. 切换分支   $ git checkout -b v0.9rc1 origin/v0.9rc1
```





```sh
删除本地分支
git branch -d <BranchName>
删除远程分支
git push origin --delete <BranchName>
```

 

**git创建分支并提到远程**

1. 切换到被copy的分支（master），从服务器拉取最新版本

  ```sh
  git checkout master
  git pull
  ```

  

 

2. **从当前分支copy出新的开发分支 命名dev分支**

  ```sh
  git checkout -b dev
  ```

  

 

显示 Switched to a new branch 'dev' 成功

 

3. **把新建的分支push到远端**

  ```sh
  git push origin dev
  ```

  

 

4. **拉取远端分支**

  ```
  git pull
  ```

 

```sh
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.
git pull <remote> <branch>
If you wish to set tracking information for this branch you can do so with:
git branch --set-upstream-to=origin/<branch> dev
```

 

**pull时发现，当前的分支并没有和本地分支关联，根据提示进行下一步：**

```sh
5. 关联
git branch --set-upstream-to=origin/dev
```

```sh
6. 再次拉取 验证
git pull
```

