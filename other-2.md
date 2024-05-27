## win10端口占用

### 1、查看端口信息

```shell
netstat -aon|findstr "端口"
```

### 2、根据PID 关闭进程

```shell
taskkill /f /t /pid xxx
```





## centos7 端口占用

### 1、检查端口被哪个进程占用

```shell
netstat -lnp|grep 8000 
```

### 2、查看进程的详细信息

```shell
ps 11100
```

### 3、杀掉进程

```shell
kill -9 11100
```





## idea连接数据库显示时区问题

选择Advanced->serverTimezone修改为UTC

![image-20211220165641733](E:/mine_notes/nginx-黑马/img/image-20211220165641733.png)





## docker修改mysql配置

```shell
docker exec -it 容器id /bin/bash
# 如果不能直接vim需要下载
apt-get update
apt-get install vim


vim /etc/mysql/mysql.conf.d/mysqld.cnf
```

```shell
# 将配置从容器中copy到宿主机
docker cp /etc/mysql/mysql.conf.d/mysqld.cnf 主机地址/mysqld.cnf

# 修改后，覆盖回去
docker cp 主机地址/mysqld.cnf mysql容器名称:/etc/mysql/mysql.conf.d/

# 修改后需要重启
```



## idea配置maven首先读取本地仓库

```shell
# Build, Execution, Edployment > Build Tools > Maven > Runner > VM Options
-DarchetypeCatalog=internal
```



## 批量删除Maven本地仓库中未下载完成的jar包（不完整的jar包）

```shell
# 进入maven本地仓库地址（CMD黑窗口）
for /r %i in (*.lastUpdated) do del %i
```



## Nacos

[nacos版本适配](https://github.com/alibaba/spring-cloud-alibaba/wiki)

[jdk11运行nacos](https://www.cnblogs.com/ronglg/p/15165156.html)

### 1.Nocas启动服务

切换到bin目录，执行命令：

```shell
sh startup.sh -m standalone
```

### 后台运行

```shell
nohup sh startup.sh -m standalone &
```

### 2.Nacos关闭服务

切换到bin目录，执行命令：

```shell
sh shutdown.sh
```

### 3.Nacos查状态

```shell
ps -ef | grep nacos
```

### 问题

自动闪退：内存不足；默认需要2G

https://blog.csdn.net/qq_38826019/article/details/109328644

