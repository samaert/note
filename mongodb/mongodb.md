> \#数据库路径
> dbpath=/mongodb/single/data/db
> \#日志输出文件路径
> logpath=/mongodb/single/log/mongod.log
> \#错误日志采用追加模式
> logappend=true
> \#启用日志文件，默认启用
> journal=true
> \#这个选项可以过滤掉一些无用的日志信息，若需要调试使用请设置为false
> quiet=true
> \#端口号 默认为27017
> port=27017
> \#允许远程访问（你的服务器局域网ip）
> bind_ip=xxxxxx
> \#开启子进程
> fork=true
> \#开启认证，必选先添加用户，先不开启（不用验证账号密码）
> \#auth=true



# 业务应用场景

传统的关系型数据库（如MySQL），在数据操作的“三高”需求以及应对Web2.0的网站需求面前，显得力不从心。

解释：“三高”需求：

- High performance - 对数据库高并发读写的需求。
- Huge Storage - 对海量数据的高效率存储和访问的需求。
- High Scalability && High Availability- 对数据库的高可扩展性和高可用性的需求。

**而MongoDB可应对“三高”需求**。



具体的应用场景如：

1. 社交场景，使用 MongoDB 存储存储用户信息，以及用户发表的朋友圈信息，通过地理位置索引实现附近的人、地点等功能。
2. 游戏场景，使用 MongoDB 存储游戏用户信息，用户的装备、积分等直接以内嵌文档的形式存储，方便查询、高效率存储和访问。
3. 物流场景，使用 MongoDB 存储订单信息，订单状态在运送过程中会不断更新，以 MongoDB 内嵌数组的形式来存储，一次查询就能将订单所有的变更读取出来。
4. 物联网场景，使用 MongoDB 存储所有接入的智能设备信息，以及设备汇报的日志信息，并对这些信息进行多维度的分析。
5. 视频直播，使用 MongoDB 存储用户信息、点赞互动信息等。



这些应用场景中，数据操作方面的共同特点是：

> 1. 数据量大
> 2. 写入操作频繁（读写都很频繁）
> 3. 价值较低的数据，对事务性要求不高

对于这样的数据，我们更适合使用MongoDB来实现数据的存储。



## **什么时候选择MongoDB**

在架构选型上，除了上述的三个特点外，如果你还犹豫是否要选择它？可以考虑以下的一些问题：

应用不需要事务及复杂 join 支持

新应用，需求会变，数据模型无法确定，想快速迭代开发

应用需要2000-3000以上的读写QPS（更高也可以）

应用需要TB甚至 PB 级别数据存储

应用发展迅速，需要能快速水平扩展

应用要求存储的数据不丢失

应用需要99.999%高可用

应用需要大量的地理位置查询、文本查询

如果上述有1个符合，可以考虑 MongoDB，2个及以上的符合，选择 MongoDB 绝不会后悔。



思考：如果用MySQL呢？

答：相对MySQL，可以以更低的成本解决问题（包括学习、开发、运维等成本）



# 简介MongoDB简介

MongoDB是一个`开源、高性能、无模式的文档型数据库`，当初的设计就是用于简化开发和方便扩展，是NoSQL数据库产品中的一种。是最像关系型数据库（MySQL）的非关系型数据库。

它支持的数据结构非常松散，是一种`类似于 JSON 的 格式叫BSON`，所以它`既可以存储比较复杂的数据类型`，又`相当的灵活`。

MongoDB中的`记录是一个文档`，它是一个`由字段和值对（field:value）组成`的数据结构。MongoDB文档类似于JSON对象，即一个文档认为就是一个对象。字段的数据类型是字符型，它的值除了使用基本的一些类型外，还可以包括其他文档、普通数组和文档数组。

# 体系架构

MySQL和MongoDB对比:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.64qge2j1t4o0.webp)

| SQL术语/概念 | MondoDB术语/概念 | 解释/说明                           |
| ------------ | ---------------- | ----------------------------------- |
| database     | database         | 数据库                              |
| table        | collection       | 数据库表/集合                       |
| row          | document         | 数据记录行/文档                     |
| column       | field            | 数据字段/域                         |
| index        | index            | 索引                                |
| table joins  |                  | 表连接,MongoDB不支持                |
|              | 嵌入文档         | MongoDB通过嵌入式文档来替代多表连接 |
| primary key  | primary key      | 主键,MongoDB自动将_id字段设置为主键 |



# 数据模型

MongoDB的`最小存储单位就是文档(document)对象`。`文档(document)对象`对应于关系型数据库的`行`。数据在MongoDB中以`BSON（Binary-JSON）`文档的格式存储在磁盘上。

BSON（Binary Serialized Document Format）是一种类json的一种二进制形式的存储格式，简称Binary JSON。BSON和JSON一样，支持内嵌的文档对象和数组对象，但是BSON有JSON没有的一些数据类型，如Date和BinData类型。

BSON采用了类似于 C 语言结构体的名称、对表示方法，支持内嵌的文档对象和数组对象，具有轻量性、可遍历性、高效性的三个特点，可以有效描述非结构化数据和结构化数据。这种格式的优点是灵活性高，但它的缺点是空间利用率不是很理想。

Bson中，除了基本的JSON类型：string,integer,boolean,double,null,array和object，mongo还使用了特殊的数据类型。这些类型包括date,object id,binary data,regular expression 和code。每一个驱动都以特定语言的方式实现了这些类型，查看你的驱动的文档来获取详细信息。



BSON数据类型参考列表:

| 数据类型      | 描述                                                         | 举例                                                 |
| ------------- | ------------------------------------------------------------ | ---------------------------------------------------- |
| 字符串        | UTF-8字符串都可表示为字符串类型的数据                        | {"x" : "foobar"}                                     |
| 对象id        | 对象id是文档的12字节的唯一 ID                                | {"X" :ObjectId() }                                   |
| 布尔值        | 真或者假：true或者false                                      | {"x":true}+                                          |
| 数组          | 值的集合或者列表可以表示成数组                               | {"x" ： ["a", "b", "c"]}                             |
| 32位整数      | 类型不可用。JavaScript仅支持64位浮点数，所以32位整数会被自动转换。 | shell是不支持该类型的，shell中默认会转换成64位浮点数 |
| 64位整数      | 不支持这个类型。shell会使用一个特殊的内嵌文档来显示64位整数  | shell是不支持该类型的，shell中默认会转换成64位浮点数 |
| 64位浮点数    | shell中的数字就是这一种类型                                  | {"x"：3.14159，"y"：3}                               |
| null          | 表示空值或者未定义的对象                                     | {"x":null}                                           |
| undefined     | 文档中也可以使用未定义类型                                   | {"x":undefined}                                      |
| 符号          | shell不支持，shell会将数据库中的符号类型的数据自动转换成字符串 |                                                      |
| 正则表达式    | 文档中可以包含正则表达式，采用JavaScript的正则表达式语法     | {"x" ： /foobar/i}                                   |
| 代码          | 文档中还可以包含JavaScript代码                               | {"x" ： function() { /* …… */ }}                     |
| 二进制数据    | 二进制数据可以由任意字节的串组成，不过shell中无法使用        |                                                      |
| 最大值/最小值 | BSON包括一个特殊类型，表示可能的最大值。shell中没有这个类型。 |                                                      |

提示：

shell默认使用64位浮点型数值。{“x”：3.14}或{“x”：3}。对于整型值，可以使用NumberInt（4字节符号整数）或NumberLong（8字节符 号整数），{“x”:NumberInt(“3”)}{“x”:NumberLong(“3”)}



# MongoDB特点

MongoDB主要有如下特点：

## 高性能

MongoDB提供高性能的数据持久性。特别是,对嵌入式数据模型的支持减少了数据库系统上的I/O活动。

索引支持更快的查询，并且可以包含来自嵌入式文档和数组的键。（文本索引解决搜索的需求、TTL索引解决历史数据自动过期的需求、地理位置索引可用于构建各种 O2O 应用）

mmapv1、wiredtiger、mongorocks（rocksdb）、in-memory 等多引擎支持满足各种场景需求。

Gridfs解决文件存储的需求。

## 高可用性

MongoDB的复制工具称为副本集（replica set），它可提供自动故障转移和数据冗余。

## 高可扩展性

MongoDB提供了水平可扩展性作为其核心功能的一部分。

分片将数据分布在一组集群的机器上。（海量数据存储，服务能力水平扩展）

从3.4开始，MongoDB支持基于片键创建数据区域。在一个平衡的集群中，MongoDB将一个区域所覆盖的读写只定向到该区域内的那些片。

## 丰富的查询支持

MongoDB支持丰富的查询语言，支持读和写操作(CRUD)，比如数据聚合、文本搜索和地理空间查询等。



**其他特点：如无模式（动态模式）、灵活的文档模型**



# Windows系统中的安装启动

## 第一步:下载安装包

MongoDB 提供了可用于 32 位和 64 位系统的预编译二进制包，你可以从MongoDB官网下载安装，MongoDB 预编译二进制包下载地址：

[Download MongoDB(opens new window)](https://www.mongodb.com/try/download/community)

MongoDB所有历史版本下载：http://dl.mongodb.org/dl/linux

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.4t8j23vtx1q0.webp)

根据上图所示下载 zip 包。

提示：版本的选择：

MongoDB的版本命名规范如：x.y.z；

y为奇数时表示当前版本为开发版，如：1.5.2、4.1.13；

y为偶数时表示当前版本为稳定版，如：1.6.3、4.0.10；

z是修正版本号，数字越大越好。

详情：http://docs.mongodb.org/manual/release-notes/#release-version-numbers

## 第二步：解压安装启动

将压缩包解压到一个目录中。

在解压目录中，手动建立一个目录用于存放数据文件，如 data/db

### 方式1：命令行参数方式启动服务

在 bin 目录中打开命令行提示符，输入如下命令：



```sh
mongod --dbpath=..\data\db
```



我们在启动信息中可以看到，mongoDB的默认端口是27017，如果我们想改变默认的启动端口，可以通过--port来指定端口。为了方便我们每次启动，可以将安装目录的bin目录设置到环境变量的path中， bin 目录下是一些常用命令，比如 mongod 启动服务用的，mongo 客户端连接服务用的。

### 方式2：配置文件方式启动服务

在解压目录中新建 config 文件夹，该文件夹中新建配置文件 mongod.conf ，内如参考如下：



```yaml
storage:
	#The directory where the mongod instance stores its data.Default Value is "\data\db" on Windows.
	dbPath: D:\DevelopTools\mongoDB\data
```



详细配置项内容可以参考官方文档：https://docs.mongodb.com/manual/reference/configuration-options/

注意

1. 配置文件中如果使用双引号，比如路径地址，自动会将双引号的内容转义。如果不转义，则会报错：



```shell
error-parsing-yaml-config-file-yaml-cpp-error-at-line-3-column-15-unknown-escape-character-d
```



解决：

a. 对`\`换成`/`或`\\`

b.如果路径中没有空格，则无需加引号。

​	配置文件中不能以Tab分割字段

解决：

将其转换成空格。

启动方式：



```sh
mongod -f ../config/mongod.conf
或
mongod --config ../config/mongod.conf
```



更多参数配置:



```yaml
systemLog:
	destination: file
	#The path of the log file to which mongod or mongos should send all diagnostic logging information
	path: "D:/02_Server/DBServer/mongodb-win32-x86_64-2008plus-ssl-4.0.1/log/mongod.log"
	logAppend: true
storage:
	journal:
		enabled: true
	#The directory where the mongod instance stores its data.Default Value is "/data/db".
	dbPath: "D:/02_Server/DBServer/mongodb-win32-x86_64-2008plus-ssl-4.0.1/data"
net:
#bindIp: 127.0.0.1
	port: 27017
setParameter:
	enableLocalhostAuthBypass: false
```

# Shell连接(mongo命令)

在命令提示符输入以下shell命令即可完成登陆



```sh
mongo
或
mongo --host=127.0.0.1 --port=27017
```

查看已经有的数据库

```sh
>show dbs
```

退出mongodb

```sh
exit
```

更多参数可以通过帮助查看：

```sh
mongo --help
```

```sh
# 清屏命令
cls
```

提示：

MongoDB javascript shell是一个基于javascript的解释器，故是支持js程序的。

## 关闭mongodb服务

```sh
# use 数据库
db.shutdownServer();

# 或mongod 命令关闭		数据库所在目录(使用的是localhost登录)
mongod  --shutdown  --dbpath /database/mongodb/data/
```



# Compass-图形化界面客户端

到MongoDB官网下载MongoDB Compass，地址

- [Download Compass(opens new window)](https://www.mongodb.com/try/download/compass)

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.6shws3jfdo40.webp)

在打开的界面中，输入主机地址，端口等相关信息，点击连接:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.tqf2dcd2x40.webp)



# Linux系统中的安装启动和连接

目标：在Linux中部署一个单机的MongoDB，作为生产环境下使用。

提示：和Windows下操作差不多。

步骤如下：

1. 先到官网下载压缩包 `mongod-linux-x86_64-4.0.10.tgz` 。
2. 上传压缩包到Linux中，解压到当前目录：

```sh
tar -xvf mongodb-linux-x86_64-4.0.10.tgz
```

3.移动解压后的文件夹到指定的目录中：

```sh
mv mongodb-linux-x86_64-4.0.10 /usr/local/mongodb
```

4.新建几个目录，分别用来存储数据和日志：

```sh
#数据存储目录
mkdir -p /mongodb/single/data/db
#日志存储目录
mkdir -p /mongodb/single/log
```

5.新建并修改配置文件

```sh
vim /mongodb/single/mongod.conf
```

配置文件的内容如下：

```yaml
systemLog:
  #MongoDB发送所有日志输出的目标指定为文件
  # #The path of the log file to which mongod or mongos should send all diagnostic   logging information 
  destination: file
  #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径（日志输出文件路径）
  path: "/mongodb/single/log/mongod.log"
  #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。（错误日志采用追加模式）
  logAppend: true
storage:
  #mongod实例存储其数据的目录。storage.dbPath设置仅适用于mongod。（数据库存放位置）
  ##The directory where the mongod instance stores its data.Default Value is "/data/db".
  dbPath: "/mongodb/single/data/db"
  journal:
    #启用或禁用持久性日志以确保数据文件保持有效和可恢复。（启用日志文件，默认启用）
    enabled: true
processManagement:
  #启用在后台运行mongos或mongod进程的守护进程模式。
  fork: true
net:
  #服务实例绑定的IP，默认是localhost，115.60.97.40服务器内网地址（允许远程访问）
  bindIp: localhost,115.60.97.40
  #bindIp
  #绑定的端口，默认是27017
  port: 27017
```

6.启动MongoDB服务

```sh
[root@master single]# /usr/local/mongodb/bin/mongod --config mongod.conf
about to fork child process, waiting until server is ready for connections.
forked process: 2923
child process started successfully, parent exiting
```

注意：

如果启动后不是 successfully ，则是启动失败了。原因基本上就是配置文件有问题。

通过进程来查看服务是否启动了：



```sh
[root@master single]# ps -ef | grep mongod
root       2923      1  0 17:32 ?        00:00:00 /usr/local/mongodb/bin/mongod --config mongod.conf
root       2956   1650  0 17:33 pts/0    00:00:00 grep --color=auto mongod
```

7.分别使用mongo命令和compass工具来连接测试。

提示：配置mongo命令到环境变量，修改 /etc/profile 文件，在文件末尾加上如下代码

```sh
vim  /etc/profile 
export PATH=$PATH:/usr/local/mongodb/bin
```

然后执行命令 `source /etc/profile`

```sh
[root@master bin]# mongo
MongoDB shell version v4.0.10
connecting to: mongodb://127.0.0.1:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b69fa065-b5c2-4bc2-a282-5c34edd4740a") }
MongoDB server version: 4.0.10
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
        http://docs.mongodb.org/
Questions? Try the support group
        http://groups.google.com/group/mongodb-user
Server has startup warnings:
```

提示：如果远程连接不上，需要配置防火墙放行，或直接关闭linux防火墙

```sh
#查看防火墙状态
systemctl status firewalld
#临时关闭防火墙
systemctl stop firewalld
#开机禁止启动防火墙
systemctl disable firewalld
```

- compass工具

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.2ilca06qo3w0.webp)

- 连接，并查看数据库

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220624/image.7jl3j3fi8b40.webp)

8.停止关闭服务

停止服务的方式有两种：快速关闭和标准关闭，下面依次说明：

- 快速关闭方法（快速，简单，数据可能会出错）

目标：通过系统的kill命令直接杀死进程：

杀完要检查一下，避免有的没有杀掉。

```sh
#通过进程编号关闭节点
kill -2 54410
```

如果一旦是因为数据损坏，则需要进行如下操作（了解）：

删除lock文件：

```sh
rm -f /mongodb/single/data/db/*.lock
```

修复数据：

```sh
/usr/local/mongdb/bin/mongod --repair --dbpath=/mongodb/single/data/db
```

- 标准的关闭方法（数据不容易出错，但麻烦）：

目标：通过mongo客户端中的shutdownServer命令来关闭服务

主要的操作步骤参考如下：

```sh
#客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27017
#切换到admin库
use admin
#关闭服务
db.shutdownServer()
```



# 基本常用命令

## 案例需求

存放文章评论的数据存放到MongoDB中，数据结构参考如下：

数据库：articledb

| 专栏文章评论   | comment        |                  |                           |
| -------------- | -------------- | ---------------- | ------------------------- |
| 字段名称       | 字段含义       | 字段类型         | 备注                      |
| _id            | ID             | ObjectId或String | Mongo的主键字段           |
| articleid      | 文章ID         | String           |                           |
| content        | 评论内容       | String           |                           |
| userid         | 评论人ID       | String           |                           |
| nickname       | 评论人昵称     | String           |                           |
| createdatetime | 评论的日期时间 | Data             |                           |
| likenum        | 点赞数         | Int32            |                           |
| replynum       | 回复数         | Int32            |                           |
| state          | 状态           | String           | 0：不可见；1：可见；      |
| parentid       | 上级ID         | String           | 如果为0表示文章的顶级评论 |



## 数据库操作

### 选择和创建数据库

选择和创建数据库的语法格式：

```sh
use 数据库名称
```

如果数据库不存在则自动创建，例如，以下语句创建articledb 数据库：

```sh
use articledb
```

查看有权限查看的所有的数据库命令

```sh
show dbs
或
show databases
```



**注意**: 在 MongoDB 中，集合只有在内容插入后才会创建! 就是说，创建集合(数据表)后要再插入一个文档(记录)，集合才会真正创建。

查看当前正在使用的数据库命令

```sh
db
```

MongoDB 中默认的数据库为 test，如果你没有选择数据库，集合将存放在 test 数据库中。



> 另外：
>
> 数据库名可以是满足以下条件的任意UTF-8字符串。
>
> - 不能是空字符串（"")。
> - 不得含有' '（空格)、.、$、/、\和\0 (空字符)。
> - 应全部小写。
> - 最多64字节。
>
> 有一些数据库名是保留的，可以直接访问这些有特殊作用的数据库。
>
> - **admin**： 从权限的角度来看，这是"root"数据库。要是将一个用户添加到这个数据库，这个用户自动继承所有数据库的权限。一些特定的服务器端命令也只能从这个数据库运行，比如列出所有的数据库或者关闭服务器。
> - **local**: 这个数据永远不会被复制，可以用来存储限于本地单台服务器的任意集合
> - **config**: 当Mongo用于分片设置时，config数据库在内部使用，用于保存分片的相关信息。
>

### 数据库的删除

MongoDB 删除数据库的语法格式如下：

删除一个现有的数据库（use用的数据库）

```sh
db.dropDatabase()
```

提示：主要用来删除已经持久化的数据库

## 集合操作

集合，类似关系型数据库中的表。

可以显示的创建，也可以隐式的创建。

### 集合的显式创建（了解）

基本语法格式：

```sh
db.createCollection(name)
```

参数说明:

- name: 要创建的集合名称



例如：创建一个名为 mycollection 的普通集合。

```sh
db.createCollection("mycollection")
```

查看当前库中的表：show tables命令

```sh
show collections
或
show tables
```



集合的命名规范：

- 集合名不能是空字符串""。
- 集合名不能含有\0字符（空字符)，这个字符表示集合名的结尾。
- 集合名不能以"system."开头，这是为系统集合保留的前缀。
- 用户创建的集合名字不能含有保留字符。有些驱动程序的确支持在集合名里面包含，这是因为某些系统生成的集合中包含该字符。除非你要访问这种系统创建的集合，否则千万不要在名字里出现$。



### 集合的隐式创建

当向一个集合中插入一个文档的时候，如果集合不存在，则会自动创建集合。

详见 [文档的插入](https://frxcat.fun/database/MongoDB/MongoDB_command#文档的插入) 章节。

提示：通常我们使用隐式创建文档即可。



### 集合的删除

集合删除语法格式如下：

```sh
db.collection.drop()
或
db.集合.drop()
```

**返回值**

如果成功删除选定集合，则 drop() 方法返回 true，否则返回 false。

例如：要删除mycollection集合名称

```sh
db.mycollection.drop()
```

## 文档基本CRUD

文档（document）的数据结构和 JSON 基本一样。

所有存储在集合中的数据都是 BSON 格式。

### 文档的插入

#### 单个文档插入

使用`insert() 或 save()`方法向集合中插入文档，语法如下：

```sh
db.collection(集合名称).insert(
	<document or array of documents>,
	{
		writeConcern: <document>,
		ordered: <boolean>
	}
)
```

参数：

| Parameter                  | Parameter         | Description                                                  |
| -------------------------- | ----------------- | ------------------------------------------------------------ |
| `document`                 | document or array | 要插入到集合中的文档或文档数组。（json格式）                 |
| `writeConcern(性能的级别)` | document          | Optional. A document expressing the [write concern]([Write Concern — MongoDB Manual (opens new window)](https://www.mongodb.com/docs/manual/reference/write-concern/)). Omit to use the default [write concern]([db.collection.insert() — MongoDB Manual (opens new window)](https://www.mongodb.com/docs/manual/reference/method/db.collection.insert/#insert-wc)).See Write Concern.Do not explicitly set the write concern for the operation if run in a transaction. To use write concern with transactions, see [Transactions and Write Concern]([Transactions — MongoDB Manual (opens new window)](https://www.mongodb.com/docs/manual/core/transactions/#transactions-write-concern)). |
| `ordered`                  | boolean           | 可选。如果为真，则按顺序插入数组中的文档，如果其中一个文档出现错误，MongoDB将返回而不处理数组中的其余文档。如果为假，则执行无序插入，如果其中一个文档出现错误，则继续处理数组中的主文档。在版本2.6+中默认为true |

【示例】

要向comment的集合(表)中插入一条测试数据：

```sh
db.comment.insert({"articleid":"100000","content":"今天天气真好，阳光明媚","userid":"1001","nickname":"Rose","createdatetime":new Date(),"likenum":NumberInt(10),"state":null})
```

提示：

1. comment集合如果不存在，则会隐式创建
2. mongo中的数字，默认情况下是double类型，如果要存整型，必须使用函数NumberInt(整型数字)，否则取出来就有问题了。
3. 插入当前日期使用 new Date()
4. 插入的数据没有指定 _id ，会自动生成主键值
5. 如果某字段没值，可以赋值为null，或不写该字段。



执行后，如下，说明插入一个数据成功了。

```sh
WriteResult({ "nInserted" : 1 })
```



注意

1. 文档中的键/值对是有序的。
2. 文档中的值不仅可以是在双引号里面的字符串，还可以是其他几种数据类型（甚至可以是整个嵌入的文档)。
3. MongoDB区分类型和大小写。
4. MongoDB的文档不能有重复的键。
5. 文档的键是字符串。除了少数例外情况，键可以使用任意UTF-8字符。

文档键命名规范：

- 键不能含有\0 (空字符)。这个字符用来表示键的结尾。
- .和$有特别的意义，只有在特定环境下才能使用。
- 以下划线"_"开头的键是保留的(不是严格要求的)。

#### 批量文档插入

语法:

```sh
db.collection.insertMany(
	[ <document 1> , <document 2>, ... ],
	{
		writeConcern: <document>,
		ordered: <boolean>
	}
)
```

参数：

| Parameter      | Type     | Description                                                  |
| -------------- | -------- | ------------------------------------------------------------ |
| `document`     | document | 要插入到集合中的文档或文档数组。（(json格式）                |
| `writeConcern` | document | Optional. A document expressing the [write concern]([Write Concern — MongoDB Manual (opens new window)](https://www.mongodb.com/docs/manual/reference/write-concern/)). Omit to use the default write concern.Do not explicitly set the write concern for the operation if run in a transaction. To use write concern with transactions, see [Transactions and Write Concern]([Transactions — MongoDB Manual (opens new window)](https://www.mongodb.com/docs/manual/core/transactions/#transactions-write-concern)). |
| `ordered`      | boolean  | 可选。一个布尔值，指定Mongod实例应执行有序插入还是无序插入。默认为true。 |

【示例】

批量插入多条文章评论：

```json
db.comment.insertMany([
	{"_id":"1","articleid":"100001","content":"我们不应该把清晨浪费在手机上，健康很重要，一杯温水幸福你我他。","userid":"1002","nickname":"相忘于江湖","createdatetime":new Date("2019-08-05T22:08:15.522Z"),"likenum":NumberInt(1000),"state":"1"},
	{"_id":"2","articleid":"100001","content":"我夏天空腹喝凉开水，冬天喝温开水","userid":"1005","nickname":"伊人憔悴","createdatetime":new Date("2019-08-05T23:58:51.485Z"),"likenum":NumberInt(888),"state":"1"},
	{"_id":"3","articleid":"100001","content":"我一直喝凉开水，冬天夏天都喝。","userid":"1004","nickname":"杰克船长","createdatetime":new Date("2019-08-06T01:05:06.321Z"),"likenum":NumberInt(666),"state":"1"},
	{"_id":"4","articleid":"100001","content":"专家说不能空腹吃饭，影响健康。","userid":"1003","nickname":"凯撒","createdatetime":new Date("2019-08-06T08:18:35.288Z"),"likenum":NumberInt(2000),"state":"1"},
	{"_id":"5","articleid":"100001","content":"研究表明，刚烧开的水千万不能喝，因为烫嘴。","userid":"1003","nickname":"凯撒","createdatetime":new Date("2019-08-06T11:01:02.521Z"),"likenum":NumberInt(3000),"state":"1"}
]);
```

提示：

1. 插入时指定了 _id ，则主键就是该值。
2. 如果某条数据插入失败，将会终止插入，但已经插入成功的数据不会回滚掉。
3. **因为批量插入由于数据较多容易出现失败，因此，可以使用try catch进行异常捕捉处理，测试的时候可以不处理**。如（了解）：



```json
try{
db.comment.insertMany([
	{"_id":"1","articleid":"100001","content":"我们不应该把清晨浪费在手机上，健康很重要，一杯温水幸福你我他。","userid":"1002","nickname":"相忘于江湖","createdatetime":new Date("2019-08-05T22:08:15.522Z"),"likenum":NumberInt(1000),"state":"1"},
	{"_id":"2","articleid":"100001","content":"我夏天空腹喝凉开水，冬天喝温开水","userid":"1005","nickname":"伊人憔悴","createdatetime":new Date("2019-08-05T23:58:51.485Z"),"likenum":NumberInt(888),"state":"1"},
	{"_id":"3","articleid":"100001","content":"我一直喝凉开水，冬天夏天都喝。","userid":"1004","nickname":"杰克船长","createdatetime":new Date("2019-08-06T01:05:06.321Z"),"likenum":NumberInt(666),"state":"1"},
	{"_id":"4","articleid":"100001","content":"专家说不能空腹吃饭，影响健康。","userid":"1003","nickname":"凯撒","createdatetime":new Date("2019-08-06T08:18:35.288Z"),"likenum":NumberInt(2000),"state":"1"},
	{"_id":"5","articleid":"100001","content":"研究表明，刚烧开的水千万不能喝，因为烫嘴。","userid":"1003","nickname":"凯撒","createdatetime":new Date("2019-08-06T11:01:02.521Z"),"likenum":NumberInt(3000),"state":"1"}
]);
}catch(e){
	print(e)
}
```

### 文档的基本查询

查询数据的语法格式如下：

```sh
db.collection.find(<query>, [projection])
```

参数:

| Parameter    | Type     | Description                                                  |
| ------------ | -------- | ------------------------------------------------------------ |
| `query`      | document | 可选。使用查询运算符指定选择筛选器。若要返回集合中的所有文档，请省略此参数或传递空文档( {} )。 |
| `projection` | document | 可选。指定要在与查询筛选器匹配的文档中返回的字段（投影）。若要返回匹配文档中的所有字段，请省略此参数。 |

【示例】

1. 查询所有

如果我们要查询spit集合的所有文档，我们输入以下命令

```sh
db.comment.find()
或
db.comment.find({})
```

这里你会发现每条文档会有一个叫_id的字段，这个相当于我们原来关系数据库中表的主键，当你在插入文档记录时没有指定该字段，MongoDB会自动创建，其类型是ObjectID类型。

如果我们在插入文档记录时指定该字段也可以，其类型可以是ObjectID类型，也可以是MongoDB支持的任意类型。

如果你只需要返回符合条件的第一条数据，我们可以使用findOne命令来实现，语法和find一样。

如：查询用户编号是1003的记录，但只**最多返回符合条件的第一条记录**：

```sh
db.comment.findOne({userid:'1003'})
```

#### 投影查询

如果要查询结果返回部分字段，则需要使用投影查询（不显示所有字段，只显示指定的字段）。

如：查询结果只显示 _id、userid、nickname :

显示：字段后跟1，不显示字段后跟0

```sh
db.comment.find({userid:"1003"},{userid:1,nickname:1})
{ "_id" : "4", "userid" : "1003", "nickname" : "凯撒" }
{ "_id" : "5", "userid" : "1003", "nickname" : "凯撒" }
```

默认 _id 会示。

如：查询结果只显示 、userid、nickname ，不显示 _id ：

```sh
db.comment.find({userid:"1003"},{userid:1,nickname:1,_id:0})
{ "userid" : "1003", "nickname" : "凯撒" }
{ "userid" : "1003", "nickname" : "凯撒" }
```

再例如：查询所有数据，但只显示 _id、userid、nickname

```sh
db.comment.find({},{userid:1,nickname:1})
```

### 文档的更新

更新文档的语法：



```json
db.collection.update(query, update, options)
//或
db.collection.update(
	<query>,
	<update>,
	{
		upsert: <boolean>,
		multi: <boolean>,
		writeConcern: <document>,
		collation: <document>,
		arrayFilters: [ <filterdocument1>, ... ],
		hint: <document|string> // Available starting in MongoDB 4.2
	}
)
```

参数:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.10xa3cnjv2kw.webp)

提示：

主要关注前四个参数即可。

【示例】

### 1.覆盖的修改

如果我们想修改_id为1的记录，点赞量为1001，输入以下语句：

```sh
db.comment.update({_id:"1"},{likenum:NumberInt(1001)});
# 6.0测试上面的命令显示异常：MongoInvalidArgumentError: Update document requires atomic operators
# 可以使用下面命令替换的方式
db.comment.replaceOne({_id: "1"}, {likenum: NumberInt(1001)})
```

执行后，我们会发现，这条文档除了likenum字段其它字段都不见了

### 2.局部修改

为了解决这个问题，我们需要使用修改器$set来实现，命令如下：

我们想修改_id为2的记录，浏览量为889，输入以下语句：

```sh
db.comment.update({_id:"2"},{$set:{likenum:NumberInt(889)}})
```

这样就OK啦。

### 3.批量的修改

更新所有用户为 1003 的用户的昵称为 凯撒大帝

```sh
//默认只修改第一条数据
db.comment.update({userid:"1003"},{$set:{nickname:"凯撒大帝"}})
//修改所有符合条件的数据
db.comment.update({userid:"1003"},{$set:{nickname:"凯撒大帝"}},{multi:true})
```

提示：如果不加后面的参数，则只更新符合条件的第一条记录

### 4.列值增长的修改

如果我们想实现对某列值在原有值的基础上进行增加或减少，可以使用 $inc 运算符来实现。

需求：对3号数据的点赞数，每次递增1

```sh
db.comment.update({_id:"3"},{$inc:{likenum:NumberInt(1)}})
```

### 删除文档

删除文档的语法结构：

```sh
db.集合名称.remove(条件)
# 删除单挑数据
db.集合名称.deleteOne(条件)
# 删除多条数据
db.集合名称.deleteMany(条件)
```

以下语句可以将数据全部删除，请慎用

```sh
db.comment.remove({})
=
db.comment.deleteMany({})
```

如果删除_id=1的记录，输入以下语句

```sh
db.comment.remove({_id:"1"})
```

## 文档的分页查询

### 统计查询

统计查询使用count()方法，语法如下：

```sh
db.collection.count(query, options)
```

参数:

| Parameter | Type     | Description                    |
| --------- | -------- | ------------------------------ |
| `query`   | document | 查询选择条件                   |
| `options` | document | 可选。用于修改计数的额外选项。 |

提示：

可选项暂时不可用。

[示例]

1. 统计所有记录数：

统计comment集合的所有的记录数：

```sh
db.comment.count()
# 弃用count方法，选择使用countDocuments() 或 estimatedDocumentCount()

# db.comment.countDocuments()：统计总数
# db.comment.estimatedDocumentCount()：统计总数或刷选后统计
```

1. 按条件统计记录数：

例如：统计userid为1003的记录条数

```sh
db.comment.count({userid:"1003"})
```

提示：

默认情况下 count() 方法返回符合条件的全部记录条数。

### 分页列表查询

可以使用**limit()方法来读取指定数量的数据，使用skip()方法来跳过指定数量的数据**。

基本语法如下所示：

```sh
db.COLLECTION_NAME.find().limit(NUMBER).skip(NUMBER)
```

如果你想返回指定条数的记录，可以在find方法后调用limit来返回结果(TopN)，默认值20，例如：

```sh
# 只需前面3条
db.comment.find().limit(3)
```

分页查询：需求：每页2个，第二页开始：跳过前两条数据，接着值显示3和4条数据

```sh
//第一页
db.comment.find().skip(0).limit(2)
//第二页
db.comment.find().skip(2).limit(2)
//第三页
db.comment.find().skip(4).limit(2)
```

### 排序查询

sort() 方法对数据进行排序，sort() 方法可以通过参数指定排序的字段，并使用 1 和 -1 来指定排序的方式，其中 **1 为升序排列，而 -1 是用于降序**排列。

默认id升序排列

语法如下所示：

```sh
db.COLLECTION_NAME.find().sort({KEY:1})
或
db.集合名称.find().sort(排序方式)
```

例如：

对userid降序排列，并对访问量进行升序排列

```sh
db.comment.find().sort({userid:-1,likenum:1})
```

提示：

skip(), limilt(), sort()三个放在一起执行的时候，执行的顺序是先 sort(), 然后是 skip()，最后是显示的 limit()，和命令编写顺序无关。

## 文档的更多查询

### 正则的复杂条件查询

MongoDB的模糊查询是通过**正则表达式**的方式实现的。格式为：

```sh
db.collection.find({field:/正则表达式/})
或
db.集合.find({字段:/正则表达式/})
```

提示：正则表达式是js的语法，直接量的写法。

例如，我要查询评论内容包含“开水”的所有文档，代码如下：

```sh
db.comment.find({content:/开水/})
```

如果要查询评论的内容中以“专家”开头的，代码如下：

```sh
db.comment.find({content:/^专家/})
```

- [js正则表达式用法(opens new window)](https://www.runoob.com/js/js-regexp.html)

### 比较查询

<, <=, >, >= 这个操作符也是很常用的，格式如下:



```sh
db.集合名称.find({ "field" : { $gt: value }}) // 大于: field > value
db.集合名称.find({ "field" : { $lt: value }}) // 小于: field < value
db.集合名称.find({ "field" : { $gte: value }}) // 大于等于: field >= value
db.集合名称.find({ "field" : { $lte: value }}) // 小于等于: field <= value
db.集合名称.find({ "field" : { $ne: value }}) // 不等于: field != value
```

示例：查询评论点赞数量大于700的记录

```sh
db.comment.find({likenum:{$gt:NumberInt(700)}})
```

### 包含查询

包含使用$in操作符。 示例：查询评论的集合中userid字段包含1003或1004的文档

```sh
db.comment.find({userid:{$in:["1003","1004"]}})
```

不包含使用$nin操作符。 示例：查询评论集合中userid字段不包含1003和1004的文档

```sh
db.comment.find({userid:{$nin:["1003","1004"]}})
```

### 条件连接查询

我们如果需要查询同时满足两个以上条件，需要使用$and操作符将条件进行关联。（相 当于SQL的and） 格式为：

```sh
$and:[ { },{ },{ } ]
```

示例：查询评论集合中likenum大于等于700 并且小于2000的文档：

```sh
db.comment.find({$and:[{likenum:{$gte:NumberInt(700)}},{likenum:{$lt:NumberInt(2000)}}]}) 
# 可简写
db.comment.find({likenum:{$gte:NumberInt(700), $lt:NumberInt(2000)}})
```

如果两个以上条件之间是或者的关系，我们使用 操作符进行关联，与前面 and的使用方式相同 格式为：

```sh
$or:[ { },{ },{ } ]
```

示例：查询评论集合中userid为1003，或者点赞数小于1000的文档记录

```sh
db.comment.find({$or:[ {userid:"1003"} ,{likenum:{$lt:1000} }]})
```

## 常用命令小结

| 命令                                                         | 含义                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| use articledb                                                | 选择数据库                                                   |
| db.comment.insert({bson数据})                                | 插入数据                                                     |
| db.comment.find();                                           | 查询所有数据                                                 |
| db.comment.find({条件})                                      | 条件查询数据                                                 |
| db.comment.findOne({条件})                                   | 查询符合条件的第一条记录                                     |
| db.comment.find({条件}).limit(条数)                          | 查询符合条件的前几条记录                                     |
| db.comment.find({条件}).skip(条数)                           | 查询符合条件的跳过的记录                                     |
| db.comment.update({条件},{修改后的数据}) <br />或db.comment.update({条件},{$set:{要修改部分的字段:数据}) | 修改数据（修改单个且不覆盖，使用replaceOne方法）             |
| db.comment.update({条件},{$inc:{自增的字段:步进值}})         | 修改数据并自增某字段值                                       |
| db.comment.remove({条件})                                    | 删除数据                                                     |
| db.comment.count({条件})                                     | 统计查询                                                     |
| db.comment.find({字段名:/正则表达式/})                       | 模糊查询                                                     |
| db.comment.find({字段名:{$gt:值}})                           | 条件比较运算                                                 |
| db.comment.find({字段名:{$in:[值1，值2]}})<br />或db.comment.find({字段名:{$nin:[值1，值2]}}) | 包含查询                                                     |
| db.comment.find({$and:[{条件1},{条件2}]})<br />或db.comment.find({$or:[{条件1},{条件2}]}) | 条件连接查询存放文章评论的数据存放到MongoDB中，数据结构参考如下： |

---

# 索引概述

索引支持在MongoDB中高效地执行查询。如果没有索引，MongoDB必须执行全集合扫描，即扫描集合中的每个文档，以选择与查询语句匹配的文档。这种扫描全集合的查询效率是非常低的，特别在处理大量的数据时，查询可以要花费几十秒甚至几分钟，这对网站的性能是非常致命的。

如果查询存在适当的索引，MongoDB可以使用该索引限制必须检查的文档数。

索引是特殊的数据结构，它以易于遍历的形式存储集合数据集的一小部分。索引存储特定字段或一组字段的值，按字段值排序。索引项的排序支持有效的相等匹配和基于范围的查询操作。此外，MongoDB还可以使用索引中的排序返回排序结果。

[官网文档(opens new window)](https://docs.mongodb.com/manual/indexes/)

了解：

MongoDB索引使用B树数据结构（确切的说是B-Tree，MySQL是B+Tree）

## 索引的类型

### 单字段索引

MongoDB支持在文档的单个字段上创建用户定义的升序/降序索引，称为单字段索引（Single Field Index）。

对于单个字段索引和排序操作，索引键的排序顺序（即升序或降序）并不重要，因为MongoDB可以在任何方向上遍历索引。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.5l8wdgg3kfg0.webp)

### 复合索引

MongoDB还支持多个字段的用户定义索引，即复合索引（Compound Index）。

复合索引中列出的字段顺序具有重要意义。例如，如果复合索引由 { userid: 1, score: -1 } 组成，则索引首先按userid正序排序，然后在每个userid的值内，再在按score倒序排序。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.78a8t9ixshc0.webp)

### 其他索引

地理空间索引（Geospatial Index）、文本索引（Text Indexes）、哈希索引（Hashed Indexes）。

地理空间索引（Geospatial Index）

为了支持对地理空间坐标数据的有效查询，MongoDB提供了两种特殊的索引：返回结果时使用平面几何的二维索引和返回结果时使用球面几何的二维球面索引。

文本索引（Text Indexes）

MongoDB提供了一种文本索引类型，支持在集合中搜索字符串内容。这些文本索引不存储特定于语言的停止词（例如“the”、“a”、“or”），而将集合中的词作为词干，只存储根词。

哈希索引（Hashed Indexes）

为了支持基于散列的分片，MongoDB提供了散列索引类型，它对字段值的散列进行索引。这些索引在其范围内的值分布更加随机，但只支持相等匹配，不支持基于范围的查询。

## 索引的管理操作

### 索引的查看

说明:

返回一个集合中的所有索引的数组。

语法：

```sh
db.collection.getIndexes()
```

提示：该语法命令运行要求是MongoDB 3.0+



【示例】

查看comment集合中所有的索引情况

```sh
> db.comment.getIndexes()
[
        {
                "v" : 2,
                "key" : {
                        "_id" : 1
                },
                "name" : "_id_",
                "ns" : "articledb.comment"
        }
]
```

结果中显示的是默认`_id` 索引。

默认_id索引：

MongoDB在创建集合的过程中，在 `_id`字段上创建一个唯一的索引，默认名字为`_id_`，该索引可防止客户端插入两个具有相同值的文档，您不能在_id字段上删除此索引。

注意：该索引是唯一索引，因此值不能重复，即`_id`值不能重复的。在分片集群中，通常使用`_id` 作为片键。

### 创建索引

说明:

在集合上创建索引。

语法:

```sh
db.collection.createIndex(keys,options)
```

参数:

| Parameter | Type     | Description                                                  |
| --------- | -------- | ------------------------------------------------------------ |
| `keys`    | document | 包含字段和值对的文档，其中字段是索引键，值描述该字段的索引类型。对于字段上的升序索引，请指定值1；对于降序索引，请指定值-1。比如： `{字段:1或-1}` ，其中1 为指定按升序创建索引，如果你想按降序来创建索引指定为 -1 即可。另外，MongoDB支持几种不同的索引类型，包括文本、地理空间和哈希索引。 |
| `options` | document | 可选。包含一组控制索引创建的选项的文档。有关详细信息，请参见选项详情列表。 |



options（更多选项）列表：

| Parameter          | Type          | Description                                                  |
| ------------------ | ------------- | ------------------------------------------------------------ |
| background         | Boolean       | 建索引过程会阻塞其它数据库操作，background可指定以后台方式创建索引，即增加"background" 可选参数。 "background" 默认值为`false`。 |
| unique             | Boolean       | 建立的索引是否唯一。指定为true创建唯一索引。默认值为`false`. |
| name               | string        | 索引的名称。如果未指定，MongoDB的通过连接索引的字段名和排序顺序生成一个索引名称。 |
| dropDups           | Boolean       | 3.0+版本已废弃。在建立唯一索引时是否删除重复记录,指定 true 创建唯一索引。默认值为`false` |
| sparse             | Boolean       | 对文档中不存在的字段数据不启用索引；这个参数需要特别注意，如果设置为true的话，在索引字段中不会查询出不包含对应字段的文档.。默认值为 `false`. |
| expireAfterSeconds | integer       | 指定一个以秒为单位的数值，完成 TTL设定，设定集合的生存时间。 |
| v                  | index version | 索引的版本号。默认的索引版本取决于mongod创建索引时运行的版本。 |
| weights            | document      | 索引权重值，数值在 1 到 99,999 之间，表示该索引相对于其他索引字段的得分权重。 |
| default_language   | string        | 对于文本索引，该参数决定了停用词及词干和词器的规则的列表。 默认为英语 |
| language_override  | string        | 对于文本索引，该参数指定了包含在文档中的字段名，语言覆盖默认的language，默认值为language. |



提示：

注意在 3.0.0 版本前创建索引方法为 `db.collection.ensureIndex()`，之后的版本使用了 `db.collection.createIndex()`方法，ensureIndex() 还能用，但只是 createIndex() 的别名。



【示例】

#### 单字段索引

对 userid 字段建立索引：

```sh
> db.comment.createIndex({userid:-1})
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 1,
        "numIndexesAfter" : 2,
        "ok" : 1
}
```

参数1：按升序创建索引

可以查看一下：

```sh
> db.comment.getIndexes()
[
        {
                "v" : 2,
                "key" : {
                        "_id" : 1
                },
                "name" : "_id_",
                "ns" : "articledb.comment"
        },
        {
                "v" : 2,
                "key" : {
                        "userid" : -1
                },
                "name" : "userid_-1",
                "ns" : "articledb.comment"
        }
]
```

索引名字为`userid_1`

compass查看:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.a25aczussy.webp)

#### 复合索引

对 userid 和 nickname 同时建立复合（Compound）索引：



```shell
> db.comment.createIndex({userid:-1,nickname:-1})
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 2,
        "numIndexesAfter" : 3,
        "ok" : 1
}
```

查看一下索引：

```sh
> db.comment.getIndexes()
[
        {
                "v" : 2,
                "key" : {
                        "_id" : 1
                },
                "name" : "_id_",
                "ns" : "articledb.comment"
        },
        {
                "v" : 2,
                "key" : {
                        "userid" : -1
                },
                "name" : "userid_-1",
                "ns" : "articledb.comment"
        },
        {
                "v" : 2,
                "key" : {
                        "userid" : -1,
                        "nickname" : -1
                },
                "name" : "userid_-1_nickname_-1",
                "ns" : "articledb.comment"
        }
]
```

compass中：

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.1at13xitxdpc.webp)

### 索引的移除

说明：可以移除指定的索引，或移除所有索引

#### 指定索引的移除

语法：

```sh
db.collection.dropIndex(index)
```

参数:

| Parametar | Type               | Description                                                  |
| --------- | ------------------ | ------------------------------------------------------------ |
| `index`   | string or document | 指定要删除的索引。可以通过索引名称或索引规范文档指定索引。若要删除文本索引，请指定索引名称。 |

【示例】

删除 comment 集合中 userid 字段上的升序索引：

```sh
> db.comment.dropIndex({userid:-1})
{ "nIndexesWas" : 3, "ok" : 1 }
```



#### 所有索引的移除

语法：

```sh
db.comment.dropIndexes()
```

【示例】

删除 spit 集合中所有索引。

```sh
> db.comment.dropIndexes()
{
        "nIndexesWas" : 2,
        "msg" : "non-_id indexes dropped for collection",
        "ok" : 1
}
```

提示：**`_id` 的字段的索引是无法删除的，只能删除非`_id` 字段的索引**。



## 索引的使用

### 执行计划

分析查询性能（Analyze Query Performance）通常使用执行计划（解释计划、Explain Plan）来查看查询的情况，如查询耗费的时间、是否基于索引查询等。

那么，通常，我们想知道，建立的索引是否有效，效果如何，都需要通过执行计划查看。

语法：



```sh
db.collection.find(query,options).explain(options)
```



【示例】

查看根据userid查询数据的情况：

```sh
> db.comment.find({userid:"1003"}).explain()
{
        "queryPlanner" : {
                "plannerVersion" : 1,
                "namespace" : "articledb.comment",
                "indexFilterSet" : false,
                "parsedQuery" : {
                        "userid" : {
                                "$eq" : "1003"
                        }
                },
                "winningPlan" : {
                        "stage" : "COLLSCAN",
                        "filter" : {
                                "userid" : {
                                        "$eq" : "1003"
                                }
                        },
                        "direction" : "forward"
                },
                "rejectedPlans" : [ ]
        },
        "serverInfo" : {
                "host" : "master",
                "port" : 27017,
                "version" : "4.0.10",
                "gitVersion" : "c389e7f69f637f7a1ac3cc9fae843b635f20b766"
        },
        "ok" : 1
}
```



关键点看： `"stage" : "COLLSCAN"`, 表示全集合扫描

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.3s2i2nqx02o0.webp)

下面对userid建立索引



```sh
> db.comment.createIndex({userid:1})
{
        "createdCollectionAutomatically" : false,
        "numIndexesBefore" : 1,
        "numIndexesAfter" : 2,
        "ok" : 1
}
```

再次查看执行计划：

```sh
> db.comment.find({userid:"1003"}).explain()
{
        "queryPlanner" : {
                "plannerVersion" : 1,
                "namespace" : "articledb.comment",
                "indexFilterSet" : false,
                "parsedQuery" : {
                        "userid" : {
                                "$eq" : "1003"
                        }
                },
                "winningPlan" : {
                        "stage" : "FETCH",
                        "inputStage" : {
                                "stage" : "IXSCAN",
                                "keyPattern" : {
                                        "userid" : 1
                                },
                                "indexName" : "userid_1",
                                "isMultiKey" : false,
                                "multiKeyPaths" : {
                                        "userid" : [ ]
                                },
                                "isUnique" : false,
                                "isSparse" : false,
                                "isPartial" : false,
                                "indexVersion" : 2,
                                "direction" : "forward",
                                "indexBounds" : {
                                        "userid" : [
                                                "[\"1003\", \"1003\"]"
                                        ]
                                }
                        }
                },
                "rejectedPlans" : [ ]
        },
        "serverInfo" : {
                "host" : "master",
                "port" : 27017,
                "version" : "4.0.10",
                "gitVersion" : "c389e7f69f637f7a1ac3cc9fae843b635f20b766"
        },
        "ok" : 1
}
```



关键点看： `"stage" : "IXSCAN"` ,基于索引的扫描

compass查看：

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.1gncli23u55s.webp)

### 涵盖的扫描

Covered Queries

当查询条件和查询的投影仅包含索引字段时，MongoDB直接从索引返回结果(不再去找集合)，而不扫描任何文档或将文档带入内存。 这些覆盖的查询可以非常有效。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.3ls8cdhjarg0.webp)

【示例】



```sh
>  db.comment.find({userid:"1003"},{userid:1,_id:0})
{ "userid" : "1003" }
{ "userid" : "1003" }
> db.comment.find({userid:"1003"},{userid:1,_id:0}).explain()
{
        "queryPlanner" : {
                "plannerVersion" : 1,
                "namespace" : "articledb.comment",
                "indexFilterSet" : false,
                "parsedQuery" : {
                        "userid" : {
                                "$eq" : "1003"
                        }
                },
                "winningPlan" : {
                        "stage" : "PROJECTION",
                        "transformBy" : {
                                "userid" : 1,
                                "_id" : 0
                        },
                        "inputStage" : {
                                "stage" : "IXSCAN",
                                "keyPattern" : {
                                        "userid" : 1
                                },
                                "indexName" : "userid_1",
                                "isMultiKey" : false,
                                "multiKeyPaths" : {
                                        "userid" : [ ]
                                },
                                "isUnique" : false,
                                "isSparse" : false,
                                "isPartial" : false,
                                "indexVersion" : 2,
                                "direction" : "forward",
                                "indexBounds" : {
                                        "userid" : [
                                                "[\"1003\", \"1003\"]"
                                        ]
                                }
                        }
                },
                "rejectedPlans" : [ ]
        },
        "serverInfo" : {
                "host" : "master",
                "port" : 27017,
                "version" : "4.0.10",
                "gitVersion" : "c389e7f69f637f7a1ac3cc9fae843b635f20b766"
        },
        "ok" : 1
}
```



Compass中：

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220625/image.1ebr55whcaao.webp)

---

# 需求分析

某头条的文章评论业务如下：

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220626/image.77ioanbkj3k0.webp)

文章示例参考：早晨空腹喝水，是对还是错？https://www.toutiao.com/a6721476546088927748/

需要实现以下功能：

1. 基本增删改查API
2. 根据文章id查询评论
3. 评论点赞

## 表结构分析

数据库：articledb

| 专栏文章评论   | comment        |                  |                           |
| -------------- | -------------- | ---------------- | ------------------------- |
| 字段名称       | 字段含义       | 字段类型         | 备注                      |
| _id            | ID             | ObjectId或String | Mongo的主键字段           |
| articleid      | 文章ID         | String           |                           |
| content        | 评论内容       | String           |                           |
| userid         | 评论人ID       | String           |                           |
| nickname       | 评论人昵称     | String           |                           |
| createdatetime | 评论的日期时间 | Data             |                           |
| likenum        | 点赞数         | Int32            |                           |
| replynum       | 回复数         | Int32            |                           |
| state          | 状态           | String           | 0：不可见；1：可见；      |
| parentid       | 上级ID         | String           | 如果为0表示文章的顶级评论 |



## 技术选型

### mongodb-driver（了解）

mongodb-driver是mongo官方推出的java连接mongoDB的驱动包，相当于JDBC驱动。我们通过一个入门的案例来了解mongodb-driver的基本使用。

官方驱动说明和下载：http://mongodb.github.io/mongo-java-driver/

官方驱动示例文档：http://mongodb.github.io/mongo-java-driver/3.8/driver/getting-started/quick-start/

### SpringDataMongoDB

SpringData家族成员之一，用于操作MongoDB的持久层框架，封装了底层的mongodb-driver。

官网主页： https://projects.spring.io/spring-data-mongodb/

我们十次方项目的吐槽微服务就采用SpringDataMongoDB框架。

## 文章微服务模块搭建

1. 搭建项目工程article，pom.xml引入依赖：



```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.1</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.frx01</groupId>
    <artifactId>article</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>article</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <java.version>1.8</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-mongodb</artifactId>
        </dependency>
         <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

</project>
```

2.创建application.yml



```yaml
spring:
  #数据源配置
  data:
    mongodb:
    # 主机地址
    host: 192.168.72.200
    # 数据库
    database: articledb
    # 默认端口是27017
    port: 27017
    #也可以使用uri连接
    #uri: mongodb://192.168.72.200:27017/articledb
```

3.自动创建好启动类



```java
@SpringBootApplication
public class ArticleApplication {

    public static void main(String[] args) {
        SpringApplication.run(ArticleApplication.class, args);
    }

}
```

1. 启动项目，看是否能正常启动，控制台没有错误。
2. 

## 文章评论实体类的编写

创建实体类 创建包com.frx01.article，包下建包pojo用于存放实体类，创建实体类 com.frx01.article.pojo.Comment



```java
@Data
//把一个java类声明为mongodb的文档，可以通过collection参数指定这个类对应的文档。
//@Document(collection="mongodb 对应 collection 名")
// 若未加 @Document ，该 bean save 到 mongo 的 comment collection
// 若添加 @Document ，则 save 到 comment collection
@Document(collection="comment")//可以省略，如果省略，则默认使用类名小写映射集合
//复合索引
// @CompoundIndex( def = "{'userid': 1, 'nickname': -1}")
public class Comment implements Serializable {
    //主键标识，该属性的值会自动对应mongodb的主键字段"_id"，如果该属性名就叫“id”,则该注解可以省略，否则必须写
    @Id
    private String id;//主键
    //该属性对应mongodb的字段的名字，如果一致，则无需该注解
    @Field("content")
    private String content;//吐槽内容
    private Date publishtime;//发布日期
    //添加了一个单字段的索引
    @Indexed
    private String userid;//发布人ID
    private String nickname;//昵称
    private LocalDateTime createdatetime;//评论的日期时间
    private Integer likenum;//点赞数
    private Integer replynum;//回复数
    private String state;//状态
    private String parentid;//上级ID
    private String articleid;

}
```



> 说明：
>
> 索引可以大大提升查询效率，一般在查询字段上添加索引，索引的添加可以通过Mongo的命令来添加，也可以在Java的实体类中通过注解添加。

> 1. 单字段索引注解@Indexed
>
> org.springframework.data.mongodb.core.index.Indexed.class
>
> 声明该字段需要索引，建索引可以大大的提高查询效率。
>
> Mongo命令参考：
>
> 
>
> ```sh
> db.comment.createIndex({"userid":1})
> ```
>
> 

> 2.复合索引注解@CompoundIndex
>
> org.springframework.data.mongodb.core.index.CompoundIndex.class
>
> 复合索引的声明，建复合索引可以有效地提高多字段的查询效率。
>
> Mongo命令参考：
>
> 
>
> ```sh
> db.comment.createIndex({"userid":1,"nickname":-1})
> ```
>
> 

## 文章评论的基本增删改查

1. 创建数据访问接口 com.frx01.article包下创建dao包，包下创建接口

com.frx01.article.dao.CommentRepository



```java
//desc:评论的持久层接口
public interface CommentRepository extends MongoRepository<Comment,String> {
}
```



1. 创建业务逻辑类 com.frx01.article包下创建service包，包下创建类

com.frx01.article.service.CommentService



```java
@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    /**
     * 保存一个评论
     *
     * @param comment
     */
    public void saveComment(Comment comment) {
        //如果需要自定义主键，可以在这里指定主键；如果不指定主键，MongoDB会自动生成主键
        //设置一些默认初始值。。。
        //调用dao
        commentRepository.save(comment);
    }

    /**
     * 更新评论
     *
     * @param comment
     */
    public void updateComment(Comment comment) {
        //调用dao
        commentRepository.save(comment);
    }

    /**
     * 根据id删除评论
     *
     * @param id
     */
    public void deleteCommentById(String id) {
        //调用dao
        commentRepository.deleteById(id);
    }

    /**
     * 查询所有评论
     *
     * @return
     */
    public List<Comment> findCommentList() {
        //调用dao
        return commentRepository.findAll();
    }

    /**
     * 根据id查询评论
     *
     * @param id
     * @return
     */
    public Comment findCommentById(String id) {
        //调用dao
        return commentRepository.findById(id).get();
    }

}
```

2.新建Junit测试类，测试保存和查询所有：



```java
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest

public class ArticleApplicationTests {

    @Autowired
    private CommentService commentService;
    
     /**
     * 通过id查询评论
     */
    @Test
    public void testFindCommentById(){
        Comment commentById = commentService.findCommentById("1");
        System.out.println(commentById);

    }

     /**
     * 保存一个评论
     */
    @Test
    public void testSaveComment(){
        Comment comment = new Comment();
        comment.setArticleid("100000");
        comment.setContent("测试添加的数据");
        comment.setCreatedatetime(LocalDateTime.now());
        comment.setUserid("1006");
        comment.setNickname("xustudyxu");
        comment.setState("1");
        comment.setReplynum(0);
        comment.setReplynum(0);
        commentService.saveComment(comment);
    }

    /**
     * 查询全部评论
     */
    @Test
    public void testFindCommentList(){
        List<Comment> commentList = commentService.findCommentList();
        commentList.forEach(System.out::println);
    }

    
}
```



## 根据上级ID查询文章评论的分页列表

1. CommentRepository新增方法定义



```java
	//根据父id，查询子评论的分页列表
	Page<Comment> findByParentid(String parentid, Pageable pageable);
```

2.CommentService新增方法



```java
    /**
     * 根据parentid查询分页列表
     * @param parentid
     * @param page
     * @param size
     * @return
     */
    public Page<Comment> findCommentListByParentid(String parentid,int page,int size){
        return commentRepository.findByParentid(parentid, PageRequest.of(page-1,size));
    }
```



3.junit测试用例：

com.frx01.article.ArticleApplicationTests



```java
    /**
     * 测试根据父id查询子评论的分页列表
     */
    @Test
    public void testFindCommentListByParentid(){
        Page<Comment> pageResponse = commentService.findCommentListByParentid("3", 1, 2);
        System.out.println("---总记录数---:"+pageResponse.getTotalElements());
        System.out.println("---当前页数据---:"+pageResponse.getContent());

    }
```

4.测试

使用compass快速插入一条测试数据，数据的内容是对3号评论内容进行评论。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220626/image.59gip5txbns0.webp)

执行测试，结果：



```java
---总记录数---:1
---当前页数据---:[Comment(id=62b86e74258c6f1903c71820, content=:不要让惰性毁了你, publishtime=null, userid=1003, nickname=null, createdatetime=null, likenum=null, replynum=null, state=null, parentid=3, articleid=100000)]

Process finished with exit code 0
```



## MongoTemplate实现评论点赞

我们看一下以下点赞的临时示例代码： CommentService 新增updateThumbup方法



```java
    /**
     * 点赞-效率低
     * @param id
     */
    public void updateCommentThumbupToIncrementingOld(String id){
        Comment comment = commentRepository.findById(id).get();
        comment.setLikenum(comment.getReplynum()+1);
        commentRepository.save(comment);
    }
```



以上方法虽然实现起来比较简单，但是执行效率并不高，因为我只需要将点赞数加1就可以了，没必要查询出所有字段修改后再更新所有字段。(蝴蝶效应)

我们可以使用MongoTemplate类来实现对某列的操作。

1. 修改CommentService

```java
	//注入MongoTemplate
	@Autowired
	private MongoTemplate mongoTemplate;
    
	/**
     * 点赞数+1
     * @param id
     */
    public void updataCommentLikenum(String id){

        //查询条件
        Query query = Query.query(Criteria.where("_id").is(id));

        //更新条件
        Update update = new Update();

        //局部更新，相当于$set
        // update.set(key,value)
        //递增$inc
        // update.inc("likenum",1);
        update.inc("likenum");


        //参数1：查询对象
        //参数2：更新对象
        //参数3：集合的名字或实体类的类型Comment.class
        mongoTemplate.updateFirst(query,update,Comment.class);
    }
```

1. 测试用例



```java
    @Test
    public void testupdataCommentLikenum(){

        //对3号文档的点赞数+1
        commentService.updataCommentLikenum("3");
    }
```

测试前:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220626/image.491df2bzkko0.webp)

测试后:

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220626/image.56w9b798ius0.webp)

---





# MongoDB 集群和安全

## 副本集-Replica Sets

### 简介

MongoDB中的副本集（Replica Set）是一组维护相同数据集的mongod服务。 副本集可提供冗余和高 可用性，是所有生产部署的基础。

也可以说，副本集类似于有自动故障恢复功能的主从集群。通俗的讲就是用多台机器进行同一数据的异 步同步，从而使多台机器拥有同一数据的多个副本，并且当主库当掉时在不需要用户干预的情况下自动 切换其他备份服务器做主库。而且还可以利用副本服务器做只读服务器，实现读写分离，提高负载。

1. 冗余和数据可用性

复制提供冗余并提高数据可用性。 通过在不同数据库服务器上提供多个数据副本，复制可提供一定级别 的容错功能，以防止丢失单个数据库服务器。

在某些情况下，复制可以提供增加的读取性能，因为客户端可以将读取操作发送到不同的服务上， 在不 同数据中心维护数据副本可以增加分布式应用程序的数据位置和可用性。 您还可以为专用目的维护其他 副本，例如灾难恢复，报告或备份。

1. MongoDB中的复制

副本集是一组维护相同数据集的mongod实例。 副本集包含多个数据承载节点和可选的一个仲裁节点。 在承载数据的节点中，一个且仅一个成员被视为主节点，而其他节点被视为次要（从）节点。

主节点接收所有写操作。 副本集只能有一个主要能够确认具有{w：“most”}写入关注的写入; 虽然在某 些情况下，另一个mongod实例可能暂时认为自己也是主要的。主要记录其操作日志中的数据集的所有 更改，即oplog。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220627/image.28iayc515les.webp)

辅助(副本)节点复制主节点的oplog并将操作应用于其数据集，以使辅助节点的数据集反映主节点的数据 集。 如果主要人员不在，则符合条件的中学将举行选举以选出新的主要人员。

1. 主从复制和副本集区别

主从集群和副本集最大的区别就是副本集没有固定的“主节点”；整个集群会选出一个“主节点”，当其挂 掉后，又在剩下的从节点中选中其他节点为“主节点”，副本集总有一个活跃点(主、primary)和一个或多 个备份节点(从、secondary)。

## 副本集的三个角色

副本集有两种类型三种角色

两种类型：

- 主节点（Primary）类型：数据操作的主要连接点，可读写。
- 次要（辅助、从）节点（Secondaries）类型：数据冗余备份节点，可以读或选举。

三种角色：

主要成员（Primary）：主要接收所有写操作。就是主节点。

副本成员（Replicate）：从主节点通过复制操作以维护相同的数据集，即备份数据，不可写操作，但可 以读操作（但需要配置）。是默认的一种从节点类型。

仲裁者（Arbiter）：不保留任何数据的副本，只具有投票选举作用。当然也可以将仲裁服务器维护为副 本集的一部分，即副本成员同时也可以是仲裁者。也是一种从节点类型。

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220627/image.4ff6racfmye0.webp)

关于仲裁者的额外说明：

您可以将额外的mongod实例添加到副本集作为仲裁者。 仲裁者不维护数据集。 仲裁者的目的是通过 响应其他副本集成员的心跳和选举请求来维护副本集中的仲裁。 因为它们不存储数据集，所以仲裁器可 以是提供副本集仲裁功能的好方法，其资源成本比具有数据集的全功能副本集成员更便宜。

如果您的副本集具有偶数个成员，请添加仲裁者以获得主要选举中的“大多数”投票。 仲裁者不需要专用 硬件。

仲裁者将永远是仲裁者，而主要人员可能会退出并成为次要人员，而次要人员可能成为选举期间的主要 人员。

如果你的副本+主节点的个数是偶数，建议加一个仲裁者，形成奇数，容易满足大多数的投票。

如果你的副本+主节点的个数是奇数，可以不加仲裁者。

## 副本集架构目标

一主一副本一仲裁

![image](https://cdn.staticaly.com/gh/xustudyxu/image-hosting@master/20220627/image.31yuyn1jm8g0.webp)

## 副本集的创建

### 第一步：创建主节点

建立存放数据和日志的目录

```sh
#-----------myrs
#主节点
mkdir -p /mongodb/replica_sets/myrs_27017/log \ &
mkdir -p /mongodb/replica_sets/myrs_27017/data/db
```



新建或修改配置文件

```sh
vim /mongodb/replica_sets/myrs_27017/mongod.conf
```

myrs_27017：

```yaml
systemLog:
  #MongoDB发送所有日志输出的目标指定为文件
  destination: file
  #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
  path: "/mongodb/replica_sets/myrs_27017/log/mongod.log"
  #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
  logAppend: true
storage:
  #mongod实例存储其数据的目录。storage.dbPath设置仅适用于mongod。
  dbPath: "/mongodb/replica_sets/myrs_27017/data/db"
  journal:
    #启用或禁用持久性日志以确保数据文件保持有效和可恢复。
    enabled: true
processManagement:
  #启用在后台运行mongos或mongod进程的守护进程模式。
  fork: true
  #指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
  pidFilePath: "/mongodb/replica_sets/myrs_27017/log/mongod.pid"
net:
  #服务实例绑定所有IP，有副作用，副本集初始化的时候，节点名字会自动设置为本地域名，而不是ip
  #bindIpAll: true
  #服务实例绑定的IP
  bindIp: localhost,192.168.72.2
  #bindIp
  #绑定的端口
  port: 27017
replication:
  #副本集的名称
  replSetName: myrs
```



启动节点服务：

```sh
[root@master ~]#  /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27017/mongod.conf
about to fork child process, waiting until server is ready for connections.
forked process: 2038
child process started successfully, parent exiting
```



### 第二步：创建副本节点

建立存放数据和日志的目录

```sh
#-----------myrs
#副本节点
mkdir -p /mongodb/replica_sets/myrs_27018/log \ &
mkdir -p /mongodb/replica_sets/myrs_27018/data/db
```



新建或修改配置文件：

```sh
mkdir /mongodb/replica_sets/myrs_27018/
cd /mongodb/replica_sets/myrs_27017/
cp mongod.conf /mongodb/replica_sets/myrs_27018/mongod.conf
```



myrs_27018：

把myrs_27017中的端口号改为27018即可

```sh
:% s/27017/27018/g
```

启动节点服务：

```sh
[root@master mongodb]#  /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27018/mongod.conf
about to fork child process, waiting until server is ready for connections.
forked process: 2217
child process started successfully, parent exiting
```



### 第三步：创建仲裁节点

建立存放数据和日志的目录

```sh
#-----------myrs
#仲裁节点
mkdir -p /mongodb/replica_sets/myrs_27019/log \ &
mkdir -p /mongodb/replica_sets/myrs_27019/data/db
```



仲裁节点：

新建或修改配置文件：

```sh
mkdir /mongodb/replica_sets/myrs_27019/
cd /mongodb/replica_sets/myrs_27017/
cp mongod.conf /mongodb/replica_sets/myrs_27019/mongod.conf
```

myrs_27019：

把myrs_27017中的端口号改为27019即可

```sh
:% s/27017/27019/g
```

启动节点服务：

```sh
[root@master myrs_27019]#  /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27019/mongod.conf
about to fork child process, waiting until server is ready for connections.
forked process: 2342
child process started successfully, parent exiting
```

- 使用命令行查看mongo服务

```sh
[root@master myrs_27019]# ps -ef | grep mongo
root       2038      1  0 20:25 ?        00:00:04 /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27017/mongod.conf
root       2217      1  0 20:37 ?        00:00:01 /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27018/mongod.conf
root       2342      1  0 20:43 ?        00:00:00 /usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27019/mongod.conf
root       2388   1880  0 20:45 pts/0    00:00:00 grep --color=auto mongo
```



### 第四步：初始化配置副本集和主节点

使用客户端命令连接任意一个节点，但这里尽量要连接主节点(27017节点)：

```shell
/usr/local/mongodb/bin/mongo --host=192.168.72.200 --port=27017
```



结果，连接上之后，很多命令无法使用，，比如 show dbs 等，必须初始化副本集才行

准备初始化新的副本集：

语法：

```sh
rs.initiate(configuration)
```

选项:

| Parameter       | Type     | Description                                                  |
| --------------- | -------- | ------------------------------------------------------------ |
| `configuration` | document | Optional. A document that specifies configuration for the new replica set. If a configuration is not specified,MongoDB uses a default replica set configuration. |

【示例】

使用默认的配置来初始化副本集：

```sh
rs.initiate()
```

执行结果：

```sh
> rs.initiate()
{
        "info2" : "no configuration specified. Using a default configuration for the set",
        "me" : "localhost:27019",
        "ok" : 1,
        "operationTime" : Timestamp(1656343919, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1656343919, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
myrs:OTHER>
myrs:PRIMARY>
```



> 提示：
>
> 1. “ok”的值为1，说明创建成功。
> 2. 命令行提示符发生变化，变成了一个从节点角色，此时默认不能读写。稍等片刻，回车，变成主节 点。

### 第五步：查看副本集的配置内容

说明：

返回包含当前副本集配置的文档。

语法：

```sh
rs.conf(configuration)
```



> 提示：
>
> rs.config() 是该方法的别名。
>
> configuration：可选，如果没有配置，则使用默认主节点配置。

【示例】

在27017上执行副本集中当前节点的默认节点配置



```sh
myrs:PRIMARY> rs.conf()
{
        "_id" : "myrs",
        "version" : 1,
        "protocolVersion" : NumberLong(1),
        "writeConcernMajorityJournalDefault" : true,
        "members" : [
                {
                        "_id" : 0,
                        "host" : "localhost:27019",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : -1,
                "catchUpTakeoverDelayMillis" : 30000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("62b9cd6f2c5c46b2620c8b1b")
        }
}
```

- `"_id" : "myrs"` ：副本集的配置数据存储的主键值，默认就是**副本集**的名字
- `"members"` ：副本集成员数组，此时只有一个： `"host" : "180.76.159.126:27017"` ，该成员不是仲裁节点： `"arbiterOnly" : false` ，优先级（权重值）： `"priority" : 1`
- `"settings"` ：副本集的参数配置。

> 提示：副本集配置的查看命令，本质是查询的是 system.replset 的表中的数据：

```sh
myrs:PRIMARY> use local
switched to db local
myrs:PRIMARY> show collections
oplog.rs
replset.election
replset.minvalid
replset.oplogTruncateAfterPoint
startup_log
system.replset
system.rollback.id
myrs:PRIMARY> db.system.replset.find()
{ "_id" : "myrs", "version" : 1, "protocolVersion" : NumberLong(1), "writeConcernMajorityJournalDefault" : true, "members" : [ { "_id" : 0, "host" : "localhost:27019", "arbiterOnly" : false, "buildIndexes" : true, "hidden" : false, "priority" : 1, "tags" : {  }, "slaveDelay" : NumberLong(0), "votes" : 1 } ], "settings" : { "chainingAllowed" : true, "heartbeatIntervalMillis" : 2000, "heartbeatTimeoutSecs" : 10, "electionTimeoutMillis" : 10000, "catchUpTimeoutMillis" : -1, "catchUpTakeoverDelayMillis" : 30000, "getLastErrorModes" : {  }, "getLastErrorDefaults" : { "w" : 1, "wtimeout" : 0 }, "replicaSetId" : ObjectId("62b9cd6f2c5c46b2620c8b1b") } }
```



### 第六步：查看副本集状态

返回包含状态信息的文档。此输出使用从副本集的其他成员发送的心跳包中获得的数据反映副本集的当 前状态

```sh
rs.status()
```



【示例】

在27017上查看副本集状态：



```sh
myrs:PRIMARY> rs.status()
{
        "set" : "myrs",
        "date" : ISODate("2022-06-27T15:37:26.398Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1656344241, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1656344241, 1),
                        "t" : NumberLong(1)
                },
                "appliedOpTime" : {
                        "ts" : Timestamp(1656344241, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1656344241, 1),
                        "t" : NumberLong(1)
                }
        },
        "lastStableCheckpointTimestamp" : Timestamp(1656344211, 1),
        "members" : [
                {
                        "_id" : 0,
                        "name" : "localhost:27019",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 566,
                        "optime" : {
                                "ts" : Timestamp(1656344241, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2022-06-27T15:37:21Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1656343919, 2),
                        "electionDate" : ISODate("2022-06-27T15:31:59Z"),
                        "configVersion" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                }
        ],
        "ok" : 1,
        "operationTime" : Timestamp(1656344241, 1),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1656344241, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
```



> 说明：
>
> 1. "set" : "myrs" ：副本集的名字
> 2. "myState" : 1：说明状态正常
> 3. "members" ：副本集成员数组，此时只有一个： "name" : "180.76.159.126:27017" ，该成员的角色是 "stateStr" : "PRIMARY", 该节点是健康的： "health" : 1 。

### 添加副本节点

在主节点添加从节点，将其他成员加入到副本集

```sh
rs.add(host, arbiterOnly)
```

选项:

| Parameter   | Type               | Description                                                  |
| ----------- | ------------------ | ------------------------------------------------------------ |
| host        | string or document | 要添加到副本集的新成员。指定为字符串或配置文档：1）如果是一个字符串，则需要指定新成员的主机名和可选的端口号；2）如果是一个文档，请指定在members数组中找到的副本集成员配置文档。您必须在成员配置文档中指定主机字段。有关文档配置字段的说明，详见下方文档："主机成员的配置文档" |
| arbiterOnly | boolean            | 可选的。仅在值为字符串时适用。如果为true，则添加的主机是仲裁者。 |

主机成员的配置文档：

```sh
{
  _id:<int>,
  host:<string>,
  arbiterOnly:<boolean>,
  buildIndexes:<boolean>,
  hidden:<boolean>,
  priority:<number>,
  tags:<document>,
  slaveDelay:<int>,
  votes:<number>
}
```



示例：

将27018的副本节点加添加到副本集汇总：

```sh
rs.add("localhost:27018")
```



### 添加仲裁从节点

```sh
rs.add(host,arbiterOnly)
或
rs.addArb(host)

例子：
rs.addArb("localhost:27019")
```

## 副本集的数据读写操作

目标：测试三个不同角色的节点的数据读写情况。 



登录主**节点27017，写入和读取数据**：

```sh
[root@bobohost ~]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27017
myrs:PRIMARY> use articledb
switched to db articledb
myrs:PRIMARY> db
articledb
myrs:PRIMARY> db.comment.insert({"articleid":"100000","content":"今天天气真好，阳光明   媚","userid":"1001","nickname":"Rose","createdatetime":new Date()})
WriteResult({"nInserted":1})

myrs:PRIMARY> db.comment.find()
{ "_id" : ObjectId("5d4d2ae3068138b4570f53bf"), "articleid" : "100000","content" : "今天天气真好，阳光明媚", "userid" : "1001", "nickname" : "Rose","createdatetime" : ISODate("2019-08-09T08:12:19.427Z") }

```

登录从节点27018

```sh
[root@bobohost ~]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27018
myrs:SECONDARY> show dbs;
2019-09-10T10:56:51.953+0800 E QUERY [js] Error: listDatabases failed:{
	"operationTime" : Timestamp(1568084204, 1),
	"ok" : 0,
	"errmsg" : "not master and slaveOk=false",
	"code" : 13435,
	"codeName" : "NotMasterNoSlaveOk",
		"$clusterTime" : {
		"clusterTime" : Timestamp(1568084204, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
} :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
Mongo.prototype.getDBs@src/mongo/shell/mongo.js:139:1
shellHelper.show@src/mongo/shell/utils.js:882:13
shellHelper@src/mongo/shell/utils.js:766:15
@(shellhelp2):1:1
```

发现，不能读取集合的数据。当前从节点只是一个备份，不是奴隶节点，无法读取数据，写当然更不 行。 

因为默认情况下，从节点是没有读写权限的，可以增加读的权限，但需要进行设置。 



设置读操作权限： 

说明： 

设置为奴隶节点，允许在从成员上运行读的操作 

语法：

```sh
rs.slaveOk()
#或
rs.slaveOk(true) # 不承认为从节点，设置为false即可

# slaveOk()已弃用改用secondaryOk()
```

提示： 

该命令是 db.getMongo().setSlaveOk() 的简化命令。 

【示例】 

**在27018上设置作为奴隶节点权限**，具备读权限：

```sh
rs:SECONDARY> rs.slaveOk()
```

此时，在执行查询命令，运行成功！ 

但仍然不允许插入

```sh
myrs:SECONDARY> rs.slaveOk()
myrs:SECONDARY> show dbs;
admin 0.000GB
articledb 0.000GB
config 0.000GB
local 0.000GB
myrs:SECONDARY> use articledb
switched to db articledb
myrs:SECONDARY> show collections
comment
myrs:SECONDARY> db.comment.find()
{ "_id" : ObjectId("5d7710c04cfd7eee2e3cdabe"), "articleid" : "100000","content" : "今天天气真好，阳光明媚", "userid" : "1001", "nickname" : "Rose","createdatetime" : ISODate("2019-09-10T02:56:00.467Z") }

myrs:SECONDARY> db.comment.insert({"_id":"1","articleid":"100001","content":"我们不应该把清晨浪费在手机上，健康很重要，k一杯温水幸福你我他。","userid":"1002","nickname":"相忘于江湖","createdatetime":new Date("2019-08-05T22:08:15.522Z"),"likenum":NumberInt(1000),"state":"1"})
WriteCommandError({
	"operationTime" : Timestamp(1568084434, 1),
	"ok" : 0,
	"errmsg" : "not master",
	"code" : 10107,
	"codeName" : "NotMaster",
		"$clusterTime" : {
		"clusterTime" : Timestamp(1568084434, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
})
```

现在可实现了读写分离，让主插入数据，让从来读取数据。 

如果要取消作为奴隶节点的读权限：

```sh
myrs:SECONDARY> rs.slaveOk(false)
myrs:SECONDARY> db.comment.find()
Error: error: {
	"operationTime" : Timestamp(1568084459, 1),
	"ok" : 0,
	"errmsg" : "not master and slaveOk=false",
	"code" : 13435,
	"codeName" : "NotMasterNoSlaveOk",
	"$clusterTime" : {
		"clusterTime" : Timestamp(1568084459, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```



**仲裁者节点**，不存放任何业务数据的，也看不到数据

```sh
[root@bobohost ~]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27019
myrs:ARBITER> rs.slaveOk()

myrs:ARBITER> show dbs
uncaught exception: Error: listDatabases failed:{
	"topologyVersion" : {
		"processId" : ObjectId("62e4ff9403eb05e7cea37df2"),
		"counter" : NumberLong(1)
	},
	"ok" : 0,
	"errmsg" : "node is not in primary or recovering state",
	"code" : 13436,
	"codeName" : "NotPrimaryOrSecondary"
} :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
Mongo.prototype.getDBs/<@src/mongo/shell/mongo.js:147:19
Mongo.prototype.getDBs@src/mongo/shell/mongo.js:99:12
shellHelper.show@src/mongo/shell/utils.js:937:13
shellHelper@src/mongo/shell/utils.js:819:15
@(shellhelp2):1:1
```

发现，只存放副本集配置等数据。





## 主节点的选举原则

MongoDB在副本集中，会自动进行主节点的选举，主节点选举的触发条件

1. 主节点故障
2. 主节点网络不可达 (默认心跳信息为 10 秒)
3. 人工干预 `rs.stepDown(600)`

一旦触发选举，就要根据一定规则来选主节点

选举规则是根据票数来决定谁获胜

- 票数最高，且获得了“大多数”成员的投票支持的节点获胜。
  - “大多数”的定义为：假设复制集内投票成员数量为N，则大多数为 N/2 + 1。例如：3个投票成员， 则大多数的值是2。当复制集内存活成员数量不足大多数时，整个复制集将无法选举出Primary， 复制集将无法提供写服务，处于只读状态。
- 若票数相同，且都获得了“大多数”成员的投票支持的，数据新的节点获胜。
  - 数据的新旧是通过操作日志 oplog 来对比的。

在获得票数的时候，优先级（priority）参数影响重大。

可以通过设置优先级（priority）来设置额外票数。优先级即权重，取值为0-1000，相当于可额外增加 0-1000的票数，优先级的值越大，就越可能获得多数成员的投票（votes）数。指定较高的值可使成员 更有资格成为主要成员，更低的值可使成员更不符合条件。

默认情况下，优先级的值是 1

```sh
# 查看优先级信息 priority参数
rs.conf()

{
	"_id" : "myrs",
	"version" : 3,
	"term" : 1,
	"protocolVersion" : NumberLong(1),
	"writeConcernMajorityJournalDefault" : true,
	"members" : [
		{
			"_id" : 0,
			"host" : "192.168.3.110:27017",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		},
		{
			"_id" : 1,
			"host" : "192.168.3.110:27018",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		},
		{
			"_id" : 2,
			"host" : "192.168.3.110:27019",
			"arbiterOnly" : true,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 0,
			"tags" : {
				
			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		}
	],
	"settings" : {
		"chainingAllowed" : true,
		"heartbeatIntervalMillis" : 2000,
		"heartbeatTimeoutSecs" : 10,
		"electionTimeoutMillis" : 10000,
		"catchUpTimeoutMillis" : -1,
		"catchUpTakeoverDelayMillis" : 30000,
		"getLastErrorModes" : {
			
		},
		"getLastErrorDefaults" : {
			"w" : 1,
			"wtimeout" : 0
		},
		"replicaSetId" : ObjectId("62e508c8966085991d793ab1")
	}
}
```



【了解】修改优先级 

比如，下面提升从节点的优先级： 

1）先将配置导入cfg变量 

```sh
myrs:SECONDARY> cfg=rs.conf()
```

2）然后修改值（ID号默认从0开始）： 

```sh
myrs:SECONDARY> cfg.members[1].priority=2
2
```

3）重新加载配置 

```sh
myrs:SECONDARY> rs.reconfig(cfg)
{ "ok" : 1 }
```

稍等片刻会重新开始选举



## 故障测试

### 副本节点故障测试

关闭 `27018` 副本节点

- 主节点和仲裁节点对 `27018` 的心跳失败。因为主节点还在，因此，没有触发投票选举。

- ```sh
  # 如果此时，在主节点写入数据
  db.comment.insert({"_id":"1","articleid":"100001","content":"我们不应该把清晨浪费在手机上，健康很重要，一杯温水幸福你我他。","userid":"1002","nickname":"相忘于江湖","createdatetime":new Date("2019-08-05T22:08:15.522Z"),"likenum":NumberInt(1000),"state":"1"})
  ```

  

- 如果此时，在主节点写入数据。再启动从节点，会发现，**主节点写入的数据**，**会自动同步给从节点**。

#### 故障测试

关闭27017节点

- 从节点和仲裁节点对27017的心跳失败，当失败超过10秒，此时因为没有主节点了，会自动发起投票。
- 而副本节点只有27018，因此，候选人只有一个就是27018，开始投票。
- 27019向27018投了一票，27018本身自带一票，因此共两票，超过了“大多数”
- 27019是仲裁节点，没有选举权，27018不向其投票，其票数是0.

最终结果，27018成为主节点。具备读写功能。 在27018写入数据查看。

#### 仲裁节点和主节点故障

先关掉仲裁节点27019， 关掉现在的主节点27018 登录27017后

- **27017仍然是从节点**，副本集中没有主节点了，导致此时，副本集是只读状态， 无法写入。
- 为啥不选举了？
  - 因为27017的票数，没有获得大多数，即没有大于等于2，它只有默认的一票（优先级 是1）
  - 如果要触发选举，随便加入一个成员即可。
    - 如果只加入27019仲裁节点成员，则主节点一定是27017，因为没得选了，仲裁节点不参与选举， 但参与投票
    - 如果只加入27018节点，会发起选举。因为27017和27018都是两票，则按照谁数据新，谁当主节点。

#### 仲裁节点和从节点故障

先关掉仲裁节点 `27019`，关掉现在的副本节点 `27018`

10秒后，`27017` 主节点自动降级为副本节点。（服务降级）

副本集不可写数据了，已经故障了。

## Compass连接副本集

**如果使用云服务器需要修改配置中的主节点ip**

在进入选择节点，输入以下命令

```sh
var config = rs.config(); config.members[0].host="180.76.159.126:27017"; rs.reconfig(config)
```

![image-20220731163921787](assets/image-20220731163921787.png)

![image-20220731163929371](assets/image-20220731163929371.png)





## SpringDataMongoDB连接副本集

副本集语法：

​						地址1,地址2,地址3/操作的数据库				连接方式			

```sh
mongodb://host1,host2,host3/articledb?connect=replicaSet&slaveOk=true&replicaSet=副本集名字

uri: mongodb://192.168.3.110:27017,192.168.3.110:27018,192.168.3.110:27019/articledb?connect=replicaSet&slaveOk=true&replicaSet=myrs
```



其中：

- slaveOk=true：开启副本节点读的功能，可实现读写分离。
- connect=replicaSet：自动到副本集中选择读写的主机。如果slaveOk是打开的，则实现读写分离。

示例：

连接replica set三台服务器（端口27017，27018，27019），直接连接第一个服务器，无论是replica set一部分或者主服务器或者从服务器，写入操作应用在主服务器并且分布查询到从服务器。

修改配置文件application.yml



```yaml
spring: 
	#数据源配置
	data:
		mongodb: 
			#主机地址
			#host: localhost
			#数据库
			#database: test
			#默认端口号是27017
			#port: 27017
			#也可以使用uri连接
			uri: mongodb://localhost:27017,localhost:27018,localhost:27019/test?connect=replicaSet&slaveOk=true&replicaSet=myrs
```



# 分片集群-Sharded Cluster

### 分片概念

分片（sharding）是一种跨多台机器分布数据的方法， MongoDB使用分片来支持具有非常大的数据集 和高吞吐量操作的部署。

换句话说：分片(sharding)是指将数据拆分，将其分散存在不同的机器上的过程。有时也用分区 (partitioning)来表示这个概念。将数据分散到不同的机器上，不需要功能强大的大型计算机就可以储存 更多的数据，处理更多的负载。 

具有大型数据集或高吞吐量应用程序的数据库系统可以会挑战单个服务器的容量。例如，高查询率会耗 尽服务器的CPU容量。工作集大小大于系统的RAM会强调磁盘驱动器的I / O容量。 

有两种解决系统增长的方法：垂直扩展和水平扩展。 

垂直扩展意味着增加单个服务器的容量，例如使用更强大的CPU，添加更多RAM或增加存储空间量。可 用技术的局限性可能会限制单个机器对于给定工作负载而言足够强大。此外，基于云的提供商基于可用 的硬件配置具有硬性上限。结果，垂直缩放有实际的最大值

水平扩展意味着划分系统数据集并加载多个服务器，添加其他服务器以根据需要增加容量。虽然单个机 器的总体速度或容量可能不高，但每台机器处理整个工作负载的子集，可能提供比单个高速大容量服务 器更高的效率。扩展部署容量只需要根据需要添加额外的服务器，这可能比单个机器的高端硬件的总体 成本更低。权衡是基础架构和部署维护的复杂性增加。 

MongoDB支持通过分片进行水平扩展

###  分片集群包含的组件

MongoDB分片群集包含以下组件：

- 分片（存储）：每个分片包含分片数据的子集。 每个分片都可以部署为副本集。 
- mongos（路由）：mongos充当查询路由器，在客户端应用程序和分片集群之间提供接口。 
- config servers（“调度”的配置）：配置服务器存储群集的元数据和配置设置。 从MongoDB 3.4开 始，必须将配置服务器部署为副本集（CSRS）。

![image-20220731204309836](assets/image-20220731204309836.png)

MongoDB在集合级别对数据进行分片，将集合数据分布在集群中的分片上。 



27018 if mongod is a shard member； 

27019 if mongod is a config server member

### 分片集群架构目标

两个分片节点副本集（3+3）+一个配置节点副本集（3）+两个路由节点（2），共11个服务节点。

![image-20220731204356674](assets/image-20220731204356674.png)

### 分片（存储）节点副本集的创建

所有的的配置文件都直接放到 sharded_cluster 的相应的子目录下面，默认配置文件名字： **mongod.conf**

#### 第一套副本集

准备存放数据和日志的目录

```sh
#-----------myshardrs01
mkdir -p /mongodb/sharded_cluster/myshardrs01_27018/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs01_27018/data/db \ &

mkdir -p /mongodb/sharded_cluster/myshardrs01_27118/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs01_27118/data/db \ &

mkdir -p /mongodb/sharded_cluster/myshardrs01_27218/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs01_27218/data/db
```

新建或修改配置文件：

```sh
vim /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf
```

myshardrs01_27018：

```yml
systemLog:
	#MongoDB发送所有日志输出的目标指定为文件
	destination: file
	#mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
	path: "/mongodb/sharded_cluster/myshardrs01_27018/log/mongod.log"
	#当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
	logAppend: true
storage:
	#mongod实例存储其数据的目录。storage.dbPath设置仅适用于mongod。
	dbPath: "/mongodb/sharded_cluster/myshardrs01_27018/data/db"
	journal:
		#启用或禁用持久性日志以确保数据文件保持有效和可恢复。
		enabled: true
processManagement:
	#启用在后台运行mongos或mongod进程的守护进程模式。
	fork: true
	#指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
	pidFilePath: "/mongodb/sharded_cluster/myshardrs01_27018/log/mongod.pid"
net:
	#服务实例绑定所有IP，有副作用，副本集初始化的时候，节点名字会自动设置为本地域名，而不是ip
	#bindIpAll: true
	#服务实例绑定的IP
	bindIp: localhost,192.168.0.2
	#bindIp
	#绑定的端口
	port: 27018
replication:
	#副本集的名称
	replSetName: myshardrs01
sharding:
#分片角色
	clusterRole: shardsvr
```

sharding.clusterRole：

| Value       | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| `configsvr` | Start this instance as a [config server.](https://docs.mongodb.com/manual/reference/glossary/#term-config-server) The instance starts on port 27019 by default. |
| shardsvr    | Start this instance as a [shard](https://docs.mongodb.com/manual/reference/glossary/#term-shard). The instance starts on port 27018 by default |

注意： 

设置sharding.clusterRole需要mongod实例运行复制。 要将实例部署为副本集成员，请使用 replSetName设置并指定副本集的名称。 



新建或修改配置文件：	myshardrs01_27118：

```sh
cp -r /mongodb/sharded_cluster/myshardrs01_27018 /mongodb/sharded_cluster/myshardrs01_27118

cp /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf /mongodb/sharded_cluster/myshardrs01_27118/mongod.conf

vim /mongodb/sharded_cluster/myshardrs01_27118/mongod.conf
:% s/27018/27118/g

```

新建或修改配置文件：	myshardrs01_27218：

```sh
cp -r /mongodb/sharded_cluster/myshardrs01_27018 /mongodb/sharded_cluster/myshardrs01_27218

cp /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf /mongodb/sharded_cluster/myshardrs01_27218/mongod.conf

vim /mongodb/sharded_cluster/myshardrs01_27218/mongod.conf
:% s/27018/27218/g

```

**启动第一套副本集：一主一副本一仲裁**

```sh
./mongod -f /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs01_27118/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs01_27218/mongod.conf

ps -ef |grep mongod
```

####  第二套副本集

```sh
#-----------myshardrs02
mkdir -p /mongodb/sharded_cluster/myshardrs02_27318/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs02_27318/data/db \ &

mkdir -p /mongodb/sharded_cluster/myshardrs02_27418/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs02_27418/data/db \ &

mkdir -p /mongodb/sharded_cluster/myshardrs02_27518/log \ &
mkdir -p /mongodb/sharded_cluster/myshardrs02_27518/data/db
```



新建或修改配置文件：	myshardrs02_27318：

```sh
cp -r /mongodb/sharded_cluster/myshardrs01_27018 /mongodb/sharded_cluster/myshardrs02_27318

cp /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf /mongodb/sharded_cluster/myshardrs02_27318/mongod.conf

vim /mongodb/sharded_cluster/myshardrs02_27318/mongod.conf
:% s/myshardrs01/myshardrs02/g
:% s/27018/27138/g

```

新建或修改配置文件：	myshardrs02_27418：

```sh
cp -r /mongodb/sharded_cluster/myshardrs01_27018 /mongodb/sharded_cluster/myshardrs01_27418

cp /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf /mongodb/sharded_cluster/myshardrs01_27418/mongod.conf

vim /mongodb/sharded_cluster/myshardrs01_27418/mongod.conf
:% s/myshardrs01/myshardrs02/g
:% s/27018/27418/g

```

新建或修改配置文件：	myshardrs02_27518：

```sh
cp -r /mongodb/sharded_cluster/myshardrs01_27018 /mongodb/sharded_cluster/myshardrs01_27518

cp /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf /mongodb/sharded_cluster/myshardrs01_27518/mongod.conf

vim /mongodb/sharded_cluster/myshardrs02_27518/mongod.conf
:% s/myshardrs01/myshardrs02/g
:% s/27018/27518/g

```



**启动第二套副本集：一主一副本一仲裁**

```sh
./mongod -f /mongodb/sharded_cluster/myshardrs02_27318/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs02_27418/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs02_27518/mongod.conf

ps -ef |grep mongod
```

#### 

### 配置节点副本集的创建

第一步：准备存放数据和日志的目录：

```sh
#-----------configrs
#建立数据节点data和日志目录
mkdir -p /mongodb/sharded_cluster/myconfigrs_27019/log \ &
mkdir -p /mongodb/sharded_cluster/myconfigrs_27019/data/db \ &

mkdir -p /mongodb/sharded_cluster/myconfigrs_27119/log \ &
mkdir -p /mongodb/sharded_cluster/myconfigrs_27119/data/db \ &

mkdir -p /mongodb/sharded_cluster/myconfigrs_27219/log \ &
mkdir -p /mongodb/sharded_cluster/myconfigrs_27219/data/db
```



新建或修改配置文件：

```sh
vim /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf
```

myconfigrs_27019：

```yml
systemLog:
    #MongoDB发送所有日志输出的目标指定为文件
    destination: file
    #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
    path: "/mongodb/sharded_cluster/myconfigrs_27019/log/mongod.log"
    #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
    logAppend: true
storage:
    #mongod实例存储其数据的目录。storage.dbPath设置仅适用于mongod。
    dbPath: "/mongodb/sharded_cluster/myconfigrs_27019/data/db"
    journal:
        #启用或禁用持久性日志以确保数据文件保持有效和可恢复。
        enabled: true
processManagement:
    #启用在后台运行mongos或mongod进程的守护进程模式。
    fork: true
    #指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
    pidFilePath: "/mongodb/sharded_cluster/myconfigrs_27019/log/mongod.pid"
net:
    #服务实例绑定所有IP
    #bindIpAll: true
    #服务实例绑定的IP
    bindIp: localhost,192.168.0.2
    #绑定的端口
    port: 27019
replication:
    replSetName: myconfigrs
sharding:
    clusterRole: configsvr
```

新建或修改配置文件：	myconfigrs_27119

```sh
cp /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf /mongodb/sharded_cluster/myconfigrs_27119/mongod.conf

vim /mongodb/sharded_cluster/myconfigrs_27119/mongod.conf
:% s/27019/27119/g
```

新建或修改配置文件：	myconfigrs_27219

```sh
cp /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf /mongodb/sharded_cluster/myconfigrs_27219/mongod.conf

vim /mongodb/sharded_cluster/myconfigrs_27219/mongod.conf
:% s/27019/27219/g
```



**启动配置副本集：一主两副本**

**依次启动三个mongod服务：**

```sh
./mongod -f /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf
./mongod -f /mongodb/sharded_cluster/myconfigrs_27119/mongod.conf
./mongod -f /mongodb/sharded_cluster/myconfigrs_27219/mongod.conf

ps -ef |grep mongod
```



（1）初始化副本集和创建主节点： (两套操作类似)

使用客户端命令连接任意一个节点，但这里尽量要连接主节点：

```sh
/usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27018
```

执行初始化副本集命令：

```sh
rs.initiate()

{
	"info2" : "no configuration specified. Using a default configuration for the set",
	"me" : "192.168.3.110:27018",
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659340898, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1659340898, 1)
}
```

添加副本节点

```sh
rs.add("180.76.159.126:27118")

{
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659341099, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1659341099, 1)
}
```

添加仲裁节点

```sh
rs.addArb("180.76.159.126:27218")

{
	"ok" : 1,
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659341104, 1),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	},
	"operationTime" : Timestamp(1659341104, 1)
}
```



查看副本集情况(节选内容)：

```sh
rs.status()
```

主节点配置查看：

```sh
rs.conf()
```



**初始化配置节点**

```sh
/usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27019

# 初始化副本集
rs.initiate()


```



添加两个副本节点：

```sh
> rs.add("180.76.159.126:27119")
> rs.add("180.76.159.126:27219")
```

移除节点

```sh
rs.remove("180.76.159.126:27219")
```

查看副本集的配置情况：

```sh
rs.conf()
rs.status()
```



### 路由节点的创建和操作

#### 第一个路由节点的创建和连接

第一步：准备存放数据和日志的目录：

因为只是负责路由分发，不会存储数据，所以只需日志目录即可

```sh
#-----------mongos01
mkdir -p /mongodb/sharded_cluster/mymongos_27017/log
```

mymongos_27017节点： 

新建或修改配置文件：

```sh
vim /mongodb/sharded_cluster/mymongos_27017/mongos.conf
```

mongos.conf

```yml
systemLog:
    #MongoDB发送所有日志输出的目标指定为文件
    destination: file
    #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
    path: "/mongodb/sharded_cluster/mymongos_27017/log/mongod.log"
    #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
    logAppend: true
processManagement:
    #启用在后台运行mongos或mongod进程的守护进程模式。
    fork: true
    #指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
    pidFilePath: /mongodb/sharded_cluster/mymongos_27017/log/mongod.pid"
net:
    #服务实例绑定所有IP，有副作用，副本集初始化的时候，节点名字会自动设置为本地域名，而不是ip
    #bindIpAll: true
    #服务实例绑定的IP
    bindIp: localhost,192.168.0.2
    #bindIp
    #绑定的端口
    port: 27017
sharding:
    #指定配置节点副本集
    configDB: myconfigrs/180.76.159.126:27019,180.76.159.126:27119,180.76.159.126:27219
```

启动mongos：

```sh
./mongos -f /mongodb/sharded_cluster/mymongos_27017/mongos.conf
```

提示：启动如果失败，可以查看log目录下的日志，查看失败原因。

客户端登录mongos：

```sh
./mongo --host 180.76.159.126 --port 27017
```

此时，写不进去数据，如果写数据会报错：

```sh
mongos> use aabb
switched to db aabb
mongos> db.aa.insert({aa:"aa"})
WriteCommandError({
	"ok" : 0,
	"errmsg" : "unable to initialize targeter for write op for collection aabb.aa :: caused by :: Database aabb could not be created :: caused by :: No shards found",
	"code" : 70,
	"codeName" : "ShardNotFound",
	"operationTime" : Timestamp(1659343046, 3),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659343046, 3),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
})
```

原因： 

**通过路由节点操作，现在只是连接了配置节点，还没有连接分片数据节点，因此无法写入业务数据。** 



#### 在路由节点上进行分片配置操作

使用命令添加分片：

**（1）添加分片：** 

语法：

```
sh.addShard("IP:Port")
```

将第一套分片副本集添加进来：

```sh
mongos>
sh.addShard("myshardrs01/192.168.0.2:27018,180.76.159.126:27118,180.76.159.126:27218")

{
	"shardAdded" : "myshardrs01",
	"ok" : 1,
	"operationTime" : Timestamp(1564611970, 4),
	"$clusterTime" : {
	"clusterTime" : Timestamp(1564611970, 4),
		"signature" : {
		"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```

查看分片状态情况：

```sh
mongos> sh.status()
--- Sharding Status ---
sharding version: {
	"_id" : 1,
	"minCompatibleVersion" : 5,
	"currentVersion" : 6,
	"clusterId" : ObjectId("5d4211b798f3f9a48522c68b")
}
shards:
	{ "_id" : "myshardrs01", "host" : "myshardrs01/180.76.159.126:27018,180.76.159.126:27118", "state" : 1 }
active mongoses:
	"4.0.10" : 1
autosplit:
	Currently enabled: yes
balancer:
	Currently enabled: yes
	Currently running: no
	Failed balancer rounds in last 5 attempts: 0
	Migration Results for the last 24 hours:
		No recent migrations
databases:
	{ "_id" : "config", "primary" : "config", "partitioned" : true }
```

继续将第二套分片副本集添加进来：

```sh
mongos>
sh.addShard("myshardrs02/192.168.0.2:27318,180.76.159.126:27418,180.76.159.126:27518")

{
	"shardAdded" : "myshardrs02",
	"ok" : 1,
	"operationTime" : Timestamp(1564612147, 5),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1564612147, 5),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```

查看分片状态：

```sh
mongos> sh.status()

--- Sharding Status --- 
  sharding version: {
  	"_id" : 1,
  	"minCompatibleVersion" : 5,
  	"currentVersion" : 6,
  	"clusterId" : ObjectId("62e78cbe358366e539df9cda")
  }
  shards:
        {  "_id" : "myshardrs01",  "host" : "myshardrs01/192.168.3.110:27018,192.168.3.110:27118",  "state" : 1 }
        {  "_id" : "myshardrs02",  "host" : "myshardrs02/192.168.3.110:27318,192.168.3.110:27418",  "state" : 1 }
  active mongoses:
        "4.4.4" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours: 
                No recent migrations
  databases:
        {  "_id" : "articledb",  "primary" : "myshardrs01",  "partitioned" : false,  "version" : {  "uuid" : UUID("cd764291-fe54-410c-b4e2-fb3a84792da1"),  "lastMod" : 1 } }
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
                config.system.sessions
                        shard key: { "_id" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                myshardrs01	1024
                        too many chunks to print, use verbose if you want to force print
```

提示：如果添加分片失败，需要先手动移除分片，检查添加分片的信息的正确性后，再次添加分片。 

**移除分片参考(了解)**：

```sh
use admin
db.runCommand({removeShard:"myshardrs02"})
```

注意：如果只剩下最后一个shard，是无法删除的 

移除时会自动转移分片数据，需要一个时间过程。 

完成后，再次执行删除分片命令才能真正删除。

**（2）开启分片功能**：sh.enableSharding("库名")、sh.shardCollection("库名.集合名",{"key":1})

在mongos上的articledb数据库配置sharding:

```sh
sh.enableSharding("articledb")

{
	"ok" : 1,
	"operationTime" : Timestamp(1659538816, 4),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659538816, 4),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}
```

查看分片状态：

```sh
mongos> sh.status()
--- Sharding Status --- 
  sharding version: {
  	"_id" : 1,
  	"minCompatibleVersion" : 5,
  	"currentVersion" : 6,
  	"clusterId" : ObjectId("62ea8c6737484a4f280c89d2")
  }
  shards:
        {  "_id" : "myshardrs01",  "host" : "myshardrs01/192.168.3.110:27018,192.168.3.110:27118",  "state" : 1 }
        {  "_id" : "myshardrs02",  "host" : "myshardrs02/192.168.3.110:27318,192.168.3.110:27418",  "state" : 1 }
  active mongoses:
        "4.4.4" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours: 
                26 : Success
  databases:
        {  "_id" : "articledb",  "primary" : "myshardrs01",  "partitioned" : true,  "version" : {  "uuid" : UUID("822bd75a-fb0f-4361-9f55-5c2d6301aa39"),  "lastMod" : 1 } }
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
                config.system.sessions
                        shard key: { "_id" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                myshardrs01	998
                                myshardrs02	26
                        too many chunks to print, use verbose if you want to force print
        {  "_id" : "test",  "primary" : "myshardrs01",  "partitioned" : false,  "version" : {  "uuid" : UUID("8d27f497-c7fc-4403-abc3-c69b6df962b5"),  "lastMod" : 1 } }
```

（3）集合分片 

对集合分片，你必须使用 sh.shardCollection() 方法指定集合和分片键。 

语法：

```sh
sh.shardCollection(namespace, key, unique)
```

参数：

| Parameter | Type     | Description                                                  |
| --------- | -------- | ------------------------------------------------------------ |
| namespace | string   | 要（分片）共享的目标集合的命名空间，格式： <database>.<collection> |
| key       | document | 用作分片键的索引规范文档。shard键决定MongoDB如何在 shard之间分发文档。除非集合为空，否则索引必须在shard collection命令之前存在。如果集合为空，则MongoDB在对集合 进行分片之前创建索引，前提是支持分片键的索引不存在。简单 的说：由包含字段和该字段的索引遍历方向的文档组成 |
| unique    | boolean  | 当值为true情况下，片键字段上会限制为确保是唯一索引。哈希 策略片键不支持唯一索引。默认是false。 |

对集合进行分片时,你需要选择一个 片键（Shard Key） , shard key 是每条记录都必须包含的,且建立了 索引的单个字段或复合字段,MongoDB按照片键将数据划分到不同的 数据块 中,并将 数据块 均衡地分布 到所有分片中.为了按照片键划分数据块,MongoDB使用 基于哈希的分片方式（随机平均分配）或者基 于范围的分片方式（数值大小分配） 。 

用什么字段当片键都可以，如：nickname作为片键，但一定是必填字段



##### 分片规则一：哈希策略 

对于基于哈希的分片 ,MongoDB计算一个字段的哈希值,并用这个哈希值来创建数据块. 

在使用基于哈希分片的系统中,拥有”相近”片键的文档 很可能不会 存储在同一个数据块中,因此数据的分 离性更好一些. 

使用nickname作为片键，根据其值的哈希值进行数据分片

```sh
mongos> sh.shardCollection("articledb.comment",{"nickname":"hashed"})

{
	"collectionsharded" : "articledb.comment",
	"collectionUUID" : UUID("ddea6ed8-ee61-4693-bd16-196acc3a45e8"),
	"ok" : 1,
	"operationTime" : Timestamp(1564612840, 28),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1564612840, 28),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}

```

查看分片状态：sh.status()

```sh
--- Sharding Status --- 
  sharding version: {
  	"_id" : 1,
  	"minCompatibleVersion" : 5,
  	"currentVersion" : 6,
  	"clusterId" : ObjectId("62ea8c6737484a4f280c89d2")
  }
  shards:
        {  "_id" : "myshardrs01",  "host" : "myshardrs01/192.168.3.110:27018,192.168.3.110:27118",  "state" : 1 }
        {  "_id" : "myshardrs02",  "host" : "myshardrs02/192.168.3.110:27318,192.168.3.110:27418",  "state" : 1 }
  active mongoses:
        "4.4.4" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours: 
                512 : Success
  databases:
        {  "_id" : "articledb",  "primary" : "myshardrs01",  "partitioned" : true,  "version" : {  "uuid" : UUID("822bd75a-fb0f-4361-9f55-5c2d6301aa39"),  "lastMod" : 1 } }
                articledb.comment
                        shard key: { "nickname" : "hashed" }
                        unique: false
                        balancing: true
                        chunks:
                                myshardrs01	1
                        { "nickname" : { "$minKey" : 1 } } -->> { "nickname" : { "$maxKey" : 1 } } on : myshardrs01 Timestamp(1, 0) 
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
                config.system.sessions
                        shard key: { "_id" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                myshardrs01	512
                                myshardrs02	512
                        too many chunks to print, use verbose if you want to force print
        {  "_id" : "test",  "primary" : "myshardrs01",  "partitioned" : false,  "version" : {  "uuid" : UUID("8d27f497-c7fc-4403-abc3-c69b6df962b5"),  "lastMod" : 1 } }
```

**如果集合分片时报异常：**

**Please create an index that starts with the proposed shard key before sharding the collection**

[参考](https://stackoverflow.com/questions/18575094/cant-shard-a-collection-on-mongodb)

进入指定库，创建指定字段的hashed索引

​	如：db.c2.ensureIndex({LOG_DATE: "hashed"})



##### 分片规则二：范围策略

对于 基于范围的分片 ,MongoDB按照片键的范围把数据分成不同部分.假设有一个数字的片键:想象一个 从负无穷到正无穷的直线,每一个片键的值都在直线上画了一个点.MongoDB把这条直线划分为更短的不 重叠的片段,并称之为 数据块 ,每个数据块包含了片键在一定范围内的数据. 

在使用片键做范围划分的系统中,拥有”相近”片键的文档很可能存储在同一个数据块中,因此也会存储在同 一个分片中. 

如使用作者年龄字段作为片键，按照点赞数的值进行分片：

```sh
mongos> sh.shardCollection("articledb.author",{"age":1})
{
	"collectionsharded" : "articledb.author",
	"collectionUUID" : UUID("2b9a23c0-ebf9-4d29-9fe0-eeb76b49a7aa"),
	"ok" : 1,
	"operationTime" : Timestamp(1659616380, 7),
	"$clusterTime" : {
		"clusterTime" : Timestamp(1659616380, 7),
		"signature" : {
			"hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
			"keyId" : NumberLong(0)
		}
	}
}


```

注意的是： 

1）一个集合只能指定一个片键，否则报错。 

2）一旦对一个集合分片，分片键和分片值就不可改变。 如：不能给集合选择不同的分片键、不能更新 分片键的值。 

3）根据age索引进行分配数据。 



查看分片状态：

```sh
articledb.author
                        shard key: { "age" : 1 }
                        unique: false
                        balancing: true
                        chunks:
                                myshardrs01	1
                        { "age" : { "$minKey" : 1 } } -->> { "age" : { "$maxKey" : 1 } } on : myshardrs01 Timestamp(1, 0)
```

基于范围的分片方式与基于哈希的分片方式性能对比： 

基于范围的分片方式提供了更高效的范围查询,给定一个片键的范围,分发路由可以很简单地确定哪个数 据块存储了请求需要的数据,并将请求转发到相应的分片中. 

不过,基于范围的分片会导致数据在不同分片上的不均衡,有时候,带来的消极作用会大于查询性能的积极 作用.比如,如果片键所在的字段是线性增长的,一定时间内的所有请求都会落到某个固定的数据块中,最终 导致分布在同一个分片中.在这种情况下,一小部分分片承载了集群大部分的数据,系统并不能很好地进行 扩展. 

与此相比,基于哈希的分片方式以范围查询性能的损失为代价,保证了集群中数据的均衡.哈希值的随机性 使数据随机分布在每个数据块中,因此也随机分布在不同分片中.但是也正由于随机性,一个范围查询很难 确定应该请求哪些分片,通常为了返回需要的结果,需要请求所有分片. 

如无特殊情况，一般推荐使用 Hash Sharding。 

而使用 _id 作为片键是一个不错的选择，因为它是必有的，你可以使用数据文档 _id 的哈希作为片键。 

这个方案能够是的读和写都能够平均分布，并且它能够保证每个文档都有不同的片键所以数据块能够很 精细。 

似乎还是不够完美，因为这样的话对多个文档的查询必将命中所有的分片。虽说如此，这也是一种比较 好的方案了。 

理想化的 shard key 可以让 documents 均匀地在集群中分布：

![image-20220731222659653](assets/image-20220731222659653.png)



显示集群的详细信息：

```sh
db.printShardingStatus()
```

查看均衡器是否工作（需要重新均衡时系统才会自动启动，不用管它）：

```sh
mongos> sh.isBalancerRunning()
false
```

查看当前Balancer状态：

```sh
mongos> sh.getBalancerState()
true
```

#### 分片后插入数据测试

测试一（哈希规则）：登录mongs后，向comment循环插入1000条数据做测试：

```sh
# 路由节点操作
mongos> use articledb
switched to db articledb

mongos> for(var i=1;i<=1000;i++) {db.comment.insert({_id:i+"",nickname:"BoBo"+i})}

WriteResult({ "nInserted" : 1 })

mongos> db.comment.count()
1000
```

提示：js的语法，因为mongo的shell是一个JavaScript的shell。 

注意：从路由上插入的数据，必须包含片键，否则无法插入。 



分别登陆两个片的主节点，统计文档数量 

**第一个分片副本集：**

```sh
/usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27018
```

```sh
myshardrs01:PRIMARY> use articledb
switched to db articledb

myshardrs01:PRIMARY> db.comment.count()
508
```

**第二个分片副本集：**

```sh
/usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27318
```

```sh
myshardrs02:PRIMARY> use articledb
switched to db articledb

myshardrs02:PRIMARY> db.comment.count()
493
```

可以看到，1000条数据近似均匀的分布到了2个shard上。是根据片键的哈希值分配的。 

这种分配方式非常易于水平扩展：一旦数据存储需要更大空间，可以直接再增加分片即可，同时提升了 性能。 

使用db.comment.stats()查看单个集合的完整情况，mongos执行该命令可以查看该集合的数据分片的 情况。 

使用sh.status()查看本库内所有集合的分片信息。 



测试二（范围规则）：登录mongs后，向comment循环插入1000条数据做测试：

```sh
mongos> use articledb
switched to db articledb

mongos> for(var i=1;i<=20000;i++)  {db.author.save({"name":"BoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBoBo"+i,"age":NumberInt(i%120)})}

WriteResult({ "nInserted" : 1 })

mongos> db.comment.count()
20000
```

插入成功后，仍然要分别查看两个分片副本集的数据情况。 

分片效果：

```sh
articledb.author
shard key: { "age" : 1 }
unique: false
balancing: true
chunks:
myshardrs01 2
myshardrs02 1
{ "age" : { "$minKey" : 1 } } -->> { "age" : 0 } on :
myshardrs02 Timestamp(2, 0)
{ "age" : 0 } -->> { "age" : 112 } on : myshardrs01
Timestamp(2, 1)
{ "age" : 112 } -->> { "age" : { "$maxKey" : 1 } } on :
myshardrs01 Timestamp(1, 3)
```

提示：

如果查看状态发现没有分片，则可能是由于以下原因造成了： 

1）系统繁忙，正在分片中。 

2）数据块（chunk）没有填满，默认的数据块尺寸（chunksize）是64M，填满后才会考虑向其他片的 数据块填充数据，因此，为了测试，可以将其改小，这里改为1M，操作如下：

```sh
use config
db.settings.save( { _id:"chunksize", value: 1 } )
```

测试完改回来：

```sh
db.settings.save( { _id:"chunksize", value: 64 } )
```

注意：要先改小，再设置分片。为了测试，可以先删除集合，重新建立集合的分片策略，再插入数据测 试即可。

#### 再增加一个路由节点

文件夹：

```sh
#-----------mongos02
mkdir -p /mongodb/sharded_cluster/mymongos_27117/log
```

新建或修改配置文件：

```sh
vi /mongodb/sharded_cluster/mymongos_27117/mongos.conf
```

mongos.conf

```yml
systemLog:
    #MongoDB发送所有日志输出的目标指定为文件
    #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
    path: "/mongodb/sharded_cluster/mymongos_27117/log/mongod.log"
    #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
    logAppend: true
processManagement:
    #启用在后台运行mongos或mongod进程的守护进程模式。
    fork: true
    #指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
    pidFilePath: /mongodb/sharded_cluster/mymongos_27117/log/mongod.pid"
net:
    #服务实例绑定所有IP，有副作用，副本集初始化的时候，节点名字会自动设置为本地域名，而不是ip
    #bindIpAll: true
    #服务实例绑定的IP
    bindIp: localhost,192.168.0.2
    #bindIp
    #绑定的端口
    port: 27117
sharding:
    configDB: myconfigrs/180.76.159.126:27019,180.76.159.126:27119,180.76.159.126:27219
```

启动mongos2：

```sh
[root@bobohost bin]# /usr/local/mongodb/bin/mongos -f
/mongodb/sharded_cluster/mymongos_27117/mongos.conf
about to fork child process, waiting until server is ready for connections.
forked process: 129874
child process started successfully, parent exiting
```

使用mongo客户端登录27117，发现，第二个路由无需配置，因为分片配置都保存到了配置服务器中 了。

### Compass连接分片集群

![image-20220731224626787](assets/image-20220731224626787.png)

![image-20220731224636299](assets/image-20220731224636299.png)

### SpringDataMongDB连接分片集群

Java客户端常用的是SpringDataMongoDB，其连接的是mongs路由，配置和单机mongod的配置是一 样的。 

多个路由的时候的SpringDataMongoDB的客户端配置参考如下

```yml
spring:
#数据源配置
data:
mongodb:
# 主机地址
# host: 180.76.159.126
# 数据库
# database: articledb
# 默认端口是27017
# port: 27017
#也可以使用uri连接
# uri: mongodb://192.168.40.134:28017/articledb
# 连接副本集字符串
# uri:
mongodb://180.76.159.126:27017,180.76.159.126:27018,180.76.159.126:27019/article
db?connect=replicaSet&slaveOk=true&replicaSet=myrs
#连接路由字符串
uri: mongodb://180.76.159.126:27017,180.76.159.126:27117/articledb
```

### 清除所有的节点数据（备用）

如果在搭建分片的时候有操作失败或配置有问题，需要重新来过的，可以进行如下操作： 

第一步：查询出所有的测试服务节点的进程：

```sh
[root@bobohost sharded_cluster]# ps -ef |grep mongo
root 10184 1 0 06:04 ? 00:01:25 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf
root 10219 1 0 06:04 ? 00:01:25 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs01_27118/mongod.conf
root 10253 1 0 06:04 ? 00:00:46 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs01_27218/mongod.conf
root 10312 1 0 06:04 ? 00:01:23 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs02_27318/mongod.conf
root 10346 1 0 06:05 ? 00:01:23 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs02_27418/mongod.conf
root 10380 1 0 06:05 ? 00:00:44 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myshardrs02_27518/mongod.conf
root 10414 1 1 06:05 ? 00:01:36 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf
root 10453 1 1 06:05 ? 00:01:37 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myconfigrs_27119/mongod.conf
root 10492 1 1 06:05 ? 00:01:38 /usr/local/mongodb/bin/mongod
-f /mongodb/sharded_cluster/myconfigrs_27219/mongod.conf
root 11392 1 0 06:15 ? 00:00:24 /usr/local/mongodb/bin/mongos
--config /mongodb/sharded_cluster/mymongos_27017/mongos.cfg
root 14829 1 0 07:15 ? 00:00:13 /usr/local/mongodb/bin/mongos
--config /mongodb/sharded_cluster/mymongos_27117/mongos.cfg

```

根据上述的进程编号，依次中断进程：

```sh
kill -2 进程编号
```



第二步：清除所有的节点的数据：

```sh
rm -rf /mongodb/sharded_cluster/myconfigrs_27019/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myconfigrs_27119/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myconfigrs_27219/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs01_27018/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs01_27118/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs01_27218/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs02_27318/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs02_27418/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/myshardrs02_27518/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/mymongos_27017/data/db/*.* \ &
rm -rf /mongodb/sharded_cluster/mymongos_27117/data/db/*.*
```

第三步：查看或修改有问题的配置 



第四步：依次启动所有节点，不包括路由节点：

```sh
./mongod -f /mongodb/sharded_cluster/myshardrs01_27018/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs01_27118/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs01_27218/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs02_27318/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs02_27418/mongod.conf
./mongod -f /mongodb/sharded_cluster/myshardrs02_2518/mongod.conf

./mongod -f /mongodb/sharded_cluster/myconfigrs_27019/mongod.conf
./mongod -f /mongodb/sharded_cluster/myconfigrs_27119/mongod.conf
./mongod -f /mongodb/sharded_cluster/myconfigrs_27219/mongod.conf
```

第五步：对两个数据分片副本集和一个配置副本集进行初始化和相关配置 



第六步：检查路由mongos的配置，并启动mongos

```sh
./mongod -f /mongodb/sharded_cluster/mymongos_27017/mongos.cfg
```

第七步：mongo登录mongos，在其上进行相关操作。



#  安全认证

## MongoDB的用户和角色权限简介

默认情况下，MongoDB实例启动运行时是没有启用用户访问权限控制的，也就是说，在实例本机服务 器上都可以随意连接到实例进行各种操作，MongoDB不会对连接客户端进行用户验证，这是非常危险 的。 

mongodb官网上说，为了能保障mongodb的安全可以做以下几个步骤： 

1）使用新的端口，默认的27017端口如果一旦知道了ip就能连接上，不太安全。 

2）设置mongodb的网络环境，最好将mongodb部署到公司服务器内网，这样外网是访问不到的。公 司内部访问使用vpn等。 

3）开启安全认证。认证要同时设置服务器之间的内部认证方式，同时要设置客户端连接到集群的账号 密码认证方式。 



为了强制开启用户访问控制(用户验证)，则需要在MongoDB实例启动时使用选项 --auth 或在指定启动 配置文件中添加选项 auth=true 。 

在开始之前需要了解一下概念 

**1）启用访问控制：** 

MongoDB使用的是基于角色的访问控制(Role-Based Access Control,RBAC)来管理用户对实例的访问。 通过对用户授予一个或多个角色来控制用户访问数据库资源的权限和数据库操作的权限，在对用户分配 角色之前，用户无法访问实例。 

在实例启动时添加选项 --auth 或指定启动配置文件中添加选项 auth=true 。

**2）角色：** 

在MongoDB中通过角色对用户授予相应数据库资源的操作权限，每个角色当中的权限可以显式指定， 也可以通过继承其他角色的权限，或者两都都存在的权限。 

**3）权限：** 

权限由指定的数据库资源(resource)以及允许在指定资源上进行的操作(action)组成。 

1. 资源(resource)包括：数据库、集合、部分集合和集群； 

2. 操作(action)包括：对资源进行的增、删、改、查(CRUD)操作。 

   

在角色定义时可以包含一个或多个已存在的角色，新创建的角色会继承包含的角色所有的权限。在同一 个数据库中，新创建角色可以继承其他角色的权限，在 admin 数据库中创建的角色可以继承在其它任意 数据库中角色的权限。 



关于角色权限的查看，可以通过如下命令查询（了解）：

```sh
// 查询所有角色权限(仅用户自定义角色)
> db.runCommand({ rolesInfo: 1 })

// 查询所有角色权限(包含内置角色)
> db.runCommand({ rolesInfo: 1, showBuiltinRoles: true })

// 查询当前数据库中的某角色的权限
> db.runCommand({ rolesInfo: "<rolename>" })

// 查询其它数据库中指定的角色权限
> db.runCommand({ rolesInfo: { role: "<rolename>", db: "<database>" } }

// 查询多个角色权限
> db.runCommand(
{
rolesInfo: [
"<rolename>",
{ role: "<rolename>", db: "<database>" },
...
]
}
)
```

示例： 

查看所有内置角色

```sh
> db.runCommand({ rolesInfo: 1, showBuiltinRoles: true })

{
"roles" : [
{
"role" : "__queryableBackup",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "__system",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "backup",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "clusterAdmin",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "clusterManager",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "clusterMonitor",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "dbAdmin",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "dbAdminAnyDatabase",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "dbOwner",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "enableSharding",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "hostManager",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "read",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "readAnyDatabase",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "readWrite",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "readWriteAnyDatabase",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "restore",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "root",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "userAdmin",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
},
{
"role" : "userAdminAnyDatabase",
"db" : "admin",
"isBuiltin" : true,
"roles" : [ ],
"inheritedRoles" : [ ]
}
],
"ok" : 1
}
```

常用的内置角色： 

- 数据库用户角色：read、readWrite; 
- 所有数据库用户角色：readAnyDatabase、readWriteAnyDatabase、 userAdminAnyDatabase、dbAdminAnyDatabase
- 数据库管理角色：dbAdmin、dbOwner、userAdmin； 
- 集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager； 
- 备份恢复角色：backup、restore； 
- 超级用户角色：
- root 内部角色：system

角色说明：

| 角色                 | 权限描述                                                     |
| -------------------- | ------------------------------------------------------------ |
| read                 | 可以读取指定数据库中任何数据。                               |
| readWrite            | 可以读写指定数据库中任何数据，包括创建、重命名、删除集合。   |
| readAnyDatabase      | 可以读取所有数据库中任何数据(除了数据库config和local之外)。  |
| readWriteAnyDatabase | 可以读写所有数据库中任何数据(除了数据库config和local之外)。  |
| userAdminAnyDatabase | 可以在指定数据库创建和修改用户(除了数据库config和local之外)。 |
| dbAdminAnyDatabase   | 可以读取任何数据库以及对数据库进行清理、修改、压缩、获取统 计信息、执行检查等操作(除了数据库config和local之外)。 |
| dbAdmin              | 可以读取指定数据库以及对数据库进行清理、修改、压缩、获取统 计信息、执行检查等操作。 |
| userAdmin            | 可以在指定数据库创建和修改用户                               |
| clusterAdmin         | 可以对整个集群或数据库系统进行管理操作。                     |
| backup               | 备份MongoDB数据最小的权限。                                  |
| restore              | 从备份文件中还原恢复MongoDB数据(除了system.profile集合)的 权限。 |
| root                 | 超级账号，超级权限                                           |

###  单实例环境

目标：对单实例的MongoDB服务开启安全认证，这里的单实例指的是未开启副本集或分片的MongoDB 实例

#### 关闭已开启的服务（可选）

增加mongod的单实例的安全认证功能，可以在服务搭建的时候直接添加，也可以在之前搭建好的服务 

上添加。 

本文使用之前搭建好的服务，因此，先停止之前的服务 

停止服务的方式有两种：快速关闭和标准关闭，下面依次说明： 

**（1）**快速关闭方法（快速，简单，数据可能会出错） 

目标：通过系统的kill命令直接杀死进程： 

杀完要检查一下，避免有的没有杀掉。

```sh
#通过进程编号关闭节点
kill -2 54410

```

【补充】 

如果一旦是因为数据损坏，则需要进行如下操作（了解）： 

1）删除lock文件：

```sh
rm -f /mongodb/single/data/db/*.lock
```

2）修复数据：

```sh
/usr/local/mongodb/bin/mongod --repair --dbpath=/mongodb/single/data/db
```

**（2）**标准的关闭方法（数据不容易出错，但麻烦）： 

目标：通过mongo客户端中的shutdownServer命令来关闭服务 

主要的操作步骤参考如下

```sh
//客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27017
//#切换到admin库
use admin
//关闭服务
db.shutdownServer()
```

#### 添加用户和权限

（1）先按照普通无授权认证的配置，来配置服务端的配置文件 /mongodb/single/mongod.conf ： （参考，复用之前课程的）

```yml
systemLog:
    #MongoDB发送所有日志输出的目标指定为文件
    destination: file
    #mongod或mongos应向其发送所有诊断日志记录信息的日志文件的路径
    path: "/mongodb/single/log/mongod.log"
    #当mongos或mongod实例重新启动时，mongos或mongod会将新条目附加到现有日志文件的末尾。
    logAppend: true
storage:
    #mongod实例存储其数据的目录。storage.dbPath设置仅适用于mongod。
    dbPath: "/mongodb/single/data/db"
    journal:
    #启用或禁用持久性日志以确保数据文件保持有效和可恢复。
    enabled: true
processManagement:
    #启用在后台运行mongos或mongod进程的守护进程模式。
    fork: true
    #指定用于保存mongos或mongod进程的进程ID的文件位置，其中mongos或mongod将写入其PID
    pidFilePath: "/mongodb/single/log/mongod.pid"
net:
    #服务实例绑定的IP
    bindIp: localhost,192.168.0.2
    #绑定的端口
    port: 27017
```

（2）按之前未开启认证的方式（不添加 --auth 参数）来启动MongoDB服务：

```sh
/usr/local/mongodb/bin/mongod -f /mongodb/single/mongod.conf
```

提示： 

在操作用户时，启动mongod服务时尽量不要开启授权。 

（3）使用Mongo客户端登录：

```sh
/usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27017

```

（4）创建两个管理员用户，一个是系统的超级管理员 `myroot` ，一个是admin库的管理用户 `myadmin` ：

```sh
//切换到admin库
> use admin
//创建系统超级用户 myroot,设置密码123456，设置角色root
//> db.createUser({user:"myroot",pwd:"123456",roles:[{"role": "root", "db": "admin"}]})
//或
> db.createUser({user:"myroot",pwd:"123456",roles:["root"]})
Successfully added user: {"user": "myroot", "roles": [ "root" ] }
//创建专门用来管理admin库的账号myadmin，只用来作为用户权限的管理

> db.createUser({user: "myadmin",pwd: "123456",roles:[{role: "userAdminAnyDatabase", db: "admin"}]})
Successfully added user: {
    "user": "myadmin", 
    "roles": [
        {
            "role": "userAdminAnyDatabase", 
            "db": "admin"
        }
    ]
}

//查看已经创建了的用户的情况：
> db.system.users.find()

[
  {
    _id: 'admin.myroot',
    userId: UUID("b715994c-df18-4cd1-81f0-8033ccffa962"),
    user: 'myroot',
    db: 'admin',
    credentials: {
      'SCRAM-SHA-1': {
        iterationCount: 10000,
        salt: 'LHM8SA8hfFhlhI6UJBaGnw==',
        storedKey: 'YluCPuhhpgmvWWE8YCgn46STwt8=',
        serverKey: 'c4QeOLn/u3JTnlabzkyVYMmX5/s='
      },
      'SCRAM-SHA-256': {
        iterationCount: 15000,
        salt: '1QMi+gVsnxEGsq5Qe2pym5vZqCdc0j8VV9wBBg==',
        storedKey: 'SbqEH3eTynGqFU27z7a9tALr1JcjZTEuE1D/b3F4P+g=',
        serverKey: 'iTtToNvEU7JAeArfYAgnmARzEZ9FY6ehIsQKbbabEcI='
      }
    },
    roles: [ { role: 'root', db: 'admin' } ]
  },
  {
    _id: 'admin.myadmin',
    userId: UUID("6ec70588-8378-4175-b47b-a60af9a46861"),
    user: 'myadmin',
    db: 'admin',
    credentials: {
      'SCRAM-SHA-1': {
        iterationCount: 10000,
        salt: 'DJG1c56ebk6w/hJWMYhVsQ==',
        storedKey: '1wdsP/Aa5pXFz9aD0GQxChHj0ns=',
        serverKey: '5F4M8CjJje5jCvVQ+IV77P2M1ig='
      },
      'SCRAM-SHA-256': {
        iterationCount: 15000,
        salt: 'cBRdWtxHGAVfNsYSVKgrCACwIO65xoxD8aUVTA==',
        storedKey: 'SQUIhw+TSqLY8Nu/sIBcwSQmSG2DPtNXmS/Vna72Z4k=',
        serverKey: 'Zl3XHkM59FgcmSMVwuLAlOtGI8GjDYh71/dLcsu2Apw='
      }
    },
    roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ]
  }
]

//删除用户
> db.dropUser("myadmin")
true
> db.system.users.find()
//修改密码
> db.changeUserPassword("myroot", "123456")

```

提示： 

1）本案例创建了两个用户，分别对应超管和专门用来管理用户的角色，事实上，你只需要一个用户即 可。如果你对安全要求很高，防止超管泄漏，则不要创建超管用户。 

2）和其它数据库（MySQL）一样，权限的管理都差不多一样，也是将用户和权限信息保存到数据库对 应的表中。Mongodb存储所有的用户信息在admin 数据库的集合system.users中，保存用户名、密码 和数据库信息。 

3）如果不指定数据库，则创建的指定的权限的用户在所有的数据库上有效，如 {role: "userAdminAnyDatabase", db:""} 



（5）认证测试 

测试添加的用户是否正确

```sh
（6）创建普通用户
//切换到admin
> use admin

//密码输错
> db.auth("myroot","12345")
MongoServerError: Authentication failed.

//密码正确
> db.auth("myroot","123456")
{ ok: 1 }
```

（6）创建普通用户

创建普通用户可以在没有开启认证的时候添加，也可以在开启认证之后添加，但开启认证之后，必须使 用有操作admin库的用户登录认证后才能操作。底层都是将用户信息保存在了admin数据库的集合 system.users中

```sh
//创建(切换)将来要操作的数据库articledb,
> use articledb
switched to db articledb

//创建用户，拥有articledb数据库的读写权限readWrite，密码是123456
> db.createUser({user: "bobo", pwd: "123456", roles:[{ role: "readWrite", db: "articledb"}]})
//> db.createUser({user: "bobo", pwd: "123456", roles: ["readWrite"]})
Successfully added user: {
    "user": "bobo", 
    "roles": [
        {
            "role": "readWrite", 
            "db": "articledb"
        }
    ]
}

//测试是否可用
> db.auth("bobo","123456")
1
```

提示： 

如果开启了认证后，登录的客户端的用户必须使用admin库的角色，如拥有root角色的myadmin用 户，再通过myadmin用户去创建其他角色的用户

### 服务端开启认证和客户端连接登录

（1）关闭已经启动的服务 

1）使用linux命令杀死进程：

```sh
[root@bobohost single]# ps -ef |grep mongo
root 23482 1 0 08:08 ? 00:00:55 /usr/local/mongodb/bin/mongod
-f /mongodb/single/mongod.conf
[root@bobohost single]# kill -2 23482

```

2）在mongo客户端中使用shutdownServer命令来关闭。

```sh
> db.shutdownServer()
shutdown command only works with the admin database; try 'use admin'
> use admin
switched to db admin
> db.shutdownServer()
2019-08-14T11:20:16.450+0800 E QUERY [js] Error: shutdownServer failed: {
"ok" : 0,
"errmsg" : "shutdown must run from localhost when running db without
auth",
"code" : 13,
"codeName" : "Unauthorized"
} :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
DB.prototype.shutdownServer@src/mongo/shell/db.js:453:1
@(shell):1:1

```

需要几个条件： 

- 必须是在admin库下执行该关闭服务命令。 
- 如果没有开启认证，必须是从localhost登陆的，才能执行关闭服务命令。
-  非localhost的、通过远程登录的，必须有登录且必须登录用户有对admin操作权限才可以。

（2）以开启认证的方式启动服务 

有两种方式开启权限认证启动服务：一种是参数方式，一种是配置文件方式。 

**1）参数方式** 

在启动时指定参数 --auth ，如：

```sh
/usr/local/mongodb/bin/mongod -f /mongodb/single/mongod.conf --auth

```

**2）配置文件方式** 

在mongod.conf配置文件中加入： 

vim /mongodb/single/mongod.conf

```sh
security:
	#开启授权认证
	authorization: enabled

```

启动时可不加 --auth 参数：

```sh
/usr/local/mongodb/bin/mongod -f /mongodb/single/mongod.conf
```

（3）开启了认证的情况下的客户端登录 

有两种认证方式，一种是先登录，在mongo shell中认证；一种是登录时直接认证。 

#### 1）先连接再认证

```sh
[root@bobohost bin]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port
27017
MongoDB shell version v4.0.10
connecting to: mongodb://180.76.159.126:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("53fef661-35d6-4d29-b07c-020291d62e1a")
}
MongoDB server version: 4.0.10
```

提示：

开启认证后再登录，发现打印的日志比较少了。 

相关操作需要认证才可以： 

查询admin库中的system.users集合的用户：

```sh
> use admin
switched to db admin
> db.system.users.find()
Error: error: {
    "ok": 0, 
    "errmsg": "command find requires authentication", 
    "code": 13, 
    "codeName": "Unauthorized"
}

> db.auth("myroot","123456")
1
> db.system.users.find()
```

查询articledb库中的comment集合的内容：

```sh
> use articledb
switched to db articledb
> db.comment.find()
Error: error: {
	"ok" : 0,
	"errmsg" : "not authorized on articledb to execute command { find: \"comment\", filter: {}, lsid: { id: UUID(\"53fef661-35d6-4d29-b07c020291d62e1a\") }, $db: \"articledb\" }",
"	code" : 13,
	"codeName" : "Unauthorized"
}
> db.auth("bobo","123456")
1
> db.comment.find()
Error: error: 
{
    "ok": 0, 
    "errmsg": "too many users are authenticated", 
    "code": 13, 
    "codeName": "Unauthorized"
}

```

提示： 

这里可能出现错误，说是太多的用户正在认证了。因为我们确实连续登录了两个用户了。 

解决方案：退出shell，重新进来登录认证

```sh
> exit
bye
[root@bobohost bin]# ./mongo --host 180.76.159.126 --port 27017
MongoDB shell version v4.0.10
connecting to: mongodb://180.76.159.126:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("329c1897-566d-4231-bcb3-b2acda301863")
}
MongoDB server version: 4.0.10
> db.auth("bobo","123456")
Error: Authentication failed.
0
> use articledb
switched to db articledb
> db.auth("bobo","123456")
1
> db.comment.find()
>
```

#### 2）连接时直接认证 

对admin数据库进行登录认证和相关操作：

```sh
[root@bobohost ~]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27017 --authenticationDatabase admin -u myroot -p 123456

MongoDB shell version v4.0.10
connecting to: mongodb://180.76.159.126:27017/?
authSource=admin&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("f959b8d6-6994-44bc-9d35-09fc7cd00ba6")
}
MongoDB server version: 4.0.10
Server has startup warnings:
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten] ** WARNING: You are
running this process as the root user, which is not recommended.
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten]
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten]
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten] ** WARNING:
/sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten] ** We suggest
setting it to 'never'
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten]
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten] ** WARNING:
/sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten] ** We suggest
setting it to 'never'
2019-09-10T15:23:40.102+0800 I CONTROL [initandlisten]
> show dbs;
admin 0.000GB
articledb 0.000GB
config 0.000GB
local 0.000GB
```

对articledb数据库进行登录认证和相关操作：

```sh
[root@bobohost bin]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port 27017 --authenticationDatabase articledb -u bobo -p 123456

MongoDB shell version v4.0.10
connecting to: mongodb://180.76.159.126:27017/?
authSource=articledb&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("e5d4148f-373b-45b8-9cff-a927ce617100")
}
MongoDB server version: 4.0.10
> use articledb
switched to db articledb
> db.comment.find()
```

提示： 

- -u ：用户名 
- -p ：密码 
- --authenticationDatabase ：指定连接到哪个库。当登录是指定用户名密码时，必须指定对应的 数据库！



###  SpringDataMongoDB连接认证

使用用户名和密码连接到 MongoDB 服务器，你必须使用 

'username:password@hostname/dbname' 格式，'username'为用户名，'password' 为密码。 

目标：使用用户bobo使用密码 123456 连接到MongoDB 服务上。

application.yml：

```yml
spring:
	#数据源配置
	data:
		mongodb:
			# 主机地址
			# host: 180.76.159.126
			# 数据库
			# database: articledb
			# 默认端口是27017
			# port: 27017
			#帐号
			# username: bobo
			#密码
			# password: 123456
			#单机有认证的情况下，也使用字符串连接
			uri: mongodb://bobo:123456@180.76.159.126:27017/articledb
```

提示： 

分别测试用户名密码正确以及不正确的情况。



### 副本集环境

#### 前言

对于搭建好的mongodb副本集，为了安全，启动安全认证，使用账号密码登录。 

副本集环境使用之前搭建好的，架构如下：

![image-20220731231716138](assets/image-20220731231716138.png)

对副本集执行访问控制需要配置两个方面: 

1）副本集和共享集群的各个节点成员之间使用内部身份验证，可以使用密钥文件或x.509证书。密钥文 件比较简单，本文使用密钥文件，官方推荐如果是测试环境可以使用密钥文件，但是正式环境，官方推 荐x.509证书。原理就是，集群中每一个实例彼此连接的时候都检验彼此使用的证书的内容是否相同。 只有证书相同的实例彼此才可以访问 

2）使用客户端连接到mongodb集群时，开启访问授权。对于集群外部的访问。如通过可视化客户端， 或者通过代码连接的时候，需要开启授权。 



在keyfile身份验证中，副本集中的每个mongod实例都使用keyfile的内容作为共享密码，只有具有正确 密钥文件的mongod或者mongos实例可以连接到副本集。密钥文件的内容必须在6到1024个字符之 间，并且在unix/linux系统中文件所有者必须有对文件至少有读的权限。

#### 关闭已开启的副本集服务（可选）

增加副本集的安全认证和服务鉴权功能，可以在副本集搭建的时候直接添加，也可以在之前搭建好的副 本集服务上添加。 

本文使用之前搭建好的副本集服务，因此，先停止之前的集群服务 

停止服务的方式有两种：快速关闭和标准关闭，下面依次说明： 

（1）快速关闭方法（快速，简单，数据可能会出错） 

目标：通过系统的kill命令直接杀死进程： 

依次杀死仲裁者、副本节点、主节点，直到所有成员都离线。建议主节点最后kill，以避免潜在的回滚。 杀完要检查一下，避免有的没有杀掉

```sh
#通过进程编号关闭节点
kill -2 54410

```

【补充】

 如果一旦是因为数据损坏，则需要进行如下操作（了解）： 

1）删除lock文件：

```sh
rm -f /mongodb/replica_sets/myrs_27017/data/db/*.lock \
/mongodb/replica_sets/myrs_27018/data/db/*.lock \
/mongodb/replica_sets/myrs_27019/data/db/mongod.lock \
```

2）依次修复数据：

```sh
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/replica_sets/myrs_27017/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/replica_sets/myrs_27018/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/replica_sets/myrs_27019/data/db
```

（2）标准的关闭方法（数据不容易出错，但麻烦）： 

目标：通过mongo客户端中的shutdownServer命令来依次关闭各个服务 关闭副本集中的服务，建议依次关闭仲裁节点、副本节点、主节点。

主要的操作步骤参考如下：

```sh
//客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27017
//告知副本集说本机要下线
rs.stepDown()
//#切换到admin库
use admin
//关闭服务
db.shutdownServer()
```

#### 通过主节点添加一个管理员帐号

只需要在主节点上添加用户，副本集会自动同步。 

开启认证之前，创建超管用户：myroot，密码：123456

```sh
myrs:PRIMARY> use admin
switched to db admin
myrs:PRIMARY> db.createUser({user:"myroot",pwd:"123456",roles:["root"]})
Successfully added user: { "user" : "myroot", "roles" : [ "root" ] }
```

详细操作详见单实例环境的 添加用户和权限 的相关操作。 

提示： 

该步骤也可以在开启认证之后，但需要通过localhost登录才允许添加用户，用户数据也会自动同步到副 本集。

后续再创建其他用户，都可以使用该超管用户创建

#### 创建副本集认证的key文件

第一步：生成一个key文件到当前文件夹中。 

可以使用任何方法生成密钥文件。例如，以下操作使用openssl生成密码文件，然后使用chmod来更改 文件权限，仅为文件所有者提供读取权限

```sh
[root@bobohost ~]# openssl rand -base64 90 -out ./mongo.keyfile
[root@bobohost ~]# chmod 400 ./mongo.keyfile

[root@bobohost ~]# ll mongo.keyfile
-r--------. 1 root root 122 8月 14 14:23 mongo.keyfile
```

提示： 

所有副本集节点都必须要用同一份keyfile，一般是在一台机器上生成，然后拷贝到其他机器上，且必须 有读的权限，否则将来会报错： permissions on /mongodb/replica_sets/myrs_27017/mongo.keyfile are too open 

一定要保证密钥文件一致，文件位置随便。但是为了方便查找，建议每台机器都放到一个固定的位置， 都放到和配置文件一起的目录中。

这里将该文件分别拷贝到多个目录中：

```sh
[root@bobohost ~]# cp mongo.keyfile /mongodb/replica_sets/myrs_27017
[root@bobohost ~]# cp mongo.keyfile /mongodb/replica_sets/myrs_27018
[root@bobohost ~]# cp mongo.keyfile /mongodb/replica_sets/myrs_27019

```

####  修改配置文件指定keyfile

分别编辑几个服务的mongod.conf文件，添加相关内容：



/mongodb/replica_sets/myrs_27017/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/replica_sets/myrs_27017/mongo.keyfile
	#开启认证方式运行
	authorization: enabled

```

/mongodb/replica_sets/myrs_27018/mongod.conf

```yml
security:
#KeyFile鉴权文件
keyFile: /mongodb/replica_sets/myrs_27018/mongo.keyfile
#开启认证方式运行
authorization: enabled
```

/mongodb/replica_sets/myrs_27019/mongod.conf

```yml
security:
#KeyFile鉴权文件
keyFile: /mongodb/replica_sets/myrs_27019/mongo.keyfile
#开启认证方式运行
authorization: enabled
```

#### 重新启动副本集

如果副本集是开启状态，则先分别关闭关闭复本集中的每个mongod，从次节点开始。直到副本集的所 有成员都离线，包括任何仲裁者。主节点必须是最后一个成员关闭以避免潜在的回滚

```sh
#通过进程编号关闭三个节点
kill -2 54410 54361 54257

```

分别启动副本集节点：

```sh
/usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27017/mongod.conf
/usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27018/mongod.conf
/usr/local/mongodb/bin/mongod -f /mongodb/replica_sets/myrs_27019/mongod.conf
```

查看进程情况：

```sh
[root@bobohost replica_sets]# ps -ef |grep mongod
root 62425 1 5 14:43 ? 00:00:01 /usr/local/mongodb/bin/mongod
-f /mongodb/replica_sets/myrs_27017/mongod.conf
root 62495 1 7 14:43 ? 00:00:01 /usr/local/mongodb/bin/mongod
-f /mongodb/replica_sets/myrs_27018/mongod.conf
root 62567 1 11 14:43 ? 00:00:01 /usr/local/mongodb/bin/mongod
-f /mongodb/replica_sets/myrs_27019/mongod.conf
```

#### 在主节点上添加普通账号

```sh
#先用管理员账号登录
#切换到admin库
use admin
#管理员账号认证
db.auth("myroot","123456")
#切换到要认证的库
use articledb
#添加普通用户
db.createUser({user: "bobo", pwd: "123456", roles: ["readWrite"]})
```

重新连接，使用普通用户bobo重新登录，查看数据。



 注意：也要使用rs.status()命令查看副本集是否健康。

#### SpringDataMongoDB连接副本集

使用用户名和密码连接到 MongoDB 服务器，你必须使用

 'username:password@hostname/dbname' 格式，'username'为用户名，'password' 为密码。 

目标：使用用户bobo使用密码 123456 连接到MongoDB 服务上。

application.yml：

```yml
spring:
	#数据源配置
	data:
	mongodb:
	#副本集有认证的情况下，字符串连接
	uri: mongodb://bobo:123456@180.76.159.126:27017,180.76.159.126:27018,180.76.159.126:27019/articledb?connect=replicaSet&slaveOk=true&replicaSet=myms
```





### 分片集群环境(扩展)

#### 关闭已开启的集群服务（可选）

分片集群环境下的安全认证和副本集环境下基本上一样。 

但分片集群的服务器环境和架构较为复杂，建议在搭建分片集群的时候，直接加入安全认证和服务器间 的鉴权，如果之前有数据，可先将之前的数据备份出来，再还原回去。 

本文使用之前搭建好的集群服务，因此，先停止之前的集群服务 

停止服务的方式有两种：快速关闭和标准关闭，下面依次说明： 

（1）快速关闭方法（快速，简单，数据可能会出错） 

目标：通过系统的kill命令直接杀死进程

依次杀死mongos路由、配置副本集服务，分片副本集服务，从次节点开始。直到所有成员都离线。副 本集杀的时候，建议先杀仲裁者，再杀副本节点，最后是主节点，以避免潜在的回滚。杀完要检查一 下，避免有的没有杀掉

```sh
#通过进程编号关闭节点
kill -2 54410
```

【补充】 

如果一旦是因为数据损坏，则需要进行如下操作（了解）： 

1）删除lock文件：

```sh
rm -f /mongodb/sharded_cluster/myshardrs01_27018/data/db/*.lock \
/mongodb/sharded_cluster/myshardrs01_27118/data/db/*.lock \
/mongodb/sharded_cluster/myshardrs01_27218/data/db/mongod.lock \
/mongodb/sharded_cluster/myshardrs02_27318/data/db/mongod.lock \
/mongodb/sharded_cluster/myshardrs02_27418/data/db/mongod.lock \
/mongodb/sharded_cluster/myshardrs02_27518/data/db/mongod.lock \
/mongodb/sharded_cluster/myconfigrs_27019/data/db/mongod.lock \
/mongodb/sharded_cluster/myconfigrs_27119/data/db/mongod.lock \
/mongodb/sharded_cluster/myconfigrs_27219/data/db/mongod.lock
```

2）依次修复数据：

```sh
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs01_27018/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs01_27118/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs01_27218/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs02_27318/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs02_27418/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myshardrs02_27518/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myconfigrs_27019/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myconfigrs_27119/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/myconfigrs_27219/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/mymongos_27017/data/db
/usr/local/mongodb/bin/mongod --repair --
dbpath=/mongodb/sharded_cluster/mymongos_27117/data/db
```

（2）标准的关闭方法（数据不容易出错，但麻烦）： 

目标：通过mongo客户端中的shutdownServer命令来依次关闭各个服务

关闭分片服务器副本集中的服务，建议依次关闭仲裁节点、副本节点、主节点。主要的操作步骤参考如 下：

```sh
//客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27018
//告知副本集说本机要下线
rs.stepDown()
//#切换到admin库
use admin
//关闭服务
db.shutdownServer()
```

关闭配置服务器副本集的服务，建议依次关闭副本节点、主节点。主要的操作步骤参考如下：

```sh
//客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27019
//告知副本集说本机要下线
rs.stepDown()
//#切换到admin库
use admin
//关闭服务
db.shutdownServer()

```

关闭路由服务器的服务，建议依次关闭两个路由节点。主要的操作步骤参考如下

```sh
//客户端登录服务，注意，这里通过localhost登录，如果需要远程登录，必须先登录认证才行。
mongo --port 27017
//告知副本集说本机要下线
rs.stepDown()
//#切换到admin库
use admin
//关闭服务
db.shutdownServer()
```

####  创建副本集认证的key文件

第一步：生成一个key文件到当前文件夹中。 

可以使用任何方法生成密钥文件。例如，以下操作使用openssl生成密码文件，然后使用chmod来更改 文件权限，仅为文件所有者提供读取权限

```sh
[root@bobohost ~]# openssl rand -base64 90 -out ./mongo.keyfile
[root@bobohost ~]# chmod 400 ./mongo.keyfile
[root@bobohost ~]# ll mongo.keyfile
-r--------. 1 root root 122 8月 14 14:23 mongo.keyfile
```

提示： 

所有副本集节点都必须要用同一份keyfile，一般是在一台机器上生成，然后拷贝到其他机器上，且必须 有读的权限，否则将来会报错： permissions on /mongodb/replica_sets/myrs_27017/mongo.keyfile are too open

一定要保证密钥文件一致，文件位置随便。但是为了方便查找，建议每台机器都放到一个固定的位置， 都放到和配置文件一起的目录中。 

这里将该文件分别拷贝到多个目录中：

```sh
echo '/mongodb/sharded_cluster/myshardrs01_27018/mongo.keyfile
/mongodb/sharded_cluster/myshardrs01_27118/mongo.keyfile
/mongodb/sharded_cluster/myshardrs01_27218/mongo.keyfile
/mongodb/sharded_cluster/myshardrs02_27318/mongo.keyfile
/mongodb/sharded_cluster/myshardrs02_27418/mongo.keyfile
/mongodb/sharded_cluster/myshardrs02_27518/mongo.keyfile
/mongodb/sharded_cluster/myconfigrs_27019/mongo.keyfile
/mongodb/sharded_cluster/myconfigrs_27119/mongo.keyfile
/mongodb/sharded_cluster/myconfigrs_27219/mongo.keyfile
/mongodb/sharded_cluster/mymongos_27017/mongo.keyfile
/mongodb/sharded_cluster/mymongos_27117/mongo.keyfile' | xargs -n 1 cp -v
/root/mongo.keyfile
```

####  修改配置文件指定keyfile

分别编辑几个服务的mongod.conf文件，添加相关内容： 



/mongodb/sharded_cluster/myshardrs01_27018/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs01_27018/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```



/mongodb/sharded_cluster/myshardrs01_27118/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs01_27118/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```

/mongodb/sharded_cluster/myshardrs01_27218/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs01_27218/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```



/mongodb/sharded_cluster/myshardrs02_27318/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs02_27318/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```

/mongodb/sharded_cluster/myshardrs02_27418/mongod.conf

```sh
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs02_27418/mongo.keyfile
	#开启认证方式运行
	authorization: enabled

```

/mongodb/sharded_cluster/myshardrs02_27518/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myshardrs02_27518/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```

/mongodb/sharded_cluster/myconfigrs_27019/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myconfigrs_27019/mongo.keyfile
	#开启认证方式运行
	authorization: enabled

```

/mongodb/sharded_cluster/myconfigrs_27119/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myconfigrs_27119/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```

/mongodb/sharded_cluster/myconfigrs_27219/mongod.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/myconfigrs_27219/mongo.keyfile
	#开启认证方式运行
	authorization: enabled
```

/mongodb/sharded_cluster/mymongos_27017/mongos.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/mymongos_27017/mongo.keyfile
```

/mongodb/sharded_cluster/mymongos_27117/mongos.conf

```yml
security:
	#KeyFile鉴权文件
	keyFile: /mongodb/sharded_cluster/mymongos_27117/mongo.keyfile
```

mongos比mongod少了authorization：enabled的配置。原因是，副本集加分片的安全认证需要配置 两方面的，副本集各个节点之间使用内部身份验证，用于内部各个mongo实例的通信，只有相同keyfile 才能相互访问。所以都要开启 keyFile: /mongodb/sharded_cluster/mymongos_27117/mongo.keyfile 。 

然而对于所有的mongod，才是真正的保存数据的分片。mongos只做路由，不保存数据。所以所有的 mongod开启访问数据的授权authorization:enabled。这样用户只有账号密码正确才能访问到数据。

#### 重新启动节点

必须依次启动配置节点、分片节点、路由节点：

```sh
/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myconfigrs_27019/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myconfigrs_27119/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myconfigrs_27219/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs01_27018/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs01_27118/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs01_27218/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs02_27318/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs02_27418/mongod.conf

/usr/local/mongodb/bin/mongod -f
/mongodb/sharded_cluster/myshardrs02_27518/mongod.conf

/usr/local/mongodb/bin/mongos -f
/mongodb/sharded_cluster/mymongos_27017/mongos.conf

/usr/local/mongodb/bin/mongos -f
/mongodb/sharded_cluster/mymongos_27117/mongos.conf
```

注意： 

这里有个非常特别的情况，就是启动顺序。先启动配置节点，再启动分片节点，最后启动路由节点。 

如果先启动分片节点，会卡住，提示：

```sh
about to fork child process, waiting until server is ready for connections

```

这也许是个bug。原因未知。

#### 5 创建帐号和认证

客户端mongo，通过localhost登录任意一个mongos路由，

```sh
[root@bobohost db]# /usr/local/mongodb/bin/mongo --port 27017

```

提示：相当于一个后门，只能在admin下添加用户。 

创建一个管理员帐号：

```yml
mongos> use admin
switched to db admin
mongos> db.createUser({user:"myroot",pwd:"123456",roles:["root"]})
Successfully added user: { "user" : "myroot", "roles" : [ "root" ] }
```

提示：如果在开启认证之前已经创建了管理员账号，这里可以忽略 



创建一个普通权限帐号：

```yml
mongos> use admin
switched to db admin
mongos> db.auth("myroot","123456")
1
mongos> use articledb
switched to db articledb
mongos> db.createUser({user: "bobo", pwd: "123456", roles: [{ role: "readWrite",
db: "articledb" }]})
Successfully added user: {
"user" : "bobo",
"roles" : [
{
"role" : "readWrite",
"db" : "articledb"
}
]
}
mongos> db.auth("bobo","123456")
1
```

提示：

 通过mongos添加的账号信息，只会保存到配置节点的服务中，具体的数据节点不保存账号信息，因 此，分片中的账号信息不涉及到同步问题。 



mongo客户端登录mongos路由，用管理员帐号登录可查看分片情况：

```sh
mongos> use admin
switched to db admin
mongos> db.auth("myroot","123456")
1
mongos> sh.status()
```

退出连接，重新连接服务，使用普通权限帐号访问数据：

```sh
[root@bobohost db]# /usr/local/mongodb/bin/mongo --host 180.76.159.126 --port
27017
MongoDB shell version v4.0.10
connecting to: mongodb://180.76.159.126:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("6f84fa91-2414-407e-b3ab-c0b7eedde825")
}
MongoDB server version: 4.0.10
mongos> use articledb
switched to db articledb
mongos> db.auth("bobo","123456")
1
mongos> show collections
comment
comment2
mongos> db.comment.count()
10001

```

#### SpringDataMongoDB连接认证

使用用户名和密码连接到 MongoDB 服务器，你必须使用

 'username:password@hostname/dbname' 格式，'username'为用户名，'password' 为密码。 

目标：使用用户bobo使用密码 123456 连接到MongoDB 服务上。

application.yml：

```yml
spring:
	#数据源配置
	data:
		mongodb:
		# 分片集群有认证的情况下，字符串连接
		uri: mongodb://bobo:123456@180.76.159.126:27017,180.76.159.126:27117/articledb
```

