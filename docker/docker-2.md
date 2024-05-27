## 安装Docker

### 1）、安装linux虚拟机

​	1）、VMWare、VirtualBox（安装）；

​	2）、导入虚拟机文件centos7-atguigu.ova；

​	3）、双击启动linux虚拟机;使用  root/ 123456登陆

​	4）、使用客户端连接linux服务器进行命令操作；

​	5）、设置虚拟机网络；

​		桥接网络===选好网卡====接入网线；

​	6）、设置好网络以后使用命令重启虚拟机的网络

```shell
service network restart
```

​	7）、查看linux的ip地址

```shell
ip addr
```

​	8）、使用客户端连接linux；

### 2）、在linux虚拟机上安装docker

步骤：

```shell
1、检查内核版本，必须是3.10及以上
uname -r
2、安装docker
yum install docker
3、输入y确认安装

3.1、修改存储目录
vim /lib/systemd/system/docker.service
在ExecStart参数里加入: --graph=/data/docker/lib

3.2、修改镜像源
vim /etc/docker/daemon.json
{"registry-mirrors":["https://f9dk003m.mirror.aliyuncs.com","http://registry.docker-cn.com","http://hub-mirror.c.163.com"]}
3.3、查看docker信息
docker info

4、启动docker
[root@localhost ~]# systemctl start docker
[root@localhost ~]# docker -v
Docker version 1.12.6, build 3e8e77d/1.12.6

5、开机启动docker
[root@localhost ~]# systemctl enable docker
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.

6、停止docker
systemctl stop docker
```

## 4、Docker常用命令&操作

### 1）、镜像操作

| 操作 | 命令                                            | 说明                                                     |
| ---- | ----------------------------------------------- | -------------------------------------------------------- |
| 检索 | docker  search 关键字  eg：docker  search redis | 我们经常去docker  hub上检索镜像的详细信息，如镜像的TAG。 |
| 拉取 | docker pull 镜像名:tag                          | :tag是可选的，tag表示标签，多为软件的版本，默认是latest  |
| 列表 | docker images                                   | 查看所有本地镜像                                         |
| 删除 | docker rmi image-id                             | 删除指定的本地镜像                                       |

https://hub.docker.com/

### 2）、容器操作

**[centos7开放指定端口](https://www.cnblogs.com/jay1987/articles/12833717.html)**

软件镜像（QQ安装程序）----运行镜像----产生一个容器（正在运行的软件，运行的QQ）；

步骤：

````shell
1、搜索镜像
[root@localhost ~]# docker search tomcat
2、拉取镜像
[root@localhost ~]# docker pull tomcat
3、根据镜像启动容器
docker run --name mytomcat -d tomcat:latest
4、docker ps  
查看运行中的容器
5、 停止运行中的容器
docker stop  容器的id
6、查看所有的容器
docker ps -a
7、启动容器
docker start 容器id
8、删除一个容器
 docker rm 容器id
9、启动一个做了端口映射的tomcat
[root@localhost ~]# docker run -d -p 8888:8080 tomcat
-d：后台运行
-p: 将主机的端口映射到容器的一个端口    主机端口:容器内部的端口

10、为了演示简单关闭了linux的防火墙
service firewalld status ；查看防火墙状态
service firewalld stop：关闭防火墙
11、查看容器的日志
docker logs container-name/container-id

更多命令参看
https://docs.docker.com/engine/reference/commandline/docker/
可以参考每一个镜像的文档

````

### 开放端口后，却仍然访问不了，执行以下操作

当Tomcat版本过高时，根据IP地址和端口号访问可能会出现下面问题

![image-20201126201302902](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20201126201302902.png)

出现404是因为**webapps文件夹下内容为空**，内容都在webapps.dist 目录下

1. 进入Tomcat容器

```linux
docker exec -it 容器id /bin/bash
```

​	2.ls 查看文件夹内容，可以发现下面有webapps文件夹和webapps.dist文件夹，将webapps.dist下的内容全部复制到webapps中

```linux
cp -r webapps.dist/* webapps
```



### 3）、安装MySQL示例

```shell
docker pull mysql
```



错误的启动

```shell
[root@localhost ~]# docker run --name mysql01 -d mysql
42f09819908bb72dd99ae19e792e0a5d03c48638421fa64cce5f8ba0f40f5846

mysql退出了
[root@localhost ~]# docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                           PORTS               NAMES
42f09819908b        mysql               "docker-entrypoint.sh"   34 seconds ago      Exited (1) 33 seconds ago                            mysql01
538bde63e500        tomcat              "catalina.sh run"        About an hour ago   Exited (143) About an hour ago                       compassionate_
goldstine
c4f1ac60b3fc        tomcat              "catalina.sh run"        About an hour ago   Exited (143) About an hour ago                       lonely_fermi
81ec743a5271        tomcat              "catalina.sh run"        About an hour ago   Exited (143) About an hour ago                       sick_ramanujan


//错误日志
[root@localhost ~]# docker logs 42f09819908b
error: database is uninitialized and password option is not specified 
  You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD；这个三个参数必须指定一个
```

正确的启动

```shell
[root@localhost ~]# docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=123456 -d mysql
b874c56bec49fb43024b3805ab51e9097da779f2f572c22c695305dedd684c5f
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
b874c56bec49        mysql               "docker-entrypoint.sh"   4 seconds ago       Up 3 seconds        3306/tcp            mysql01
```

**做了端口映射**

```shell
[root@localhost ~]# docker run -p 3306:3306 --name mysql02 -e MYSQL_ROOT_PASSWORD=123456 -d mysql
ad10e4bc5c6a0f61cbad43898de71d366117d120e39db651844c0e73863b9434
[root@localhost ~]# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
ad10e4bc5c6a        mysql               "docker-entrypoint.sh"   4 seconds ago       Up 2 seconds        0.0.0.0:3306->3306/tcp   mysql02

再次启动：docker restart 镜像名
```

```shell
# 进入指定docker的mysql
docker exec -it id  /bin/bash
# 在执行mysql登录命令
```



几个其他的高级操作

```
docker run --name mysql03 -v /conf/mysql:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag
把主机的/conf/mysql文件夹挂载到 mysqldocker容器的/etc/mysql/conf.d文件夹里面
改mysql的配置文件就只需要把mysql配置文件放在自定义的文件夹下（/conf/mysql）

docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
指定mysql的一些配置参数
```



```shell
命令行和sqlyog登录不了执行以下操作
解决方案（在centos7环境下）：

1.进入mysql容器

docker exec -it mysql2 /bin/bash

2.进入mysql

mysql -uroot -proot

3.修改密码

ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
```

[最后一句的理解](https://blog.csdn.net/ad996454914/article/details/80904771)



### 4)、安装redis示例

```shell
docker pull redis # 拉去最新版redis
docker images # 查看所有镜像
wget http://download.redis.io/redis-stable/redis.conf  # 下载redis配置文件

```



```shell
# 开启保护模式，限制为本地访问；设置为no
protected-mode no
# 端口号
port 6379
# 确定了TCP连接中已完成队列
tcp-backlog 511
timeout 0
tcp-keepalive 300
# 允许后台启动
daemonize yes
# redis以守护进程方式运行时，会把pid写入指定目录
pidfile /mySofts/docker/redis/log/redis_6379.pid
# 日志等级
loglevel notice
# 日志文件名
logfile "6379.log"
# 数据库数量
databases 16
# redis启动时是否显示Logo
always-show-logo no
set-proc-title yes
proc-title-template "{title} {listen-addr} {server-mode}"
# RDB持久化策略（每300秒有100次操作就进行持久化）
save 300 100
# bgsave错误时停止写入
stop-writes-on-bgsave-error yes
# 开启rdb压缩
rdbcompression yes
# 保存rdb文件时, 是否校验
rdbchecksum yes
# 指定数据库持久化文件名
dbfilename dump-6379.rdb
# rdb文件是否删除同步锁
rdb-del-sync-files no
# drb文件保存目录
dir /mySofts/docker/redis/data/
replica-serve-stale-data yes
replica-read-only yes
repl-diskless-sync no
repl-diskless-sync-delay 5
repl-diskless-load disabled
repl-disable-tcp-nodelay no
replica-priority 100
acllog-max-len 128
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no
lazyfree-lazy-user-del no
lazyfree-lazy-user-flush no
oom-score-adj no
oom-score-adj-values 0 200 800
disable-thp yes
appendonly yes
appendfilename "appendonly-6379.aof"
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
aof-load-truncated yes
aof-use-rdb-preamble yes
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
latency-monitor-threshold 0
notify-keyspace-events ""
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-size -2
list-compress-depth 0
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
hll-sparse-max-bytes 3000
stream-node-max-bytes 4096
stream-node-max-entries 100
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
dynamic-hz yes
aof-rewrite-incremental-fsync yes
rdb-save-incremental-fsync yes
jemalloc-bg-thread yes

```



```shell
docker run -p 6380:6379 --name redis01 -v /etc/redis/redis.conf:/mySofts/docker/redis/redis-6379.conf -v /data:/mySofts/docker/redis/data -d redis redis-server /mySofts/docker/redis/redis-6379.conf --appendonly yes  --requirepass redis63791
```

> - -p 6380:6379 端口映射：前表示主机部分，：后表示容器部分。
> - --name myredis 指定该容器名称，查看和进行操作都比较方便。
> - -v 挂载目录，规则与端口映射相同。
> - -d redis 表示后台启动redis
> - redis-server /etc/redis/redis.conf 以配置文件启动redis，加载容器内的conf文件，最终找到的是挂载的目录/usr/local/docker/redis.conf
> - appendonly yes 开启redis 持久化



```shell
# 进入容器
docker exec -it redis01 /bin/bash

# 查看docker日志，指定日期和显示条数
docker logs -f -t --since="2021-12-16" --tail=100 日容器id
```



