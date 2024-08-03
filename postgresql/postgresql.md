# 基本教程

https://www.sjkjc.com/postgresql/explain/



## 查看版本

```sql
SELECT version();

SHOW server_version;
```



# 目录结构

https://blog.csdn.net/sinat_36528886/article/details/135028706

https://blog.csdn.net/weixin_48154829/article/details/134382728

## 安装目录

```
/bin： 该目录通常包含PostgreSQL的可执行文件，如psql（PostgreSQL命令行客户端）和其他实用程序。
	clusterdb：聚簇一个PostgreSQL数据库           
	createdb：创建一个新的PostgreSQL数据库
	createuser：定义一个新的PostgreSQL用户账户
	dropdb：移除一个PostgreSQL数据库
	dropuser：移除一个PostgreSQL用户账户
	ecpg：嵌入式 SQL C 预处理器
	initdb：创建一个新的 PostgreSQL 数据库
	pg_amcheck：在一个或多个PostgreSQL数据库中检查损坏
	pg_archivecleanup： 清理PostgreSQL WAL归档文件
	pg_basebackup：获得一个PostgreSQL集簇的一个基础备份
	pgbench：在PostgreSQL上运行一个基准测试
	pg_checksums
	pg_config：获取已安装的PostgreSQL的信息
	pg_controldata：显示 PostgreSQL 数据库簇控制信息.
	pg_ctl    
	pg_dump：把PostgreSQL数据库抽取为一个脚本文件或其他归档文件
	pg_dumpall:将一个PostgreSQL数据库集簇抽取到一个脚本文件中
	pg_isready:检查一个PostgreSQL服务器的连接状态
	pg_receivewal：以流的方式从一个PostgreSQL服务器得到预写式日志    
	pg_recvlogical：控制 PostgreSQL 逻辑解码流
	pg_resetwal：重置 PostgreSQL 数据库集群的预写日志和其他控制信息
	pg_restore：从一个由pg_dump创建的归档文件恢复一个PostgreSQL数据库
    pg_rewind：
	pg_test_fsync：PostgreSQL判断最快的 wal_sync_method
	pg_test_timing：测量定时开销
	pg_upgrade：升级服务器实例
	pg_verifybackup：验证PostgreSQL集群的基础备份的完整性    
	postgres  
	psql：PostgreSQL的交互式终端
	reindexdb：重索引一个PostgreSQL数据库
	vacuumdb：vacuumdb — 对一个PostgreSQL数据库进行垃圾收集和分析

/data： 这是PostgreSQL存储其数据文件的常见目录，包括主数据库集群。数据目录在PostgreSQL安装过程中指定，并包含诸如base等子目录，其中存储实际的表数据。

/lib： 该目录通常包含PostgreSQL所需的共享库。

/share： 该目录可能包含PostgreSQL使用的与架构无关的文件，例如错误消息、时区信息和其他共享资源。（插件及配置）
	extension存放插件目录

/doc： PostgreSQL的文档文件可能存放在这里。

/include： 编译与PostgreSQL交互的程序所需的头文件
```



## 数据文件目录

```
base/：存储每个数据库的基本数据文件
存储每个数据库的基本数据文件。每个数据库都有一个以其 OID（对象标识符）命名的子目录，里面包含了该数据库的所有表和索引的数据文件。

global/：包含了全局性质的系统表空间文件
包含了全局性质的系统表空间文件。这里存放了所有数据库共享的系统表，如 pg_database、pg_authid 等。

pg_tblspc/：包含了表空间的符号链接
包含了表空间的符号链接。每个符号链接指向实际的表空间目录，表空间是用于组织数据库物理存储的一种方式。

pg_twophase/：包含了两阶段提交中使用的文件
包含了两阶段提交中使用的文件。两阶段提交用于确保分布式事务的一致性。

pg_stat_tmp/：包含了一些临时文件，用于存储统计信息

pg_stat/：包含了 PostgreSQL 收集的统计信息文件
包含了 PostgreSQL 收集的统计信息文件。这些文件记录了数据库服务器运行时的性能统计信息，如查询计划、锁等。

pg_logical/：包含了用于逻辑复制的文件
包含了用于逻辑复制的文件。逻辑复制允许将特定表、特定数据库对象或特定的数据更改复制到另一个数据库。

pg_replslot/：包含了复制插槽信息的文件
包含了复制插槽信息的文件。复制插槽用于流复制中，确保备用节点能够持续接收主节点的 WAL（Write-Ahead Logging）。

pg_subtrans/：包含了用于存储子事务信息的文件
包含了用于存储子事务信息的文件。子事务用于处理并发事务中的多个子操作。

pg_notify/：包含了用于存储异步通知信息的文件。
包含了用于存储异步通知信息的文件。异步通知允许数据库中的一个会话通知其他会话有关特定事件的发生。

pg_snapshots/：包含了用于存储快照信息的文件。
包含了用于存储快照信息的文件。快照是一种数据库的一致性视图，用于支持可重复读事务隔离级别。

pg_serial/：包含了用于存储序列信息的文件
包含了用于存储序列信息的文件。序列是 PostgreSQL 中生成唯一标识符的一种方式。
```



一些重要的配置文件

```
postgresql.conf：存放着 PostgreSQL 服务器的配置参数，如端口号、日志设置等。

pg_hba.conf：存放着 PostgreSQL 的身份验证规则，定义了哪些主机和用户能够连接到数据库，以及使用哪种身份验证方法。

pg_ident.conf：存放着标识映射规则，用于将操作系统用户映射到 PostgreSQL 数据库用户。
```



# 数据类型

```
Primitives:Integer, Numeric,Boolean
基本：整数、数值、布尔值

Structured: Date/Time, Array, Range / Multirange, UUID
结构：日期/时间、数组、范围/多范围、UUID

Document:JSON/JSONB, XML, Key-value (Hstore)
文档：JSON/JSONB、XML、键值 （Hstore）

Geometry:Point, Line, Circle, Polygon
几何图形：点、线、圆、多边形

Customizations:Composite, Custom Types
自定义：复合、自定义类型
```

## 数字类型

```
smallint: 2 字节，范围：-32768 到 32767，默认值：0
	123
	
integer: 4 字节，范围：-2147483648 到 2147483647，默认值：0
	456789
	
bigint: 8 字节，范围：-9223372036854775808 到 9223372036854775807，默认值：0
	123456789012
	
decimal(p,s): 变长，精度 p，规模 s，默认值：0
	12.34 (p=5, s=2)
	
numeric(p,s): 变长，精度 p，规模 s，默认值：0
	12.34 (p=5, s=2)
	
real: 4 字节，范围：1.17549435e-38 到 3.40282347e+38，默认值：0
	3.14159
	
double precision: 8 字节，范围：4.9e-324 到 1.8e+308，默认值：0
	3.14159265359
```

## 字符类型

```
char(n): 固定长度，n 字节，默认值：''（空字符串）
varchar(n): 变长，最大 n 字节，默认值：''（空字符串）；默认长度255
text: 变长，默认值：''（空字符串）
```

## 日期和时间类型

```
date: 4 字节，范围：4713 BCE 到 5874897 CE，默认值：当前日期
	2022-07-25

time: 4 字节，范围：00:00:00 到 23:59:59，默认值：当前时间
	14:30:00

timestamp: 8 字节，范围：4713 BCE 到 5874897 CE，默认值：当前时间戳
	2022-07-25 14:30:00

timestamptz: 8 字节，范围：4713 BCE 到 5874897 CE，默认值：当前时间戳带时区
	2022-07-25 14:30:00+08

interval: 12 字节，范围：-178000000 年到 178000000 年，默认值：0
	1 year 2 months 3 days 4 hours 5 minutes 6 seconds
```

1. **timestamp**:
   - 存储的日期时间数据是不带时区信息的，也就是说它存储的是一个特定的日期和时间，但不指定具体的时区信息。
   - 例如，`'2024-07-17 12:00:00'` 是一个 `timestamp` 类型的数据，表示的是无论在哪个时区，都是这个具体的日期和时间。
2. **timestamptz**:
   - 存储的日期时间数据包含了时区信息，即带有时区的时间戳。
   - 例如，`'2024-07-17 12:00:00+00'` 是一个 `timestamptz` 类型的数据，表示的是在 UTC（协调世界时）时区下的特定日期和时间。这个时间戳会自动转换成其他时区的时间，以确保时间在不同时区下的一致性。

主要区别在于 `timestamptz` 会将存储的时间戳转换成 UTC 时间存储，并在需要时自动转换回所需的时区，而 `timestamp` 则仅存储时间而不考虑时区。





## 布尔类型

```
boolean: 1 字节，true 或 false，默认值：false
```

## 数组类型

```
array: 变长，默认值：空数组
	{1, 2, 3, 4, 5}
```

## JSON 类型

```
json: 变长，默认值：空 JSON 对象
	{"name": "John", "age": 30}

jsonb: 变长，默认值：空 JSON 对象
	{"name": "John", "age": 30}
```

**JSON**

`JSON` 数据类型是在 PostgreSQL 9.2 中引入的。它将 JSON 数据存储为字符串，并提供了一组函数来操作和查询 JSON 数据。

以下是 `JSON` 数据类型的一些特征：

- 将 JSON 数据存储为字符串
- 不支持索引
- 不支持二进制存储
- 支持有限的一组函数来操作和查询 JSON 数据

**JSONB**

`JSONB` 数据类型是在 PostgreSQL 9.4 中引入的。它将 JSON 数据存储在二进制格式中，从而允许更高效的存储和查询。

以下是 `JSONB` 数据类型的一些特征：

- 将 JSON 数据存储在二进制格式中
- 支持索引，从而允许更快的查询
- 支持二进制存储，从而减少存储开销
- 支持更丰富的一组函数来操作和查询 JSON 数据

**关键差异**

- **存储格式**：`JSON` 将 JSON 数据存储为字符串，而 `JSONB` 将其存储在二进制格式中。
- **索引**：`JSONB` 支持索引，从而允许更快的查询，而 `JSON` 不支持。
- **二进制存储**：`JSONB` 支持二进制存储，从而减少存储开销，而 `JSON` 不支持。
- **功能**：`JSONB` 支持更丰富的一组函数来操作和查询 JSON 数据，包括对 JSON 路径查询的支持

**场景**

- 使用 `JSON` 时：
  需要存储少量的 JSON 数据。
  不需要对 JSON 数据进行复杂的查询。
  正在使用较旧版本的 PostgreSQL，不支持 `JSONB`。
- 使用 `JSONB` 时：
  需要存储大量的 JSON 数据。
  需要对 JSON 数据进行复杂的查询。
  想利用索引和二进制存储。



## 其他类型

```
bytea: 变长，默认值：空字节数组
	\x01\x02\x03\x04\x05

uuid: 16 字节，默认值：随机 UUID；使用gen_random_uuid()生成
	12345678-1234-1234-1234-123456789012

xml: 变长，默认值：空 XML 文档
	<person><name>John</name><age>30</age></person>
	
point: 16 字节，默认值：(0,0)
	(1, 2)

line: 32 字节，默认值：((0,0),(0,0))
	((1, 2), (3, 4))

lseg: 32 字节，默认值：((0,0),(0,0))
	((1, 2), (3, 4))

box: 32 字节，默认值：((0,0),(0,0))
	((1, 2), (3, 4))

circle: 24 字节，默认值：((0,0),0)
	((1, 2), 3)

polygon: 变长，默认值：空多边形
	((1, 2), (3, 4), (5, 6), (7, 8))
```





# 约束

```
UNIQUE, NOT NULL 唯一，非空
Primary Keys 主键
Foreign Keys 外键
Exclusion Constraints 排除约束
Explicit Locks, Advisory Locks
显式锁、咨询锁
```



# 连接 PostgreSQL

```sql
psql -h host -p port -d dbname -U  user -W

-h host: 指定数据库服务器的主机名或IP地址。
-p port: 指定连接数据库服务器的端口号。
-d dbname: 指定要连接的数据库名。
-U user: 指定连接数据库所使用的用户名。
-W: 提示输入密码进行连接。

# 简化
psql -d dbname -U  user -W
```



# 身份认证

## 角色

​	PostgreSQL 使用角色的概念管理数据库访问权限。角色是一系列相关权限的集合。为了管理方便，通常把一系列相关的数据库权限赋给一个角色，如果哪个用户需要这些权限，就把角色赋给相应的用户。由于用户也拥有一系列的相关权限，为了简化管理，在 PostgreSQL 中，角色与用户是没有区别的，一个用户也是一个角色，我们可以把一个用户的权限赋给另一个用户

​	用户和角色在整个数据库实例中是全局的，在同一个实例中的不同数据库中，看到的用户都是相同的。在初始化数据库系统时有一个预定义的超级用户，这个用户的名称与初始化该数据库的操作系统用户名相同。如果数据库是建在操作系统用户“postgres”（通常我们把数据库安装在此用户下）下的，那么这个数据库超级用户的名称也叫“postgres”。可以用这个超级用户连接数据库，然后创建出更多的普通用户或其他超级用户。
  在 SQL 标准中，用户和角色之间的区别很清楚，并且用户不会自动继承权限而角色会继承。这种行为在 PostgreSQL 中也可以实现：为要用作 SQL 角色的角色给予 INHERIT 属性，而为要用作 SQL 用户的角色给予 NOINHERIT 属性。不过，为了向后兼容 8.1 以前的发布（在其中用户总是拥有它们所在组的权限），PostgreSQL 默认给所有的角色 INHERIT 属性

### PUBLIC 角色

​	PUBLIC 是 PostgreSQL 数据库中一个特殊的角色组，在元数据表（pg_roles）中都查不到该角色，数据库中所创建的角色都可以理解为是 PUBLIC 角色组成员。而且对 PUBLIC 权限的继承完全不受 NOINHERIT 的控制，一旦创建了一个拥有 login 权限的角色，它会立即继承 PUBLIC 角色组拥有的权限，此时如果想通过 revoke（比如 revoke connect on database）来回收的话不会成功，只能从 PUBLIC 组回收相关权限（比如 revoke connect on database from PUBLIC）

**PUBLIC 默认权限**

- 数据库的 connect，temp/temprary 权限。任何新建的数据库，系统会自动为 PUBLIC 角色赋予connect 和在任何 schema 下创建临时表的权限
- public 模式的 usage，create 权限。在任何新建的数据库的 public 模式下有 usage 和 create 的权限
- 函数的 execute 权限（仅限于 public 模式下）
- 语言和数据类型（包括域）的 usage 权限



### 查看角色权限

```sql
SELECT * FROM pg_roles WHERE rolname = 'rolename';

\dp rolename：显示指定角色的权限，例如 \dp myrole
\z tablename：显示指定表的权限，例如 \z mytable
```



### 列出所有角色

```sql
SELECT rolname FROM pg_roles;
```

### 创建角色

```sql
CREATE ROLE role_name;
```

### 重命名角色

```sql
ALTER ROLE rolename RENAME TO newrolename;
```

### 删除角色

```sql
DROP ROLE role_name;
```

### 创建新的角色并设置密码

```sql
CREATE ROLE rolename WITH PASSWORD 'password';
```

### 创建新的角色并赋予创建数据库的权限

```sql
CREATE ROLE rolename WITH CREATEDB;
```

### 创建新的角色并赋予创建角色权限

```sql
CREATE ROLE rolename WITH CREATEROLE;
```

### 创建新的角色并赋予超级用户权限

```sql
CREATE ROLE rolename WITH SUPERUSER;
```

### 修改角色密码

```sql
ALTER ROLE rolename WITH PASSWORD 'newpassword';
```

### 赋予角色创建数据库的权限

```sql
ALTER ROLE rolename WITH CREATEDB;
```

### 赋予角色创建角色权限

```sql
ALTER ROLE rolename WITH CREATEROLE;
```

### 赋予角色超级用户权限

```sql
ALTER ROLE rolename WITH SUPERUSER;
```

### 赋予角色登录权限

```sql
GRANT LOGIN ON database_name TO role_name;
```





### 授权权限

```sql
GRANT ALL PRIVILEGES ON database_name TO role_name;
```





## 用户

### 角色与用户绑定

PostgreSQL 可以把用户分组在一起，权限可以被授予一整个组或从一整个组回收。一旦组角色存在，可以使用 GRANT 和 REVOKE 命令增加和移除成员

- 一个用户可以是多个组的成员。
- 不允许环状的成员关系。
- 不允许把一个用户授予给 PUBLIC

```sql
GRANT group_role TO role1, ... ;
REVOKE group_role FROM role1, ... ;
```



### 查看用户权限

```sql
SELECT * FROM pg_user WHERE usename = 'username';

\l+：显示当前数据库中的所有用户和他们的权限。
\du username：显示指定用户的权限，例如 \du myuser
```



### 添加用户

```sql
create user iuser with password '123123';
```

### 创建新的用户并赋予创建数据库的权限

```sql
CREATE USER username WITH CREATEDB;
```

### 创建新的用户并赋予创建角色权限

```sql
CREATE USER username WITH CREATEROLE;
```

### 创建新的用户并赋予超级用户权限

```sql
CREATE USER username WITH SUPERUSER;
```



### 赋予用户创建数据库的权限

```sql
ALTER USER username WITH CREATEDB;
```

### 赋予用户创建角色权限

```sql
ALTER USER username WITH CREATEROLE;
```

### 赋予用户超级用户权限

```sql
ALTER USER username WITH SUPERUSER;
```



### 指定用户创建数据库

```sql
create database work_base owner iuser;
```

### 登录work_base数据库

```sql
psql -U postgres -d work_base -p 5432
```

### 授权

```sql
# 授予用户 iuser 在数据库 work_base 中的所有权限，包括创建、删除、修改数据库对象的权限
grant all privileges on database work_base to iuser;

# 授予用户 iuser 在公共模式 (public schema) 中的使用权限，允许用户访问公共模式中的对象
grant usage on schema public to iuser;
 
# 授予用户 iuser 在公共模式 (public schema) 中的所有表上的所有权限，包括 select、insert、update、delete 等权限
grant all privileges on all tables in schema public to iuser;

# 授予用户 iuser 在公共模式 (public schema) 中的所有序列 (sequence) 上的所有权限，包括使用、修改序列的权限
grant all privileges on all sequences in schema public to iuser;

# 授予用户 iuser 在公共模式 (public schema) 中的所有表上的 select、insert、update、delete 权限
grant select,insert,update,delete on all tables in schema public to iuser;

# 授予用户 iuser 在公共模式 (public schema) 中的所有权限，包括创建、删除、修改模式中的对象，使用、修改序列，使用、修改表等权限
grant all on schema public to iuser;
```



PostgreSQL在表级别提供了各种DDL和DML权限：

- SELECT：允许从表中提取数据。
- INSERT：允许向表中添加新行。
- UPDATE：修改表中的现有行。
- DELETE：授予从表中删除行的功能。
- REFERENCES：允许创建外键约束。
- TRIGGER：允许在表上创建触发器。
- TRUNCATE：允许在表上使用TRUNCATE

**授权表**

```sql
# 授予INSERT和UPDATE权限：
Grant insert,update on table tablename to testuser;

# 授予单个表上的所有权限：
Grant all on table tablename to testuser;

授予schema中所有表的所有权限：
Grant all on all tables in schema schemaname to testuser;

```



### 修改用户名

```sql
ALTER USER username RENAME TO newusername;
```



### 修改用户密码

```sql
# ALTER USER username WITH PASSWORD 'new_password';

ALTER USER iuser WITH PASSWORD 'new_password';

# 想使用当前会话的用户名来修改密码
ALTER USER CURRENT_USER WITH PASSWORD 'new_password';

# 也可以使用 psql 命令行工具来修改用户密码
psql -U postgres -c "ALTER USER iuser WITH PASSWORD 'new_password';"
```



### 重置密码

- 找到 PostgreSQL 数据库服务器的配置文件 `pg_hba.conf`

  - Windows：ostgreSQL 安装目录的 `data` 目录下，比如： `C:\Program Files\PostgreSQL\14\data`
  - Linux 上， PostgreSQL 数据库服务器的配置文件位于：/etc/postgresql/14/main/pg_hba.conf

- 修改配置文件之前备份 配置文件，以便进行恢复

  - ```sh
    cp pg_hba.conf pg_hba.conf.bak
    ```

-  将配置文件中的 `scram-sha-256` 或者 `md5` 修改为 `trust`

- ```
  local   all             all                                     peer
  # IPv4 local connections:
  host    all             all             127.0.0.1/32            trust
  # IPv6 local connections:
  host    all             all             ::1/128                 trust
  # Allow replication connections from localhost, by a user with the
  # replication privilege.
  local   replication     all                                     peer
  host    replication     all             127.0.0.1/32            trust
  host    replication     all             ::1/128                 trust
  
  ```

- 重启 PostgreSQL 数据库服务器

  - Windows 中， 可以在服务列表窗口重启 PostgreSQL
  - Linux 中，可以使用 `systemctl restart postgresql` 重启 PostgreSQL

- 登录PostgreSQL

  - ```sql
    psql -U postgres
    ```

- 使用命令修改 `postgres` 用户的密码、

  - ```sql
    ALTER USER postgres WITH PASSWORD 'new_password';
    ```

- 恢复 `pg_hba.conf` 配置文件。 将 `pg_hba.conf.bak` 文件的内容覆盖 `pg_hba.conf`

- 重启 PostgreSQL 数据库服务器。 当登陆时， PostgreSQL 应该会提示输入密码





## 指定IP登录

### 使用 `pg_hba.conf` 文件

`pg_hba.conf` 文件是 PostgreSQL 认证的主要配置文件。可以添加一行到这个文件以限制访问特定 IP 地址或 IP 地址范围。

例如，要允许用户 `myuser` 只从 IP 地址 `192.168.1.100` 登录

```sql
host  mydatabase  myuser  192.168.1.100/32  md5
```

允许用户 `myuser` 只从 localhost 登录

```sql
host  mydatabase  myuser  127.0.0.1/32  md5
```

### 使用SQL命令

允许用户 `myuser` 只从 IP 地址 `192.168.1.100` 登录

```sql
ALTER USER myuser SET CONNECTION LIMIT ADDR '192.168.1.100/32';
```

允许用户 `myuser` 只从 localhost 登录

```sql
ALTER USER myuser SET CONNECTION LIMIT ADDR '127.0.0.1/32';
```

### 使用 `pg_ctl` 命令

允许用户 `myuser` 只从 IP 地址 `192.168.1.100` 登录

 `/32` 是一种指定单个、精确 IP 地址的方式，而不是一个 IP 地址范围

不使用 `/32` 将使 PostgreSQL 允许来自一个更大的 IP 地址范围的连接，而不是单个主机

```sql
pg_ctl -D /path/to/data/directory add-allowed-hosts "myuser 192.168.1.100/32"
```

允许用户 `myuser` 只从 localhost 登录

```sql
pg_ctl -D /path/to/data/directory add-allowed-hosts "myuser 127.0.0.1/32"
```





# psql 下常用命令

## <span id="selectDatabase">列出所有库</span>

```sql
# 要列出当前 PostgreSQL 数据库服务器中的所有数据库
\l
\l+

# 以从 pg_database 表中查询所有的数据库；pg_database 表是 PostgreSQL 内置的一个表，它存储了所有的数据库
SELECT datname FROM pg_database;


# 连接数据库请使用 \c 或者 \connect 命令
# 使用当前用户连接到新的数据库
\c dbname

# 使用新的用户连接到当前数据库
\c - username
```

## 列出所有库中的表

```sql
# 列出当前数据库中的表
\dt
\dt+

# 显示表结构
\d table_name
\d product # 列出product表结构
```

## 列出当前数据库中的可用函数

```sql
\df
```

## 列出可用视图

```sql
\du
```

## 开启查询执行时间

```sql
\timing
```



## 获取 SQL 命令的帮助

```sql
\h sql_command

\h TRUNCATE	# 获取 TRUNCATE帮助
```

## 获取 psql 的帮助

```sql
\?
```

## 退出 psql

```sql
\q
```



# 数据库操作

## 创建数据库

**CREATE DATABASE 语法**

```sql
CREATE DATABASE db_name
[ [ WITH ] [ OWNER [=] user_name ]
       [ TEMPLATE [=] template ]
       [ ENCODING [=] encoding ]
       [ LOCALE [=] locale ]
       [ LC_COLLATE [=] lc_collate ]
       [ LC_CTYPE [=] lc_ctype ]
       [ TABLESPACE [=] tablespace_name ]
       [ ALLOW_CONNECTIONS [=] allowconn ]
       [ CONNECTION LIMIT [=] connlimit ]
       [ IS_TEMPLATE [=] istemplate ] ]
```

```
db_name
要创建的数据库的名字。

user_name
将拥有新数据库的用户的角色名称。您可以使用 DEFAULT 表示执行命令的用户。

template
用于创建新数据库的模板名称。您可以使用 DEFAULT 表示默认模板的模板名称 (template1)。

encoding
要在新数据库中使用的字符集编码。您可以指定一个字符串常量（例如，'SQL_ASCII'），或者一个整数编码号，或者 DEFAULT (模板数据库的编码)。点击这里以查看 PostgreSQL 支持的字符集。默认：UTF8

locale
这是一个设置 LC_COLLATE 和 LC_CTYPE 的快捷方式。如果指定此项，则不能指定其中任何一个参数。

lc_collate
要在新数据库中使用的整理顺序 (LC_COLLATE)。这会影响应用于字符串的排序顺序。默认：C

lc_ctype
要在新数据库中使用的字符分类 (LC_CTYPE)。这会影响字符的分类，例如小写、大写和数字。默认：C

tablespace_name
将与新数据库关联的表空间的名字。您可以使用 DEFAULT 以使用模板数据库的表空间的名称。默认：pg_default

allowconn
是否允许连接到此数据库。如果为 false，则没有人可以连接到该数据库。默认值为 true，允许连接。

connlimit
连接数限制。-1（默认）表示没有限制。

istemplate
是否为模版数据库。 如果为 true，则任何具有 CREATEDB 权限的用户都可以克隆此数据库；如果为 false（默认值），则只有超级用户或数据库所有者可以克隆它
```



```sql
CREATE DATABASE db_name;

# 如果不存在，则创建该数据库；如果已经存在，则不执行任何操作，也不会报错
CREATE DATABASE IF NOT EXISTS dbname;

```



## 删除数据库

**`DROP DATABASE` 语句将永久删除数据库和数据库中的所有表**



```sql
DROP DATABASE [IF EXISTS] database_name;


# cannot drop the currently open database
# 不能删除当前打开的数据库


# ERROR:  database "test_db" is being accessed by other users
# DETAIL:  There is 1 other session using the database.
# 数据库 test_db 正在被其他用户访问
```



**从 `pg_stat_activity` 视图中查询数据库中的活动连接**

```sql
SELECT
  pid,
  usename,
  application_name
FROM
  pg_stat_activity
WHERE
  datname = 'test_db';

```

**使用 `pg_terminate_backend()` 函数结束刚刚返回的活动连接**

```sql
# 37771为上一步命令查出的id
SELECT pg_terminate_backend(37771);
```

## 修改数据库

**`ALTER DATABASE` 可以修改数据库的各种信息，包括名称、属性、所有者、表空间等**

### 重命名一个数据库

```sql
ALTER DATABASE name RENAME TO new_name;

ALTER DATABASE test_db RENAME TO test_new_db;


# current database cannot be renamed
# 不能重命名当前打开的数据库
```

### 修改数据库的所有者

```sql
ALTER DATABASE name OWNER TO
{ new_owner | CURRENT_ROLE | CURRENT_USER | SESSION_USER };

# 数据库 test_new_db 的所有者是 postgres，下面说明了如何要将其所有者修改为 test
# 创建 test 用户
CREATE USER test PASSWORD '123456';

# 将数据库的所有者修改为 test
ALTER DATABASE test_new_db OWNER TO test;
```

### 修改数据库的选项

```sql
ALTER DATABASE name [WITH] ALLOW_CONNECTIONS { true | false};
ALTER DATABASE name [WITH] CONNECTION LIMIT connlimit;
ALTER DATABASE name [WITH] IS_TEMPLATE { true | false};

# ALLOW_CONNECTIONS 是否允许连接到此数据库
# CONNECTION LIMIT 连接数限制
# IS_TEMPLATE 是否为模版数据库

# 修改数据库是否允许连接
ALTER DATABASE test_new_db ALLOW_CONNECTIONS false;
# 修改数据库的连接数
ALTER DATABASE test_new_db CONNECTION LIMIT 10;
# 修改数据库是否为模板数据库
ALTER DATABASE test_new_db IS_TEMPLATE true;
```

### 修改数据库的表空间

```sql
ALTER DATABASE name SET TABLESPACE new_tablespace;

# 创建表空间
CREATE TABLESPACE test_tablespace OWNER postgres LOCATION 'D:\\data\\pg_tablespaces\\test_tablespace';
# 修改数据库的表空间
ALTER DATABASE test_new_db SET TABLESPACE test_tablespace;
```

### 重置数据库的配置参数的值

```sql
ALTER DATABASE name RESET configuration_parameter;
```

### 重置数据库所有的配置参数的值

```sql
ALTER DATABASE name RESET ALL;
```

### 修改数据库的配置参数

```sql
ALTER DATABASE name SET configuration_parameter { TO | = } { value | DEFAULT };
ALTER DATABASE name SET configuration_parameter FROM CURRENT;
```



## 查询数据库

<a href="#selectDatabase">点击此查看</a>

## 复制数据库

### 从模板数据库复制数据库

```sql
# 为了数据的安全性，在操作之前需要先将要操作数据库复制备份
# 使用 CREATE DATABASE 将此数据库复制为一个新数据库
CREATE DATABASE new_db WITH TEMPLATE old_db;
```

`old_db` 必须是模板数据库才能被复制。如果它不是模板数据库，您可以使用 `ALTER DATABASE` 语句[将此数据库修改为模板数据库](https://www.sjkjc.com/postgresql/alter-database/)

```sql
ALTER DATABASE old_db WITH IS_TEMPLATE true;
```

## 备份数据库

### pg_dump

**用于备份单个 PostgreSQL 数据库**

```sql
pg_dump -U username -W -F t db_name > output.tar
```

```
-U username: 指定连接 PostgreSQL 数据库服务器的用户。您可以在 username 位置使用自己的用户名。

-W: 强制 pg_dump 在连接到 PostgreSQL 数据库服务器之前提示输入密码。按回车后， pg_dump 会提示输入 postgres 用户密码。

-F : 指定输出文件的格式，它可以是以下格式之一：
    c: 自定义格式
    d: 目录格式存档
    t: tar 文件包
    p: SQL 脚本文件
    db_name 是要备份的数据库的名字。

output.tar 是输出文件的路径
```



### pg_dumpal

**用于备份 PostgreSQL 服务器中的所有的数据库**

```sql
pg_dumpall -U username > output.sql
```



## 恢复数据库

- `pg_restore` 工具用于恢复由 `pg_dump` 工具产生的 tar 文档和目录文档。
- `psql` 工具可以导入 `pg_dump` 和 `pg_dumpall` 工具产生的 SQL 脚本文件。
- `\i` 命令可以导入 `pg_dump` 和 `pg_dumpall` 工具产生的 SQL 脚本文件



### pg_restore方案

```sql
pg_restore [option...] file_path

pg_restore -d db_name path_to_db_backup_file.tar
```

```
file_path 是要恢复的文件或者目录的路径。
option 是一些恢复数据时用到的参数，比如，数据库，主机，端口 等。 您可以使用如下选项
```

| 参数                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `-a` `--data-only`                                           | 只恢复数据，而不恢复表模式（数据定义）。                     |
| `-c` `--clean`                                               | 创建数据库对象前先清理（删除）它们。                         |
| `-C` `--create`                                              | 在恢复数据库之前先创建它。                                   |
| `-d dbname` `--dbname=dbname`                                | 与数据库 dbname 联接并且直接恢复到该数据库中。               |
| `-e` `--exit-on-error`                                       | 如果在向数据库发送 SQL 命令的时候碰到错误，则退出。缺省是继续执行并且在恢复 结束时显示一个错误计数。 |
| `-f filename` `--file=filename`                              | 声明生成的脚本的输出文件，或者出现-l 选项时用于列表的文件，缺省是标准输出。 |
| `-F format` `--format=format`                                | 声明备份文件的格式。                                         |
| `-i` `--ignore-version`                                      | 忽略数据库版本检查。                                         |
| `-I index` `--index=index`                                   | 只恢复命名的索引。                                           |
| `-l` `--list`                                                | 列出备份的内容。这个操作的输出可以用 -L 选项限制和重排所恢复的项目。 |
| `-L list-file` `--use-list=list-file`                        | 只恢复在 list-file 里面的元素，以它们在文件中出现的顺序。    |
| `-n namespace` `--schema=schema`                             | 只恢复指定名字的模式里面的定义和/或数据。不要和 -s 选项混淆。这个选项可以和 -t 选项一起使用。 |
| `-O` `--no-owner`                                            | 不要输出设置对象的权限，以便与最初的数据库匹配的命令。       |
| `-s` `--schema-only`                                         | 只恢复表结构（数据定义）。不恢复数据，序列值将重置。         |
| `-S username` `--superuser=username`                         | 设置关闭触发器时声明超级用户的用户名。只有在设置了 –disable-triggers 的时候 才有用。 |
| `-t table` `--table=table`                                   | 只恢复表指定的表的定义和/或数据。                            |
| `-T trigger` `--trigger=trigger`                             | 只恢复指定的触发器。                                         |
| `-v` `--verbose`                                             | 声明冗余模式。                                               |
| `-x` `--no-privileges` `--no-acl`                            | 避免 ACL 的恢复（grant/revoke 命令）                         |
| `-X use-set-session-authorization` `--use-set-session-authorization` | 输出 SQL 标准的 SET SESSION AUTHORIZATION 命令，而不是 OWNER TO 命令。 |
| `-X disable-triggers` `--disable-triggers`                   | 这个选项只有在执行仅恢复数据的时候才相关。                   |
| `-h host` `--host=host`                                      | 声明服务器运行的机器的主机名。                               |
| `-p port` `--port=port`                                      | 声明服务器侦听的 TCP 端口或者本地的 Unix 域套接字文件扩展。  |
| `-U username`                                                | 以给出用户身分联接。                                         |
| `-W`                                                         | 强制给出口令提示。如果服务器要求口令认证，那么这个应该自动发生 |

### psql方案

```sql
psql -U username -f path_to_db_backup_file.sql
```



### \i导入sql

```sql
# 启动 psql 工具并连接 PostgreSQL 服务器
.\psql.exe -U postgres

# 创建 sakila 数据库
CREATE DATABASE sakila;

# 连接 sakila 数据库
\c sakila;

# 使用以下两个语句以导入刚刚下载的两个文件 postgres-sakila-schema.sql 和 postgres-sakila-insert-data.sql
\i C:/Users/Adam/Downloads/postgres-sakila-schema.sql
\i C:/Users/Adam/Downloads/postgres-sakila-insert-data.sql

```







# 数据表操作

## 创建表

```sql
CREATE TABLE [IF NOT EXISTS] table_name (
   column_name data_type column_contraint
   [, ...]
   table_constraint
);

```

- `table_name` 是要创建的表的名字。表名应该符合以下规则：
  - 表名可由字母、数字、下划线和美元符号组成，表名最大长度为 63 个字符。
  - 表名在一个数据库中是唯一的。
- `IF NOT EXISTS` 指示只有给定的表不存在的时候才进行创建。它是可选的。 如果你给定一个已经存在的表名，又没有使用 `IF NOT EXISTS` 子句，服务器会返回一个错误。
- `column_name` 是该列的名字。 列名应该符合以下规则：
  - 列名可由字母、数字、下划线和美元符号组成，列名最大长度为 63 个字符。
  - 列名在一个表中是唯一的。
- `data_type` 是该列要存储的数据的数据类型， 比如： [`VARCHAR`](https://www.sjkjc.com/postgresql/strings-types/), [`INTEGER`](https://www.sjkjc.com/postgresql/integer-type/), [`BOOLEAN`](https://www.sjkjc.com/postgresql/boolean-type/), [`DATE`](https://www.sjkjc.com/postgresql/date-type/), [`TIME`](https://www.sjkjc.com/postgresql/time-type/), [`TIMESTAMP`](https://www.sjkjc.com/postgresql/timestamp-type/), [`ARRAY`](https://www.sjkjc.com/postgresql/array-type/), [`JSON`](https://www.sjkjc.com/postgresql/json-type/) 等。
- `column_contraint` 是该列的约束，比如:
  - [`PRIMARY KEY`](https://www.sjkjc.com/postgresql/primary-key/)
  - [`FOREIGN KEY`](https://www.sjkjc.com/postgresql/foreign-key/)
  - [`NOT NULL`](https://www.sjkjc.com/postgresql/not-null/)
  - [`UNIQUE`](https://www.sjkjc.com/postgresql/unique/)
  - [`CHECK`](https://www.sjkjc.com/postgresql/check-constraint/)
  - [生成列](https://www.sjkjc.com/postgresql/generated-columns/)
  - [标识列](https://www.sjkjc.com/postgresql/identity-columns/)
- `column_name data_type column_contraint` 为一个列的定义。您可以在表中定义多个列，多个列定义使用逗号分隔。
- `table_constraint` 是表上的约束，包括：[`PRIMARY KEY`](https://www.sjkjc.com/postgresql/primary-key/), [`FOREIGN KEY`](https://www.sjkjc.com/postgresql/foreign-key/), [`UNIQUE`](https://www.sjkjc.com/postgresql/unique/) 和 [`CHECK`](https://www.sjkjc.com/postgresql/check-constraint/)
- `;` 不是语句的一部分，它只是表示语句的结束

```sql
CREATE TABLE users (
  user_id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL,	# 最多为 45 个字符；如果超出45个字符，则会把超出部分截断
  age INTEGER,
  locked BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMP NOT NULL
);

# 如果varchar和INTEGER没有设置NOT NULL；并且也没有插入值，那么字符串会默认为空串，数字类型是NULL
```

```sql
CREATE TABLE user_hobbies (
  hobby_id SERIAL NOT NULL,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (hobby_id),
  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT);
```

- `hobby_id` 列的数据类型是 `INTEGER`。它不能为 `NULL`，并且它是一个自增序列。
- `user_id` 列的数据类型是 `INTEGER`。它不能为 `NULL`。它通过外键指向了 `users` 表的 `user_id` 列。
- `hobby` 列的数据类型是 `VARCHAR`，它最多为 45 个字符。 它不能为 `NULL`。
- `created_at` 列的数据类型是 `TIMESTAMP`。它不能为 `NULL`。

`user_hobbies` 表的约束有：

- `PRIMARY KEY (hobby_id)` 子句表明 `hobby_id` 列是主键。
- `CONSTRAINT fk_user` 定义了一个[外键约束](https://www.sjkjc.com/postgresql/foreign-key/)。这个外键将 `user_id` 列引用了 `users` 表的 `user_id` 列
- `ON DELETE CASCADE` `user_id` 关联的行被删除时，该外键约束指定了级联删除的动作。这意味着如果 `users` 表中的某个用户被删除，所有关联到该用户的 `user_hobbies` 行也会被删除
- `ON UPDATE RESTRICT` `user_id` 关联的行不允许更新。换句话说，如果 `users` 表中的某个用户的 `user_id` 被更新，`user_hobbies` 表中相关的行不允许自动更新，除非手动调整



## 从已有的表创建新表

```sql
CREATE TABLE [IF NOT EXISTS] table_name
AS TABLE existing_table_name
[WITH NO DATA];

```



- `table_name` 是要创建的表的名字。
- `existing_table_name` 是已存在的表的名字。
- `WITH NO DATA` 指示只创建表而不拷贝数据。它是可选的。如果省略它，则即创建表又拷贝原表中的数据



```sql
CREATE TABLE users_copy
AS TABLE users;

```



## 从结果集创建新表

```sql
CREATE TABLE [IF NOT EXISTS] table_name
AS
SELECT ...;

```

```sql
CREATE TABLE users_copy
AS
SELECT * FROM users;


# 创建 users_copy 表， 不拷贝 users 表中的数据行
CREATE TABLE users_copy
AS
SELECT * FROM users WHERE false;

```

## 删除表

```sql
DROP TABLE [ IF EXISTS ] table_name [, ...]
[ CASCADE | RESTRICT ];

```

- `table_name` 是要删除的表的名称。
- 您可以在一个 `DROP TABLE` 语句中删除多个表，请使用逗号分隔表名。
- `IF EXISTS` 选项是可选的，它可以避免由于输入的表名 `table_name` 不存在引发的错误。
- `CASCADE | RESTRICT` 是可选的，它指示了如果有其他对象（比如[外键](https://www.sjkjc.com/postgresql/foreign-key/)、视图、触发器、存储过程等）引用了要删除的表的处理策略。其中：
  - `CASCADE` - 允许删除指定的表和引用此表的对象。
  - `RESTRICT` - 如果有对象引用此表，拒绝删除此表，并给出错误。它是默认的选项

```sql
# 强制删除此表，使用 CASCADE
DROP TABLE users;

# users 表被删除了，并且 user_hobbies 表上的外键约束 fk_user 也被级联删除了
DROP TABLE users CASCADE;

# 先判断在删除
DROP TABLE IF EXISTS x;
```



## 修改表

```sql
ALTER TABLE [IF EXISTS] table_name
   [alter_action options]
   [, ...];

```

`table_name` 是要修改的表的名字。 `IF EXISTS` 是可选的，

其中 `alter_action` 是一个修改动作，主要包括以下关键字：

- `ADD` 关键字可用来添加列和约束。
- `DROP` 关键字可用来删除列和约束。
- `ALTER` 关键字可用来修改现有的列和约束。
- `RENAME` 关键字可用来重命名表、列、和约束。
- `SET` 关键字可用来修改表的架构、表空间。
- `ENABLE` 关键字可用来启用触发器、规则、和行安全策略。
- `DISABLE` 关键字可用来禁用触发器、规则、和行安全策略。



### 重命名表

```sql
ALTER TABLE table_name
  RENAME TO new_name

```

### 修改表架构

```sql
ALTER TABLE table_name
  SET SCHEMA new_schema
```

### 修改表空间

```sql
ALTER TABLE table_name
  SET TABLESPACE new_tablespace
```

### 添加列

https://www.sjkjc.com/postgresql/alter-column/

```sql
ALTER TABLE table_name
  ADD [COLUMN] [IF NOT EXISTS] column_name data_type [ column_constraint [ ... ] ]
```

### 删除列

```sql
ALTER TABLE table_name
  DROP [ COLUMN ] [ IF EXISTS ] column_name [ RESTRICT | CASCADE ]
```

### 重命名列

```sql
ALTER TABLE table_name
  RENAME [ COLUMN ] column_name TO new_column_name
```

### 修改列类型

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type

```

### 列设置默认值

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name SET DEFAULT expression
```

### 删除列默认值

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name DROP DEFAULT

```

### 列添加 `NOT NULL`

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name SET NOT NULL
```

### 删除列 `NOT NULL`

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name DROP NOT NULL
```



### 标识列

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name ADD GENERATED { ALWAYS | BY DEFAULT }
      AS IDENTITY [ ( sequence_options ) ]
```

### 修改为普通列

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name DROP IDENTITY [ IF EXISTS ]
```

### 添加约束

```sql
ALTER TABLE table_name
  ADD [ CONSTRAINT constraint_name ]
      { CHECK ( expression ) [ NO INHERIT ] |
        UNIQUE ( column_name [, ... ] ) index_parameters |
        PRIMARY KEY ( column_name [, ... ] ) index_parameters |
        EXCLUDE [ USING index_method ] ( exclude_element WITH operator [, ... ] ) index_parameters [ WHERE ( predicate ) ] |
        FOREIGN KEY ( column_name [, ... ] ) REFERENCES reftable [ ( refcolumn [, ... ] ) ]
          [ MATCH FULL | MATCH PARTIAL | MATCH SIMPLE ] [ ON DELETE referential_action ] [ ON UPDATE referential_action ] }
      [ DEFERRABLE | NOT DEFERRABLE ] [ INITIALLY DEFERRED | INITIALLY IMMEDIATE ]

```

### 删除约束

```sql
ALTER TABLE table_name
  DROP CONSTRAINT [ IF EXISTS ]  constraint_name [ RESTRICT | CASCADE ]

```

### 重命名约束

```sql
ALTER TABLE table_name
  RENAME CONSTRAINT constraint_name TO new_constraint_name

```





# 数据列操作案例

## 添加列

将新列添加到现有表

```sql
ALTER TABLE table_name
ADD [COLUMN] [IF NOT EXISTS] column_name data_type column_contraint
[, ADD [COLUMN] ...];

```

- `table_name` 是要在其中添加列的表。
- `ADD [COLUMN] ...` 子句用来添加一个列。其中 `COLUMN` 关键字是可以省略的。如果要在一个语句中添加多个列，请使用多个逗号分隔的 `ADD [COLUMN] ...` 子句。
- `column_name` 是要添加的列的名字。 列名应该符合以下规则：
  - 列名可由字母、数字、下划线和美元符号组成，列名最大长度为 63 个字符。
  - 列名在一个表中是唯一的。
- `data_type` 是要添加的列要存储的数据的数据类型， 比如： [`VARCHAR`](https://www.sjkjc.com/postgresql/strings-types/), [`INTEGER`](https://www.sjkjc.com/postgresql/integer-type/), [`BOOLEAN`](https://www.sjkjc.com/postgresql/boolean-type/), [`DATE`](https://www.sjkjc.com/postgresql/date-type/), [`TIME`](https://www.sjkjc.com/postgresql/time-type/), [`TIMESTAMP`](https://www.sjkjc.com/postgresql/timestamp-type/), [`ARRAY`](https://www.sjkjc.com/postgresql/array-type/), [`JSON`](https://www.sjkjc.com/postgresql/json-type/) 等。
- `column_contraint` 是要添加的列的约束，比如 [`NOT NULL`](https://www.sjkjc.com/postgresql/not-null/), [`UNIQUE`](https://www.sjkjc.com/postgresql/unique/), [`PRIMARY KEY`](https://www.sjkjc.com/postgresql/primary-key/), [`FOREIGN KEY`](https://www.sjkjc.com/postgresql/foreign-key/) 和 [`CHECK`](https://www.sjkjc.com/postgresql/check-constraint/) 等。
- `IF NOT EXISTS` 可以避免因为给出的重复的列名而导致的错误。它是可选的。

新的列将会被添加到表的末尾。您不能为新的列指定位置。

如果表中已有一些行，新的列的约束可能会导致错误，您可以在列定义上添加默认值，或者通过以下步骤解决：

1. 添加不带约束的列。
2. 更新新加的列的数据。
3. 为新的列添加约束。



```sql
INSERT INTO users (name) values ('Tim');
```

```sql
# 创建库
CREATE DATABASE testdb;

# 切换库
\c testdb;

# \d 命令查看此表中的所有列
\d users;

# 创建表
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);


# 在 users 表保存用户的年龄，你需要使用以下语句向 users 表中添加 age 列
ALTER TABLE users ADD COLUMN age INTEGER NOT NULL;

ERROR:  column "age" contains null values
# 因为表不是一个空表，它已经有了一行。 要添加的 age 列是 NOT NULL 的 导致了这个错误的发生。要避免这个错误，可以为 age 列指定一个默认值

ALTER TABLE users ADD COLUMN age INTEGER NOT NULL DEFAULT 18;




# 向 users 表中添加 email 和 cellphone 列
ALTER TABLE users
ADD COLUMN email VARCHAR(100),
ADD COLUMN cellphone VARCHAR(100);
```





## 查看表中所有的列

```sql
\d table_name


# 从 information_schema.columns 表中查找一个表中所有的列
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'table_name';
```



## 删除列

```sql
ALTER TABLE table_name
DROP [COLUMN] [IF EXISTS] column_name [RESTRICT | CASCADE]
[, DROP [COLUMN] ...];

```

- `table_name` 是要在其中添加列的表。
- `DROP [COLUMN] ...` 子句用来删除一个列。其中 `COLUMN` 关键字是可以省略的。如果要在一个语句中删除多个列，请使用多个逗号分隔的 `ADD [COLUMN] ...` 子句。
- `IF EXISTS` 是可选的， 它可以避免因为给出的列名不存在而导致的错误。
- `column_name` 是要删除的列的名字。
- `CASCADE | RESTRICT` 是可选的， 它指示了如果有其他对象（比如[外键](https://www.sjkjc.com/postgresql/foreign-key/)、视图、触发器、存储过程等）引用了要删除的列的处理策略。其中：
  - `CASCADE` - 允许删除此列和引用此列的对象。
  - `RESTRICT` - 如果有对象引用此列，拒绝删除此列，并给出错误。它是默认的选项。

当您从表中删除一列时，PostgreSQL 将自动删除所有涉及删除列的[索引](https://www.sjkjc.com/postgresql/indexes/)和约束。



**有以下两表**

```sql
CREATE TABLE users (
  user_id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  age INTEGER,
  locked BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE user_hobbies (
  hobby_id SERIAL NOT NULL,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (hobby_id),
  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT);
```

```sql
# 删除 users 表中的 user_id 列
ALTER TABLE users DROP COLUMN user_id;

# ERROR:  cannot drop column user_id of table users because other objects depend on it
# DETAIL:  constraint fk_user on table user_hobbies depends on column user_id of table users
# HINT:  Use DROP ... CASCADE to drop the dependent objects too.
# user_hobbies 表中的外键 fk_user 引用了 users 表中的 user_id 列，不能删除此列， PostgreSQL 给出一个错误提示

# 要强制删除此列，使用 CASCADE 选项
# user_id 列被删除了，并且 user_hobbies 表上的外键约束 fk_user 也被级联删除了
ALTER TABLE users DROP COLUMN user_id CASCADE;

```



## 修改列

```sql
ALTER TABLE table_name
ALTER [COLUMN] column_name alter_action
[, ALTER [COLUMN] ...];

```

- `table_name` 是要在其中添加列的表。
- `ALTER [COLUMN] column_name alter_action` 子句用来修改由列名 `column_name` 指定的列。其中 `COLUMN` 关键字是可以省略的。
- `alter_action` 是修改动作，您可以使用以下动作之一：
  - 修改列的数据类型: `[ SET DATA ] TYPE data_type [ COLLATE collation ] [ USING expression ]`
  - 修改列的默认值：`SET DEFAULT expression`
  - 删除列的默认值：`DROP DEFAULT`
  - 设置或删除不能为 NULL: `{ SET | DROP } NOT NULL`
  - 将生成列转为普通列: `DROP EXPRESSION [ IF EXISTS ]`
  - 修改列为标识列: `ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ]`
  - 修改标识列的生成策略: `{ SET GENERATED { ALWAYS | BY DEFAULT } | SET sequence_option | RESTART [ [ WITH ] restart ] } [...]`
  - 将标识列转为普通列: `DROP IDENTITY [ IF EXISTS ]`
  - 设置列的统计信息手机目标: `SET STATISTICS integer`
  - 设置属性选项: `SET ( attribute_option = value [, ... ] )`
  - 重置属性: `RESET ( attribute_option [, ... ] )`
  - 设置列的存储模式: `SET STORAGE { PLAIN | EXTERNAL | EXTENDED | MAIN }`
  - 设置列的压缩方法: `SET COMPRESSION compression_method`





### 修改列类型

```sql
ALTER TABLE table_name
  ALTER [ COLUMN ] column_name [ SET DATA ] TYPE data_type [ USING expression ]

```

- 在 `ALTER TABLE` 关键字后指定要更改的列的表名。
- 在 `ALTER COLUMN` 子句后指定要更改数据类型的列的名称。
- 为 `TYPE` 关键字后的列提供新的数据类型。该 `SET DATA TYPE` 和 `TYPE` 是等价的。
- PostgreSQL 允许您通过添加 `USING` 子句在修改数据类型时将列的值转换为新的值。



```sql
# 创建表
CREATE TABLE orders (
    id serial PRIMARY KEY,
    order_no VARCHAR NOT NULL
);

# 插入数据
INSERT INTO orders(order_no)
VALUES('10001'), ('10002');

# 将 order_no 列的数据类型更改为 INT
ALTER TABLE orders ALTER COLUMN order_no TYPE INT;


# ERROR:  column "order_no" cannot be cast automatically to type integer
# HINT:  You might need to specify "USING order_no::integer".

ALTER TABLE orders ALTER COLUMN order_no TYPE INT USING order_no::integer;

```





# 数据操作

## 新增数据

```sql
INSERT INTO table_name(column1, column2, …)
VALUES
  (value11, value12, …) [, (value21, value22, …), ...]
[ON CONFLICT conflict_target conflict_action]
[RETURNING expr];

```

- `INSERT INTO` 和 `VALUES` 是关键字
- `table_name` 是要插入数据行的表名。
- `(column1, column2, …)` 是列列表，其中是通过逗号分隔的各个列。
- `(value11, value12, …)` 是值列表，其中是通过逗号分隔的各个列的值。值列表中的值于列列表中的列一一对应。
- 要一次插入多个数据行，请使用多个使用逗号分隔的值列表。
- `ON CONFLICT` 用来[在 PostgreSQL 中实现 upsert 操作](https://www.sjkjc.com/postgresql/insert-on-conflict/)。
- `RETURNING` 子句是可选的。它用于返回插入的行的信息。 `expr` 可以是列名，或表达式等。



### RETURNING 子句

`INSERT` 语句有一个可选 `RETURNING` 子句，用于返回插入行的信息。如果具有 `RETURNING` 子句时，`INSERT` 语句按照 `RETURNING` 子句返回，否则它返回成功插入的行



返回指定的列，使用列表。多个列使用逗号分隔

```sql
RETURNING column1
RETURNING column1, column2

```

还可以使用 `AS` 对列名指定别名

```sql
RETURNING column1 AS column1_new_1
RETURNING column1 AS column1_new_1, column2 AS column1_new_2
```

返回新行的所有的列，使用星号 (`*`)

```sql
RETURNING *
```

返回一个表达式计算的值

```sql
RETURNING expr
```



### 不带 `RETURNING` 子句的返回值

没有指定 `RETURNING` 子句的 `INSERT` 语句的返回值具有以下形式

```sql
INSERT oid count
```

- `oid` 是一个对象标识符。PostgreSQL 在内部将 `oid` 用作其系统表的[主键](https://www.sjkjc.com/postgresql/primary-key/)。通常， `INSERT` 语句返回 `oid` 值为 0。
- `count` 是 `INSERT` 语句成功插入的行数。





### 案例

```sql
# 创建表
DROP TABLE IF EXISTS student;
CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  gender CHAR(1) NOT NULL,
  birthday DATE,
  notes VARCHAR(255)
);


# 插入一条数据
INSERT INTO student(name, gender) VALUES ('Tom', 'M');

# 向表中插入单行并指定返回值
INSERT INTO student(name, gender) VALUES ('Lucy', 'F') RETURNING *;

# 由于 INSERT 语句带有 RETURNING * 子句，因此语句返回了插入的新行中的所有列。如果只想返回其中的一列或者几列，在 RETURNING 子句指定具体的列
INSERT INTO student(name, gender) VALUES ('Jack', 'M') RETURNING id AS "Student ID", name, gender;


# 向表中插入多行
INSERT INTO student(name, gender) VALUES ('Jim', 'M'), ('Kobe', 'M'), ('Linda', 'F') RETURNING *;

# 向 student 表中插入一行带有生日的数据
INSERT INTO student (name, gender, birthday) VALUES('Alice', 'F', '2012-04-21') RETURNING *;


```



### `INSERT ON CONFLICT`插入或更新

```sql
INSERT INTO table_name(column_list)
VALUES(value_list)
ON CONFLICT conflict_target conflict_action
[RETURNING {* | column_names}];;

```

比较于 `INSERT` 语句来说，`INSERT ON CONFLICT` 只是多了 `ON CONFLICT` 子句。

这里：

- `conflict_target` 是存在冲突的对象，它可以是以下之一：
  - 一个列名。该列必须是主键或者唯一索引。
  - `ON CONSTRAINT constraint_name`， 并且 `constraint_name` 必须是[唯一约束](https://www.sjkjc.com/postgresql/unique/) 的名称。
  - [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句。
- `conflict_action` 是存在冲突时要采取的动作，它可以是以下之一：
  - `DO NOTHING`: 如果存在冲突，不采取任何动作。
  - `DO UPDATE`: 如果存在冲突，使用 `DO UPDATE SET column_1 = value_1, .. WHERE condition` 更新表中的字段。



### 案例

```sql
# 建表
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  nickname VARCHAR(50) NOT NULL,
  login_name VARCHAR(50) UNIQUE,
  notes VARCHAR(255)
);

# 插入数据
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim', 'tim', 'This is Tim'),
    ('Tom', 'tom', 'This is Tom');

# 再插入一个新行，其中带有和已有行重复的 login_name
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim2', 'tim', 'This is Tim2');


# ERROR:  duplicate key value violates unique constraint "users_login_name_key"
# DETAIL:  Key (login_name)=(tim) already exists.
# 重复的键值违反了唯一约束“ users _ login _ name _ key”
# 密钥(login _ name) = (tim)已经存在


# 使用 DO NOTHING 选项，如果冲突就不操作
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim2', 'tim', 'This is Tim2')
ON CONFLICT (login_name) DO NOTHING;


# 使用 DO UPDATE 更新其他的字段
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim2', 'tim', 'This is Tim2')
ON CONFLICT (login_name)
    DO UPDATE SET nickname = 'Tim2', notes = 'This is Tim2'
RETURNING *;


# 在 DO UPDATE 子句中，还可以使用 EXCLUDED 对象引用引发冲突的数据
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim2', 'tim', 'This is Tim2')
ON CONFLICT (login_name)
    DO UPDATE SET nickname = EXCLUDED.nickname,
                  notes = EXCLUDED.notes
RETURNING *;



# 在冲突对象中，除了字段名称，您还可以使用约束名称。上面的语句可以使用约束名称 users_login_name_key 代替列名 login_name
INSERT INTO
    users (nickname, login_name, notes)
VALUES
    ('Tim3', 'tim', 'This is Tim3')
ON CONFLICT ON CONSTRAINT users_login_name_key
    DO UPDATE SET nickname = EXCLUDED.nickname,
                  notes = EXCLUDED.notes
RETURNING *;

```



## 删除数据

```sql
DELETE FROM table_name
[where_clause]
[RETURNING expr];

```

- 在 `DELETE FROM` 关键字后的 `table_name` 是要从中删除数据的表的名称。

- `where_clause` 是 [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句。 您可以在其中使用条件来指定要删除表中的哪些行。

- `WHERE` 子句是可选的。如果不指定 `WHERE` 子句，表中的所有行将被删除。

- `RETURNING` 子句是可选的。它用于返回删除的行的信息。

  `expr` 可以是列名或者表达式，多个列或者表达式请使用逗号分隔。 您还可以使用 `*` 表示表中的所有的列。

  如果不指定 `RETURNING` 子句， `DELETE` 语句将返回删除的行数。

如果您要更加高效率的清空一个表，请优先使用 [`TRUNCATE TABLE`](https://www.sjkjc.com/postgresql/truncate-table/) 语句



```sql
# 建表
CREATE TABLE film_copy AS SELECT * FROM film;

# 中删除 film_id 为 1 的 1 个影片
DELETE FROM film_copy
WHERE film_id = 1;


# 从 film_copy 表中删除 film_id 为 2, 3 或者 4 的 3 个影片
DELETE FROM film_copy
WHERE film_id in (2, 3, 4);

# 从 film_copy 表中删除所有的影片
DELETE FROM film_copy;
```

### PostgreSQL DELETE 删除并返回删除的行

```sql
# 从 film_copy 表中删除 film_id 为 10 或者 11 的 2 个影片，并返回删除的影片的标题
DELETE FROM film_copy
WHERE film_id in (10, 11)
RETURNING film_id, title
```



## 清空表

```sql
TRUNCATE [TABLE] [ONLY] table_name [ * ] [, ... ]
    [RESTART IDENTITY | CONTINUE IDENTITY] [ CASCADE | RESTRICT ]

```

- `TABLE` 关键字是可选的。
- `ONLY` 关键字是可选的。如果在表名前指定了 `ONLY`，则只清空此表，不包含它的子表。否则，此表和它的子表都将被清空。
- `table_name` 是要清空的表的名字。 表名后的 `*` 明确的指示子表也将被清空。
- 您可以在一个 `TRUNCATE` 语句中清空多个表。 多个表名使用逗号分隔。
- `RESTART IDENTITY` 选项指示自动重置表中的列拥有的序列。 `CONTINUE IDENTITY` 选项指示不改变表中的序列的值，它是默认的。
- `CASCADE` 选项指示同时清空那些通过外键引用 `table_name` 的表。 `RESTRICT` 选项指示如果有外键引用要清空的表，则拒绝操作。



```sql
# 建表
CREATE TABLE test_truncate (
  v INTEGER
);


# 查询
INSERT INTO test_truncate (v)
SELECT generate_series(1, 10000000) v;

# 从表中删除 10000000 行，总共耗费 6566.458 
DELETE FROM test_truncate;
# 清空表，共耗费 31.785 毫秒
TRUNCATE TABLE test_truncate;
```



## 修改数据

```sql
UPDATE [IGNORE] table_name
SET
    column_name1 = value1,
    column_name2 = value2,
    ...
[WHERE clause]
[RETURNING expr];

```

- `UPDATE` 关键字后指定要更新数据的表名。

- 使用 `SET` 子句设置列的新值。多个列使用逗号分隔。列的值可以是普通的字面值，也可以是表达式运算，还可以是子查询。

- 使用 [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句指定要更新的行的条件。只有符合 `WHERE` 条件的行才会被更新。

- `WHERE` 子句是可选的。如果不指定 `WHERE` 子句，则更新表中的所有行。

- `RETURNING` 子句是可选的。它用于返回更新的行的信息。

  `expr` 可以是列名或者表达式，多个列或者表达式请使用逗号分隔。 您还可以使用 `*` 表示表中的所有的列。

  如果不指定 `RETURNING` 子句， `UPDATE` 语句将返回更新的行数。

`UPDATE` 语句中的 `WHERE` 子句非常重要。除非您特意，否则不要省略 `WHERE` 子句。





```sql
# 先查询一次数据
SELECT first_name, last_name, email
FROM customer
WHERE customer_id = 1;


# UPDATE 语句更新 email 列的值
UPDATE customer
SET email = 'NEW.MARY.SMITH@sakilacustomer.org'
WHERE customer_id = 1;

# UPDATE 修改多列值
UPDATE customer
SET first_name = 'Tim',
    last_name = 'Duncan',
    email = 'Tim.Duncan@sakilacustomer.org'
WHERE customer_id = 1
RETURNING first_name, last_name, email;

```

**可以使用以下 `RETURNING` 子句直接查看更新后的数据**

```sql
UPDATE customer
SET email = 'NEW.MARY.SMITH@sakilacustomer.org'
WHERE customer_id = 1
RETURNING first_name, last_name, email;

```



**使用表达式更新**

```sql
UPDATE customer
SET email = REPLACE(email, 'sakilacustomer.org', 'sjkjc.com')
RETURNING first_name, last_name, email;

```



**使用子查询更新**

```sql
UPDATE customer
SET store_id = (
    SELECT store_id
    FROM store
    ORDER BY random()
    LIMIT 1
  )
WHERE store_id IS NULL;

```



## UPDATE ... FROM 用法

有时候，需要根据另一个表中的数据更新一个表中的数据。比如：根据产品销量明细表更新销量统计表

```sql
UPDATE [IGNORE] table_name
SET
    column_name1 = value1,
    column_name2 = value2,
    ...
FROM another_table[, ...]
WHERE clause
[RETURNING expr];

```

- 和普通的 [`UPDATE`](https://www.sjkjc.com/postgresql/update/) 语句相比，此语句多了 `FROM` 子句，并且 `WHERE` 子句是必须的。
- 您需要在 `WHERE` 子句中指定两个表连接的条件



```sql
# 对于 a 表的每一行，该 UPDATE 语句都检查 b 表的每一行。如果值 a 表的 b_id 列的值等于在 b 表的 id 列，该 UPDATE 语句将更新 b 的表 c2 列的值到 a 表的 c1 列
UPDATE a
SET a.c1 = b.c2
FROM b
WHERE a.b_id = b.id;

```



```sql
# 现在有一个需求，需要更新 city 表中的城市名称，在其后添加 @ 和国家名
UPDATE city_copy a
SET city = city || '@' || b.country
FROM country b
WHERE b.country_id = 1 or b.country_id = 2
RETURNING city_id, city;

# 也可以使用子查询实现上面的需求
UPDATE city_copy a
SET city = (
  SELECT a.city || '@' || b.country
  FROM country b
    WHERE a.country_id = b.country_id
)
RETURNING city_id, city;

```



## 查询数据

### 基本查询

```sql
SELECT
    expr_list
FROM
    table_name
[other_clauses];
```

- `SELECT` 和 `FROM` 是关键字。
- `expr_list` 是要选择的列或者表达式的列表。多个列或表达式需要使用逗号分隔。
- `table_name` 是要查询的数据表。
- `FROM table_name` 是可选的。如果你不查询任何表中的行，则可以省略 `FROM` 子句。
- `other_clauses` 是 `SELECT` 语句支持的子句。 `SELECT` 语句支持很多子句，包括：
  - 使用 [`DISTINCT`](https://www.sjkjc.com/postgresql/distinct/) 运算符选择不同的行。
  - 使用 [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句对行进行排序。
  - 使用 [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句过滤行。
  - 使用 [`LIMIT`](https://www.sjkjc.com/postgresql/limit/) or [`FETCH`](https://www.sjkjc.com/postgresql/fetch/) 子句从表中选择行的子集。
  - 使用 [`GROUP BY`](https://www.sjkjc.com/postgresql/group-by/) 子句将行分组。
  - 使用 [`HAVING`](https://www.sjkjc.com/postgresql/having/) 子句过滤组。
  - 使用诸如 `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN` 之类的与其他表[连接](https://www.sjkjc.com/postgresql/join/)。
  - 使用 [`UNION`](https://www.sjkjc.com/postgresql/union/) ， [`INTERSECT`](https://www.sjkjc.com/postgresql/intersect/) 和 [`EXCEPT`](https://www.sjkjc.com/postgresql/except/) 执行集合运算

### where条件

```sql
SELECT columns_list
FROM table_name
WHERE query_condition;


# 查找名字和姓氏为 JAMIE 和 RICE 的客户
SELECT last_name,
  first_name
FROM customer
WHERE first_name = 'JAMIE'
  AND last_name = 'RICE';
  
  
# 查找姓氏为 RODRIGUEZ 或名字为 ADAM 的客户
SELECT first_name,
  last_name
FROM customer
WHERE last_name = 'RODRIGUEZ'
  OR first_name = 'ADAM';


# 返回名字为 ANN, ANNE, 或 ANNIE 的客户
SELECT first_name,
  last_name
FROM customer
WHERE first_name IN ('ANN', 'ANNE', 'ANNIE');


# 返回名字以字符串 ANN 开头的所有客户
SELECT first_name,
  last_name
FROM customer
WHERE first_name LIKE 'ANN%';

# 查找名字以字母 A 开头并包含 3 到 5 个字符的客户
SELECT first_name,
  LENGTH(first_name) name_length
FROM customer
WHERE first_name LIKE 'A%'
  AND LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY name_length;


# 查找名字以 BRA 开头而姓氏不以 MOTLEY 开头的客户
SELECT first_name,
  last_name
FROM customer
WHERE first_name LIKE 'BRA%'
  AND last_name <> 'MOTLEY';
```

- `=` : 相等
- `>` : 大于
- `<` : 小于
- `>=` : 大于或等于
- `<=` : 小于或等于
- `<>` : 不相等
- `!=` : 不相等，等同于 `<>`
- `AND` : 逻辑与运算符
- `OR` : 逻辑或运算符
- [`IN`](https://www.sjkjc.com/postgresql/in/) : 如果值与列表中的任何值匹配，则返回 true
- [`BETWEEN`](https://www.sjkjc.com/postgresql/between/) : 如果一个值在一个值范围之间，则返回 true
- [`LIKE`](https://www.sjkjc.com/postgresql/like/) : 如果值与模式匹配，则返回 true
- [`IS NULL`](https://www.sjkjc.com/postgresql/is-null/) : 如果值为 NULL，则返回 true
- `NOT` : 否定其他运算符的结果





### ORDER BY排序

 `ORDER BY` 子句可以让我们对 `SELECT` 语句返回的结果集按照一个或这多个列升序或者降序排序

```sql
SELECT
   column1, column2, ...
FROM
   table_name
[WHERE clause]
ORDER BY
   column1 [ASC|DESC],
   [column2 [ASC|DESC],
   ...]
   [NULLS FIRST | NULLS LAST]
   ;

```

- 可以为 `ORDER BY` 子句指定一个或多个列或者表达式。

- `ASC` 代表升序，`DESC` 代表降序。这是可选的，默认值是 `ASC`。

- 当指定多个排序表达式时，首先按照前面的表达式排序，其次按照后面的列排序。

- `NULLS FIRST` 和 `NULLS LAST` 用来指定对 null 值排序规则：

  - `NULLS FIRST`： null 值在非 null 值之前。
  - `NULLS LAST`： null 值在非 null 值之后。

  默认情况下，PostgreSQL 采用升序排序时采用 `NULLS LAST`，降序排序时采用 `NULLS FIRST`。 也就是说， PostgreSQL 默认 null 值比非 null 值大。





```sql
# 按演员姓氏升序进行排序
SELECT
    actor_id, first_name, last_name
FROM
    actor
ORDER BY last_name;


# 按演员姓氏降序进行排序
SELECT
    actor_id, first_name, last_name
FROM
    actor
ORDER BY last_name DESC;


# 先按演员姓氏升序排序，再按演员名字升序排序
SELECT
    actor_id, first_name, last_name
FROM
    actor
ORDER BY last_name, first_name;


# 自定义顺序排序
# 根据影片的分级按照的 'G', 'PG', 'PG-13', 'R', 'NC-17' 顺序对影片进行排序
SELECT
    film_id, title, rating
FROM
    film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
END;
```



**ORDER BY 和 NULL**

在 PostgreSQL 中的升序排序中， `NULL` 值出现在非 NULL 值之前

以下实例使用以下临时数据作为演示

```sql
SELECT 'A' AS v
UNION ALL
SELECT 'B' AS v
UNION ALL
SELECT NULL AS v
UNION ALL
SELECT '0' AS v
UNION ALL
SELECT '1' AS v;


# ASC 排序时， NULL 值默认排在非 NULL 值的后面
SELECT 'A' AS v
UNION ALL
SELECT 'B' AS v
UNION ALL
SELECT NULL AS v
UNION ALL
SELECT '0' AS v
UNION ALL
SELECT '1' AS v
ORDER BY v;


# ASC 排序采用 NULLS LAST 规则，所以 NULL 值在最后。 如果您想要改用 NULLS FIRST
SELECT 'A' AS v
UNION ALL
SELECT 'B' AS v
UNION ALL
SELECT NULL AS v
UNION ALL
SELECT '0' AS v
UNION ALL
SELECT '1' AS v
ORDER BY v NULLS FIRST;


# 使用 ORDER BY 子句降序 DESC 排序时， NULL 值排在非 NULL 值的前面。这是因为 DESC 排序默认采用 NULLS FIRST 规则
SELECT 'A' AS v
UNION ALL
SELECT 'B' AS v
UNION ALL
SELECT NULL AS v
UNION ALL
SELECT '0' AS v
UNION ALL
SELECT '1' AS v
ORDER BY v DESC;

```



### FETCH限定查询返回行数

```sql
FETCH { FIRST | NEXT } [ rows_count ] { ROW | ROWS } ONLY

```

- 可以使用 `FIRST` 和 `NEXT` 中的任意一个，他们含义相同。
- 可以使用 `ROW` 和 `ROWS` 中的任意一个，他们含义相同。
- `rows_count` 是要限制的行数，即返回的最大的行数。 它是可选的，默认值为 1。您应该为 `rows_count` 指定一个大于 0 的整数值。

```sql
SELECT column_list
FROM table_name
[other_clauses]
FETCH rows_count;

# other_clauses 是那些可以在 SELECT 语句中使用的其他子句，比如 WHERE, ORDER BY, OFFSET 等
# 需要在带有 FETCH 子句的 SELECT 语句中一同使用 ORDER BY 子句，这样您可以得到一个按照指定的顺序排序的结果集
```

```sql
SELECT column_list
FROM table_name
ORDER BY ...
OFFSET skipped_rows
FETCH FIRST rows_count ROWS ONLY;

```

- 第一页可以使用： `OFFSET 0 OFFSET FIRST 10 ROWS ONLY` 表示最多返回 10 行。
- 第二页可以使用： `OFFSET 10 OFFSET FIRST 10 ROWS ONLY` 表示跳过第一页的 10 行后最多返回 10 行。
- 第三页可以使用： `OFFSET 20 OFFSET FIRST 10 ROWS ONLY` 表示跳过前两页的 20 行后最多返回 10 行。
- 以此类推
- ROWS ONLY：确保 `FETCH` 子句应用于确切的行数，而不应用于查询可能返回的其他行，这些行可能是由于其他因素引起的；如优化器，索引；省略 `ROWS ONLY`，查询可能返回更多行，取决于查询优化和索引



```sql
#从 film 表查询时最多返回 5 行，使用下面的带有 FETCH 子句的 SELECT 语句
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
FETCH FIRST 5 ROWS ONLY;

# 要获得租金最高的 10 部电影，可以按租金降序对电影进行排序，然后使用 FETCH 子句获得前 10 部电影
SELECT
  film_id,
  title,
  rental_rate
FROM film
ORDER BY rental_rate DESC, film_id
FETCH FIRST 10 ROWS ONLY;


```



### FETCH 和 OFFSET 分页查询示例

```sql
# film 表中共有 1000 行关于影片的信息
SELECT COUNT(*) FROM film;

# 需要每页显示 10 个影片信息，那么可以使用如下的语句获取第一页的所有行
# 为了让所有分页的顺序一致，我们使用 ORDER BY film_id 让影片按照 film_id 排序，并使用 FETCH FIRST 10 ROWS ONLY 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
FETCH FIRST 10 ROWS ONLY;


# 为了获取第二页要显示的 10 行，使用 OFFSET 10 子句跳过第一页的 10 行，并使用 FETCH FIRST 10 ROWS ONLY 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 10
FETCH FIRST 10 ROWS ONLY;


# 取第三页的所有行
# 使用 OFFSET 20 指示了跳过前两页的 20 行，并使用 FETCH FIRST 10 ROWS ONLY 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 20
FETCH FIRST 10 ROWS ONLY;

```



### LIMIT 子句

```sql
SELECT column_list
FROM table_name
[other_clauses]
LIMIT rows_count;

```

`other_clauses` 是那些可以在 `SELECT` 语句中使用的其他子句，比如 [`WHERE`](https://www.sjkjc.com/postgresql/where/), [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/), [`OFFSET`](https://www.sjkjc.com/postgresql/offset/) 等

在 `SELECT` 语句使用 `LIMIT` 子句和 `OFFSET` 子句

```sql
SELECT column_list
FROM table_name
ORDER BY ...
LIMIT rows_count OFFSET skipped_rows;
```

- 第一页可以使用： `LIMIT 10 OFFSET 0` 表示最多返回 10 行。
- 第二页可以使用： `LIMIT 10 OFFSET 10` 表示跳过第一页的 10 行后最多返回 10 行。
- 第三页可以使用： `LIMIT 10 OFFSET 20` 表示跳过前两页的 20 行后最多返回 10 行。
- 以此类推…



要限制从 `film` 表查询时最多返回 5 行，使用下面的带有 `LIMIT` 子句的 `SELECT` 语句

```sql
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
LIMIT 5;

```

要获得租金最高的 10 部电影，您可以按租金降序对电影进行排序，然后使用 `LIMIT` 子句获得前 10 部电影

```sql
SELECT
  film_id,
  title,
  rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 10;
```

#### LIMIT 和 OFFSET 分页查询示例

```sql
# film 表中共有 1000 行关于影片的信息
SELECT COUNT(*) FROM film;
```

假设有一个系统需要在前端展示所有的影片信息，将 1000 行信息全部展示在一页上并不是一个好的方案。因为这个方案如下的缺点：

- 数据库性能。 一个语句中返回大量的数据会带给数据库服务器更大的内存开销和 IO 消耗。
- 应用性能。大量的数据会导致应用占用更大的内村，甚至回导致应用卡顿、卡死。
- 用户的体验。用户面对大量的数据会眩晕

一个更好的方案是分页显示所有的影片。您可以很轻松地使用 带有 `LIMIT` 和 `OFFSET` 子句的 `SELECt` 语句实现分页查询。



```sql
# 假设需要每页显示 10 个影片信息，那么可以使用如下的语句获取第一页的所有行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
LIMIT 10;

# 获取第二页要显示的 10 行，使用 OFFSET 10 子句跳过第一页的 10 行，并使用 LIMIT 10 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 10
LIMIT 10;


# 获取第三页的所有行
# 使用 OFFSET 20 指示了跳过前两页的 20 行，并使用 LIMIT 10 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 20
LIMIT 10;


```



### OFFECT跳过

有时候，可能想让 `SELECT` 语句跳过指定的行数，返回剩余的行。比如，想要获取除成绩前 10 名之外的所有人的信息

```sql
SELECT column_list
FROM table_name
[other_clauses]
OFFSET skipped_rows;

# skipped_rows 指定要跳过的行数。比如 OFFSET 10 表示跳过 10 行
# other_clauses 表示可以在 SELECT 语句中使用的其他子句，比如 WHERE, ORDER BY, LIMIT 等
```

```sql
SELECT column_list
FROM table_name
ORDER BY ...
LIMIT rows_count OFFSET skipped_rows;
```

- 第一页可以使用： `LIMIT 10 OFFSET 0` 表示最多返回 10 行。
- 第二页可以使用： `LIMIT 10 OFFSET 10` 表示跳过第一页的 10 行后最多返回 10 行。
- 第三页可以使用： `LIMIT 10 OFFSET 20` 表示跳过前两页的 20 行后最多返回 10 行。
- 以此类推…



```sql
# 从 film 表查询时跳过前面的 995 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 995;
```



假设有一个系统需要在前端展示所有的影片信息，将 1000 行信息全部展示在一页上并不是一个好的方案。因为这个方案如下的缺点：

- 数据库性能。 一个语句中返回大量的数据会带给数据库服务器更大的内存开销和 IO 消耗。
- 应用性能。大量的数据会导致应用占用更大的内容，甚至回导致应用卡顿、卡死。
- 用户的体验。用户面对大量的数据会眩晕。

一个更好的方案是分页显示所有的影片。可以很轻松地使用 带有 `LIMIT` 和 `OFFSET` 子句的 `SELECt` 语句实现分页查询

```sql
# 需要每页显示 10 个影片信息
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
LIMIT 10;

# 获取第二页的所有行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 10
LIMIT 10;


# 获取第三页的所有行
# 使用 OFFSET 20 指示了跳过前两页的 20 行，并使用 LIMIT 10 限制了此查询最多返回 10 行
SELECT
  film_id,
  title,
  release_year
FROM film
ORDER BY film_id
OFFSET 20
LIMIT 10;
```



### DISTINCT去重

```sql
SELECT
   DISTINCT column1 [, column2, ...]
FROM
   table_name;
```

- 关键字 `DISTINCT` 要在 `SELECT` 后指定。
- 在关键字 `DISTINCT` 后指定需要评估是否重复的列。
- 多个列名需要使用逗号 `,` 间隔。如果指定了多个列名， PostgreSQL 将根据这些列的值的组合后的值评估是否重复。
- 可以使用 `DISTINCT *` 来对所有的列进行评估重复。



PostgreSQL 还提供了 `DISTINCT ON (expression)` 使用以下语法保留每组重复项的“第一”行

```sql
SELECT
   DISTINCT ON (column1) column_alias,
   column2
FROM
   table_name
ORDER BY
   column1,
   column2;
```

始终将 [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句与 the `DISTINCT ON(expression)` 一起使用以使结果集可预测是一种很好的做法

```sql
# 从 film 表中检索所有的影片评级
SELECT
    DISTINCT rating
FROM
    film;


# 从 film 表中检索所有的租金金额
SELECT
    DISTINCT rental_rate
FROM
    film;

# 为了找到所有的影片租金金额，使用了 DISTINCT rental_rate，让每个影片租金金额只在结果集中出现一次
# 从 film 表中检索所有的影片评级和租金金额的组合
SELECT
    DISTINCT rating, rental_rate
FROM
    film
ORDER BY rating;


# 使用了 DISTINCT rating, rental_rate 来查找所有的影片评级和租金金额的组合。为了是让输出更易读，使用 ORDER BY 让结果集按照影片等级正序排序
# 想返回每组影片评级的第一项
SELECT
    DISTINCT ON (rating) rating,
    film_id,
    title
FROM
    film
ORDER BY rating, film_id DESC;

```

#### DISTINCT 与 NULL

当 `DISTINCT` 遇到 `NULL` 值时，只保留一个 `NULL` 值。因为 `DISTINCT` 认为所有的 `NULL` 值都是相同的，这与字段的类型无关

```sql
# 下面的 SQL 返回多行 NULL 记录
# 拥有 3 行，其中每行的 nullable_col 列的值都为 NULL
SELECT NULL nullable_col
UNION ALL
SELECT NULL nullable_col
UNION ALL
SELECT NULL nullable_col;

# 当使用 DISTINCT 之后
SELECT
    DISTINCT nullable_col
FROM
    (
    SELECT NULL nullable_col
    UNION ALL
    SELECT NULL nullable_col
    UNION ALL
    SELECT NULL nullable_col
    ) t;
```



`DISTINCT` 子句的用法要点如下：

- `SELECT DISTINCT` 返回一个没有重复行的结果集。
- `DISTINCT` 后面可以指定一个列或者多个列，也可以用 `*`。
- `DISTINCT` 将所有的 `NULL` 视为相等的，并只保留一个。
- `DISTINCT ON` 子句用来返回每组重复值的第一个行。





### IN 运算符语法

检查一个值是否位于一个值列表之内

```sql
expr IN (value1, value2, ...)

# 或
expr IN (subquery)
```

- `expr` 可以是一个字段名、值或其他的表达式（比如函数调用、运算等）。
- `(value1, value2, ...)` 是一个值列表，多个值之间使用 `,` 分隔，并使用小括号 `()` 将它们包围起来。
- `value1` 是具体的值，ke 比如：`1`, `2`, `'A'`, `'B'` 等。
- `subquery` 是一个只返回一个列的[子查询](https://www.sjkjc.com/postgresql/subquery/)。

如果值列表或者子查询返回的值中包含了 `expr`，`IN` 运算符返回真，否则它返回假。

IN` 运算符的否定操作是 `NOT IN



`IN` 表达式都可以使用 `OR` 运算符改写

```sql
val IN (1, 2, 3)

# 等同于如下使用 OR 的表达式
val = 1 OR val = 2 OR val = 3

# 同理，NOT IN 表达式都可以使用 AND 运算符改写
val NOT IN (1, 2, 3)

# 等同于如下使用 AND 的表达式
val <> 1 AND val <> 2 OR val <> 3

```



```sql
# 从 actor 表中查询姓氏为 ALLEN 或 DAVIS 的所有演员
SELECT *
FROM actor
WHERE last_name IN ('ALLEN', 'DAVIS');


# OR改写
SELECT *
FROM actor
WHERE last_name = 'ALLEN'
  OR last_name = 'DAVIS';


# 从 film 表中检索拥有库存的影片的数量
SELECT COUNT(*)
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
  );


# EXISTS改写
SELECT COUNT(*)
FROM film f
WHERE EXISTS (
    SELECT 1
    FROM inventory i
    WHERE i.film_id = f.film_id
  );
```



### BETWEEN区间检查

**格式**

```sql
# 要检查一个值是否位于一个值区间之内
expr BETWEEN low_value AND high_value;


# BETWEEN 运算符相当于以下使用了 大于等于 (>=) 和 小于等于 (<=) 运算符的语句
expr >= low_value AND expr <= high_value

# 在 WHERE 子句中使用 BETWEEN 运算符
SELECT * FROM table_name
WHERE expr >= low_value AND expr <= high_value


# 结合 NOT 运算符和 BETWEEN 运算符以检查一个值是否不在一个指定的值区间之内
expr NOT BETWEEN low_value AND high_value;
# 相当于以下使用了 大于 (>) 和 小于 (<) 运算符的语句
expr < low_value OR expr > high_value
```

- `expr` 是一个表达式或者列名。
- `low_value` 是值区间的开始， `high_value` 是值区间的结束。
- 如果 `expr` 的值大于或等于 `low_value` 值并且小于或等于 `high_value` 值， `BETWEEN` 运算符返回真，否则返回假





```sql
# 从 film 表中检索影片时长在在 95 到 98 分钟之间的影片
SELECT
    title, length
FROM
    film
WHERE
    length BETWEEN 95 AND 98;

# 从 film 表中检索租金在 3 到 5 美元之间的影片的数量
SELECT
    count(*)
FROM
    film
WHERE
    rental_rate BETWEEN 3 AND 5;

# 从 film 表中检索租金不在 3 到 5 美元之间的影片的数量
SELECT
    count(*)
FROM
    film
WHERE
    rental_rate NOT BETWEEN 3 AND 5;

# 从 payment 表中检索金额在 5 到 5.98 之间的付款
SELECT
    customer_id,
    amount,
    payment_date
FROM
    payment
WHERE
    amount BETWEEN 5 AND 5.98;

# 从 payment 表中检索付款日期介于在 2005-05-24 到 2005-05-25 之间的付款
SELECT
    customer_id,
    amount,
    payment_date
FROM
    payment
WHERE
    payment_date BETWEEN '2005-05-24' AND '2005-05-25';
```



### LIKE模糊匹配

`LIKE` 运算符是一个布尔运算符，用来检查一个文本是否与指定的模式匹配。如果文本与指定的模式匹配，则 `LIKE` 运算符返回真，否则它返回假

`ILIKE` 运算符是 `LIKE` 运算符的不区分大小写版本，`ILIKE` 运算符执行不区分大小写的匹配

```sql
expr LIKE pattern
expr ILIKE pattern
```

- `expr` 可以是一个字段名、值或其他的表达式（比如函数调用、运算等）。 `expr` 应该是文本。
- `pattern` 是一个字符串模式。它支持两个通配符： `%` 和 `_`。
  - `%` 匹配零或多个任意字符。
  - `_` 匹配单个任意字符。
  - 如果需要匹配通配符，则需要使用 `\` 转义字符，如 `\%` 和 `\_`。
  - 比如：
    - `a%` 匹配以字符 `a` 开头的任意长度的字符串。
    - `%a` 匹配以字符 `a` 结尾的任意长度的字符串。
    - `%a%` 匹配包含字符 `a` 的任意长度的字符串。
    - `%a%b%` 匹配同时包含字符 `a` 和 `b` 且 `a` 在 `b` 前面的任意长度的字符串。
    - `a_` 匹配以字符 `a` 开头长度为 2 字符串。
    - `_a` 匹配以字符 `a` 结尾长度为 2 字符串。

如果 `expr` 与 `pattern` 匹配，`LIKE` 运算符返回真，否则返回假。

`NOT LIKE` 是 `LIKE` 运算符的否定操作。

`NOT ILIKE` 是 `ILIKE` 运算符的否定操作。



```sql
# 当 LIKE 运算符左侧的操作数与右侧的模式匹配时，返回 t。否则，返回 f
SELECT
    'a' LIKE 'a'   "'a' LIKE 'a'",
    'a' LIKE 'a%'  "'a' LIKE 'a%'",
    'ab' LIKE 'a%' "'ab' LIKE 'a%'",
    'ab' LIKE '%a' "'ab' LIKE '%a'";

SELECT
    'a' LIKE 'a_'   "'a' LIKE 'a_'",
    'ab' LIKE 'a_'  "'ab' LIKE 'a_'",
    'abc' LIKE 'a_' "'abc' LIKE 'a_'";
    
    
# 如果 LIKE 运算符的两个操作数中任意一个为 NULL 时，返回 NULL
SELECT
    NULL LIKE 'a%' "NULL LIKE 'a%'",
    'a' LIKE NULL  "'a' LIKE NULL ";
```

```sql
# 从 actor 表中查找名字以字符 P 开头的所有演员
# 还想要匹配以小写字母 P 开头的文本，first_name ILIKE 'P%'
SELECT *
FROM actor
WHERE first_name LIKE 'P%';

# 从 actor 表中查找名字以字符 ES 结尾的所有演员
SELECT *
FROM actor
WHERE first_name LIKE '%ES';


# 从 actor 表中查找名字中带有字符串 AM 的所有演员
SELECT * FROM actor WHERE first_name LIKE '%AM%';


# 查找 first_name 以字符串 AY 结尾的且长度为 3 个字符的所有演员
SELECT * FROM actor WHERE first_name LIKE '_AY';
```



### EXISTS判断是否存在

`EXISTS` 运算符用来判断一个[子查询](https://www.sjkjc.com/postgresql/subquery/)是否返回行。如果一个子查询返回了至少一个行，则 `EXISTS` 返回真，否则返回假

```sql
WHERE EXISTS(subquery);
```

- `EXISTS` 一般用在 `WHERE` 子句中。
- `EXISTS` 是一个单目操作符，它需要一个子查询 `subquery` 作为参数。
- 如果子查询 `subquery` 返回了至少一行（不论行中的值是否为 `NULL`），则 `EXISTS` 的计算结果为 `TRUE`，否则计算结果为 `FALSE`。
- `EXISTS` 运算时，一旦子查询找到一个匹配的行，`EXISTS` 运算就会返回。这对提高查询新能很有帮助。
- `EXISTS` 不关心子查询中的列的数量或者名称，它只在乎子查询是否返回行。所以在 `EXISTS` 的子查询中，无论你是使用 `SELECT 1` 还是 `SELECT *`，亦或是 `SELECT column_list`，都不影响 `EXISTS` 运算的结果。
- `NOT EXISTS` 则是 `EXISTS` 的否定操作。





```sql
# 从 film 表中查找拥有库存记录的影片数量
# 对于影片表中的每一个影片（也就是每一行），子查询检查 inventory 以查找该影片是否有库存记录 (i.film_id = f.film_id)
SELECT
    film_id,
    title
FROM film f
WHERE
    EXISTS (
        SELECT 1
        FROM inventory i
        WHERE i.film_id = f.film_id
    );
    
# 从 film 表中查找没有库存记录的影片
SELECT
    film_id,
    title
FROM film f
WHERE
    NOT EXISTS (
        SELECT 1
        FROM inventory i
        WHERE i.film_id = f.film_id
    );
```



```sql
# 从 customer 表中查询那些至少支付了一次且金额大于 11 的客户
SELECT
    first_name,
    last_name
FROM customer c
WHERE
    EXISTS (
      SELECT 1
      FROM payment p
      WHERE p.customer_id = c.customer_id
        AND amount > 11
    )
ORDER BY first_name, last_name;
```



### IS NULL判断值是不是 NULL

```sql
expr IS NULL
expr IS NOT NULL
```

- `expr` 可以是一个字段名、一个值或者一个表达式。
- `IS NOT NULL` 是 `IS NULL` 的否定运算。



```sql
# IS NULL 运算符左侧的操作数是 NULL 时，IS NULL 运算符返回 t，否则返回 f
SELECT
    NULL IS NULL "NULL IS NULL",
    0 IS NULL "0 IS NULL",
    1 IS NULL "1 IS NULL";


# IS NOT NULL 是 IS NULL 的否定运算。如果 IS NOT NULL 左侧的操作数不是 NULL 时，IS NOT NULL 运算符返回 t，否则返回 f
SELECT
    NULL IS NOT NULL "NULL IS NOT NULL",
    0 IS NOT NULL "0 IS NOT NULL",
    1 IS NOT NULL "1 IS NOT NULL";
```



```sql
# 在 staff 表中， picture 中存储了职员的照片文件， 要从 staff 表中查询那些没有上传图片的职员， 需要检查 picture 是否为 NULL

SELECT
    first_name, last_name, picture
FROM
    staff
WHERE
    picture IS NULL;
```



### ALL比较值

 `ALL` 运算符将一个值与一个子查询返回的所有的值进行比较

有时候，您需要将一个值与一个列表中的所有值进行比较，比如：

- 给定一个工资值。您需要确认这个值是否高于所有员工的工资。
- 给定一个状态值。您需要确定这个状态值是否不等于所有状态值中的任意一个

```sql
comparison_operator ALL (array)

# 在 WHERE 子句中按照如下方式使用 ALL 运算符
# 如果子查询不返回任何行，则 ALL 运算符的计算结果始终为真
WHERE expr1 > ALL (subquery)
```

- `comparison_operator` 是一个比较运算符，例如 `=`, `!=`, `>`, `>=`, `<`, `<=` 等。
- `array` 是一个数组或者[子查询](https://www.sjkjc.com/postgresql/subquery/)，它跟在 `ALL` 运算符后面。子查询必须用括号括起来。
- 如果 `array` 中的所有值都满足指定的条件，则表达式返回真，否则表达式返回假。



- `value = ALL (array)`: 如果列表中的所有的值等于 `value`，该表达式返回 `true`, 否则返回 `false`。
- `value > ALL (array)`: 如果列表中的所有的值小于 `value`，该表达式返回 `true`, 否则返回 `false`。
- `value < ALL (array)`: 如果列表中的所有的值大于 `value`，该表达式返回 `true`, 否则返回 `false`。
- `value <> ALL (array)`: 如果列表中的所有的值不等于 `value`，该表达式返回 `true`, 否则返回 `false`



#### ALL 与数组

经常需要检查一个数组中的所有元素是否都满足指定的条件

```sql
# 检查数组 [1, 2, 3] 中的所有元素是否都等于 2
SELECT 2 = ALL(ARRAY[1, 2, 3]);

# 检查数组 [1, 2, 3] 中的所有元素是否都大于等于 1
SELECT 1 <= ALL(ARRAY[1, 2, 3]);

# 检查数组 [1, 2, 3] 中的所有元素是否都不等于 0
SELECT 0 <> ALL(ARRAY[1, 2, 3]);
```



#### ALL 与子查询

```sql
# 判断一个值 99 是否比所有的影片的租金都要高
SELECT 99 > ALL (SELECT rental_rate FROM film);

# 判断一个值 66 是否比所有的影片的租金都要小
SELECT 66 < ALL (SELECT rental_rate FROM film);


# 查找大于等于所有的租金的影片的数量
SELECT count(*)
FROM film
WHERE rental_rate >= ALL (
    SELECT rental_rate
    FROM film
  );
```



### ANY判断

`ANY` 运算符检查一个子查询返回的一组值中是否至少存在一个值满足指定的条件

需要检查一个列表中是否至少有一个满足指定条件的值，比如：

- 检查一个列表中是否包含了一个指定的值的元素。
- 检查一个列表中是否有一个大于或者小于一个指定值的元素。
- 检查一个班级的考试成绩是否有满分。



`ANY` 运算符用于将一个值与一个值列表进行比较，只要值列表中有一个值满足指定的条件就返回真，否则返回假

SOME` 操作符是 `ANY` 的同义词。 您可以使用 `SOME` 关键字代替 `ANY

```sql
# 检查一个数组中是否至少存在一个满足条件的值
comparison_operator ANY (array)
```

- `comparison_operator` 是一个比较运算符，例如 `=`, `!=`, `>`, `>=`, `<`, `<=` 等。
- `array` 是一个数组或者[子查询](https://www.sjkjc.com/postgresql/subquery/)，它跟在 `ANY` 运算符后面。子查询必须用括号括起来。
- 如果 `array` 中至少有一个值满足指定的条件，则表达式返回真，否则表达式返回假。



- `value = ANY (array)`: 只要数组中有一个等于 `value` 的值，该表达式返回 `true`, 否则返回 `false`。
- `value > ANY (array)`: 只要数组中有一个小于 `value` 的值，该表达式返回 `true`, 否则返回 `false`。
- `value < ANY (array)`: 只要数组中有一个大于 `value` 的值，该表达式返回 `true`, 否则返回 `false`。
- `value <> ANY (array)`: 只要数组中有一个不等于 `value` 的值，该表达式返回 `true`, 否则返回 `false`。



#### ANY 与数组

```sql
# 检查数组 [1, 2, 3] 是否包含一个值为 2 的元素
SELECT 2 = ANY(ARRAY[1, 2, 3]);


# 检查数组 [1, 2, 3] 是否包含一个值大于 2 的元素
SELECT 2 < ANY(ARRAY[1, 2, 3]);

# 检查数组 [1, 2, 3] 是否包含一个值大于 3 的元素
SELECT 3 < ANY(ARRAY[1, 2, 3]);

# 检查数组 [1, 2, 3] 是否包含一个值不等于 3 的元素
SELECT 3 <> ANY(ARRAY[1, 2, 3]);
```

#### ANY 与子查询

```sql
# 检查是否存在租金高于 5 美元的影片
# 子查询返回了所有影片你的租金。只要 5 小于所有租金的中的一个，则代表影片表中存在租金大于 5 美元的影片
SELECT 5 < ANY (SELECT rental_rate FROM film);


# 检查是否能用 1 美元租到影片
SELECT 1 >= ANY (SELECT rental_rate FROM film);
```



### GROUP BY分组

在 `SELECT` 语句中使用 `GROUP BY` 子句将行根据指定的字段或者表达式进行分组。

需要将结果集按照某个维度进行汇总。这在统计数据的时候经常用到，考虑以下的场景：

- 按班级求取平均成绩。
- 按学生汇总总分。
- 按年或者月份统计销售额。
- 按国家或者地区统计用户数量

```sql
SELECT column1[, column2, ...], aggregate_function(ci)
FROM table
[WHERE clause]
GROUP BY column1[, column2, ...];
[HAVING clause]
```

- `column1[, column2, ...]` 是分组依据的字段，至少一个字段，可以多个字段。
- `aggregate_function(ci)` 是聚合函数，用来汇总。这是可选的。 您可以会用到以下聚合函数：
  - [`sum()`](https://www.sjkjc.com/postgresql-ref/sum/): 计算组内数据的总和
  - [`avg()`](https://www.sjkjc.com/postgresql-ref/avg/): 计算组内数据的平均值
  - [`max()`](https://www.sjkjc.com/postgresql-ref/max/): 计算组内数据的最大值
  - [`MIN()`](https://www.sjkjc.com/postgresql-ref/min/): 计算组内数据的最小值
  - [`count()`](https://www.sjkjc.com/postgresql-ref/count/): 计算组内的行数
- [`SELECT`](https://www.sjkjc.com/postgresql/select/) 后的字段必须是分组字段中的字段。
- [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句是可选的，用来过在分组之前过滤行。
- [`HAVING`](https://www.sjkjc.com/postgresql/having/) 子句是可选的，用来过滤分组数据。



```sql
# 使用 GROUP BY 子句查看 actor 表中的姓氏列表
SELECT last_name
FROM actor
GROUP BY last_name;
```



#### GROUP BY 与聚合函数实例

使用 `GROUP BY` 子句和聚合函数 `count()` 查看 `actor` 表中的姓氏列表以及每个姓氏的数量

```sql
SELECT last_name, count(*)
FROM actor
GROUP BY last_name
ORDER BY count(*) DESC;
```

1. 首先使用 `GROUP BY` 子句按照 `last_name` 字段对 `actor` 表中的所有的行进行分组。也就是每个姓氏一组。
2. 然后使用聚合函数 `count(*)` 汇总每个姓氏的行数。
3. 最后使用 [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句按照 `count(*)` 降序排列。这样，数量最多的姓氏排在最前面



```sql
# 从 film 表中查找每个影片等级的影片数量
SELECT rating, count(*)
FROM film
GROUP BY rating
ORDER BY count(*) DESC;

# 使用LIMIT 子句和聚合函数 sum() 从 payment 表中查找消费金额排名前 10 位的客户
SELECT customer_id, sum(amount) total
FROM payment
GROUP BY customer_id
ORDER BY total DESC
LIMIT 10;
```

1. 首先使用 `GROUP BY` 子句按照 `customer_id` 字段对数据进行分组，也就是按照客户分组。
2. 然后使用聚合函数 `sum(amount)` 对每组中的所有行的 `amount` 字段求和，并使用 `total` 作为[列别名](https://www.sjkjc.com/postgresql/column-aliases/)。
3. 然后使用 `ORDER BY` 子句按照 `total` 降序排列。
4. 最后使用 `LIMIT 10` 子句返回前 10 个记录行



#### GROUP BY 和 HAVING 

```sql
# 使用HAVING 子句和聚合函数 sum() 从 payment 表中查找总消费金额在 180 美元以上的客户
SELECT customer_id, sum(amount) total
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 180
ORDER BY total DESC;
```

1. 首先使用 `GROUP BY` 子句按照 `customer_id` 字段对数据进行分组，也就是按照客户分组。
2. 然后使用聚合函数 `sum(amount)` 对每组中的所有行的 `amount` 字段求和，并使用 `total` 作为列别名。
3. 然后使用 `HAVING` 子句指定只有 `sum(amount)` 大于 `180` 的行才会被返回。
4. 最后使用 `ORDER BY` 子句按照 `total` 降序排列



### Having 分组后过滤

`HAVING` 子句用于为带有 `GROUP BY` 子句的分组查询指定过滤条件。

`HAVING` 看起来与 `WHERE` 相似，虽然他们都是指定过滤条件，但是他们的区别是： `WHERE` 子句指定的条件用于过滤表中的行，而 `HAVING` 子句指定的条件用于过滤分组

```sql
# HAVING 子句必须与 GROUP BY 子句一起使用
SELECT column1[, column2, ...], aggregate_function(ci)
FROM table
[WHERE clause]
GROUP BY column1[, column2, ...];
HAVING clause
```

- `GROUP BY` 子句用于指定用于分组的列或者表达式。
- `HAVING` 子句用来过滤 `GROUP BY` 分组的数据，需要使用逻辑表达式作为条件，其中逻辑表达式中的列名或表达式只能使用分组使用的列，表达式，或者应用于分组列或表达式的聚合函数。
- 不能在 `HAVING` 子句中使用列别名



```sql
# 从 film 表中查找每个影片评级的影片数量
SELECT rating, count(*)
FROM film
GROUP BY rating
ORDER BY count(*) DESC;


# 想要查找影片数量大于 200 的影片评级，就要用到 HAVING 子句
SELECT rating, count(*)
FROM film
GROUP BY rating
HAVING count(*) > 200
ORDER BY count(*) DESC;
```



#### 带SUM函数的Having

```sql
# 从 payment 表中查找总消费金额在 180 美元以上的客户
SELECT customer_id, sum(amount) total
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 180
ORDER BY total DESC;
```

1. 首先使用 `GROUP BY` 子句按照 `customer_id` 字段对数据进行分组，也就是按照客户分组。
2. 然后使用聚合函数 `sum(amount)` 对每组中的所有行的 `amount` 字段求和，并使用 `total` 作为列别名。
3. 然后使用 `HAVING` 子句指定只有 `sum(amount)` 大于 `180` 的行才会被返回。
4. 最后使用 `ORDER BY` 子句按照 `total` 降序排列





### GROUPING SETS生成多个维度的报表

`ROUPING SETS` 是 `GROUP BY` 子句的参数，允许在一次查询中生成多个维度的报表。

比如，要想在一个销售报表中即有每个年份销售额的行，又有每个部门销售额的行，可以在 `GROUP BY` 子句中使用 `GROUPING SETS` 实现它

```sql
SELECT ...
FROM table_name
[WHERE ...]
GROUP BY
  GROUPING SETS (
    (group_expr_list_1)
    [, (group_expr_list_2), ...]
  )
;
```

- `GROUPING SETS` 是 `GROUP BY` 子句的参数，它必须在 `GROUP BY` 关键字的后面。
- `(group_expr_list_N)` 是一个用于分组的表达式列表，其中可以包含零个或者多个列或表达式，就像在 `GROUP BY` 子句中直接使用的那些列一样。
- 您可以为 `GROUPING SETS` 指定一个或者多个分组表达式，每个分组表达式产生的结果集都将合并到最终的结果集中。
- `(group_expr_list_N)` 中没有任何列或者表达式时，即 `()`，所有符合条件的行都被聚合到一个分组中



```sql
# 从 film 表中查找每个影片评级的影片数量
SELECT rating, count(*)
FROM film
GROUP BY rating
ORDER BY rating;

# 从 film 表中查找每个租金的影片数量
SELECT rental_rate, count(*)
FROM film
GROUP BY rental_rate
ORDER BY rental_rate;


# 要想在一个报表中包含上面的两个报表，您可以使用 UNION ALL 将上面的两个结果集合并起来
SELECT rating, NULL rental_rate, count(*)
FROM film
GROUP BY rating

UNION ALL

SELECT NULL rating, rental_rate, count(*)
FROM film
GROUP BY rental_rate
ORDER BY rating, rental_rate;
```



```sql
# 以上简化方案
# 将 GROUPING SETS 简单的理解为对多个分组结果集执行了 UNION ALL 操作
SELECT rating, rental_rate, count(*)
FROM film
GROUP BY GROUPING SETS ((rating), (rental_rate))
ORDER BY rating, rental_rate;

# 想在上面的报表中添加一行以显示总影片数量，您可以在 GROUPING SETS 中是一个空的分组表达式 ()
SELECT rating, rental_rate, count(*)
FROM film
GROUP BY GROUPING SETS ((rating), (rental_rate), ())
ORDER BY rating, rental_rate;
```



### `ROLLUP` 在Group By后一次查询中生成多个维度的报表

`GROUP BY` 子句中使用 `ROLLUP` 以在一次查询中生成多个维度的报表。

在 PostgreSQL 中， `ROLLUP` 是 `GROUP BY` 子句的参数，允许您在一次查询中生成多个维度的报表。 在某些特定的场景下， `ROLLUP` 可以简化 [`GROUPING SETS`](https://www.sjkjc.com/postgresql/grouping-sets/)

```sql
SELECT ...
FROM table_name
[WHERE ...]
GROUP BY
  ROLLUP (
    group_expr_1
    [, group_expr_2, ...]
  )
;
```



`ROLLUP` 是 `GROUP BY` 子句的参数，它必须在 `GROUP BY` 关键字的后面。

`ROLLUP` 子句都可以使用 `GROUPING SETS` 子句实现，比如：

- `ROLLUP(a, b)` 等效于 `GROUPING SETS((a,b), (a), ())`。
- `ROLLUP(a, b, c)` 等效于 `GROUPING SETS((a,b,c), (a,b), (a), ())`。

`ROLLUP` 子句比 `GROUPING SETS` 子句更加的简单和易读。但是，它的的适应性不如 `GROUPING SETS` 广泛



```sql
# 从 film 表中查找每个影片评级中每个租金的影片的数量，以及每个影片评级中的影片的数量，以及所有影片的总数量
SELECT
  rating,
  rental_rate,
  count(*)
FROM
  film
GROUP BY
  GROUPING SETS (
    (rating, rental_rate),
    (rating),
    ()
  )
ORDER BY
  rating, rental_rate;
```

在 `GROUPING SETS` 中使用了 3 个表达式，如下：

- `(rating, rental_rate)`: 按照影片评级和租金统计影片的数量。
- `(rating)`: 按照影片评级统计数量。
- `()`: 统计所有影片的数量

```sql
# GROUPING SETS 可以使用 ROLLUP 来简化
# 使用 ROLLUP (rating, rental_rate) 代替了 GROUPING SETS ((rating, rental_rate), (rating), ())。这让语句更加简单，可读性更好
SELECT
  rating,
  rental_rate,
  count(*)
FROM
  film
GROUP BY
  ROLLUP (rating, rental_rate)
ORDER BY
  rating, rental_rate;
```



### CUBE

 `GROUP BY` 子句中使用 `CUBE` 以在一次查询中生成多个维度的报表。

在 PostgreSQL 中， `CUBE` 是 `GROUP BY` 子句的参数，允许您在一次查询中生成多个维度的报表。和 [`ROLLUP`](https://www.sjkjc.com/postgresql/rollup/) 一样， 在某些特定的场景下， `CUBE` 可以简化 [`GROUPING SETS`](https://www.sjkjc.com/postgresql/grouping-sets/)

```sql
SELECT ...
FROM table_name
[WHERE ...]
GROUP BY
  CUBE (
    group_expr_1
    [, group_expr_2, ...]
  )
;
```

 `CUBE` 是 `GROUP BY` 子句的参数，它必须在 `GROUP BY` 关键字的后面。

`CUBE` 子句都可以使用 `GROUPING SETS` 子句实现，比如：

- `CUBE(a, b)` 等效于 `GROUPING SETS((a,b), (a), (b), ())`。
- `CUBE(a, b, c)` 等效于 `GROUPING SETS((a,b,c), (a,b), (a,c), (a), (b,c), (b), (c), ())`。

`CUBE` 子句比 `GROUPING SETS` 子句更加的简单和易读。但是，它的的适应性不如 `GROUPING SETS` 广泛



```sql
# 从 film 表中查找每个影片评级中每个租金的影片的数量，每个影片评级中的影片的数量，每个租金的影片的数量，以及所有影片的总数量
SELECT
  rating,
  rental_rate,
  count(*)
FROM
  film
GROUP BY
  GROUPING SETS (
    (rating, rental_rate),
    (rating),
    (rental_rate),
    ()
  )
ORDER BY
  rating, rental_rate;
```

`GROUPING SETS` 使用了 3 个表达式，如下：

- `(rating, rental_rate)`: 按照影片评级和租金统计影片的数量。
- `(rating)`: 按照影片评级统计数量。
- `(rental_rate)`: 按照租金统计数量。
- `()`: 统计所有影片的数量

```sql
# 使用 CUBE 来简化
SELECT
  rating,
  rental_rate,
  count(*)
FROM
  film
GROUP BY
  CUBE (rating, rental_rate)
ORDER BY
  rating, rental_rate;
```



### Join多表连接查询

连接语句，包括交叉连接、内连接、自然连接、左连接、右连接、全连接。

在 PostgreSQL 中，`JOIN` 语句用于将数据库中的两个表或者多个表连接起来。

比如在一个学校系统中，有一个学生信息表和一个学生成绩表。这两个表通过学生 ID 字段关联起来。当我们要查询学生的成绩的时候，就需要连接两个表以查询学生信息和成绩

PostgreSQL 支持以下类型的连接：

- 交叉连接 (`CROSS JOIN`)
- 内联接 (`INNER JOIN`)
- 自然连接 (`NATURAL JOIN`)
- 左连接/左外连接 (`LEFT [OUTER] JOIN`)
- 右连接/右外连接 (`RIGHT [OUTER] JOIN`)
- 全连接/全外连接 (`RIGHT [OUTER] JOIN`)



```sql
# 创建表 student 和 student_score
CREATE TABLE student (
  student_id INTEGER NOT NULL,
  name varchar(45) NOT NULL,
  PRIMARY KEY (student_id)
);

CREATE TABLE student_score (
  student_id INTEGER NOT NULL,
  subject varchar(45) NOT NULL,
  score INTEGER NOT NULL
);
```

```sql
# 插入数据
INSERT INTO
  student (student_id, name)
VALUES
  (1,'Tim'),(2,'Jim'),(3,'Lucy');

INSERT INTO
  student_score (student_id, subject, score)
VALUES
  (1,'English',90),
  (1,'Math',80),
  (2,'English',85),
  (5,'English',92);
```

- `student` 表中 `student_id` 为 3 的学生没有成绩。
- `student_score` 表中的最后一行的 `student_id` 为 `5`，而 `student` 表中不存在 `student_id` 为 `5` 的学生



#### 交叉连接

交叉连接返回两个集合的笛卡尔积。也就是两个表中的所有的行的所有可能的组合。这相当于内连接没有连接条件或者连接条件永远为真。

如果一个有 `m` 行的表和另一个有 `n` 行的表，它们交叉连接将返回 `m * n` 行。

在大多数场景下，交叉连接的结果没有意义，你需要使用 [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句过滤自己所需的数据行。

显式的交叉连接 `student` 和 `student_score` 表：

```sql
SELECT
  student.*,
  student_score.*
FROM
  student CROSS JOIN student_score;
 
 
# 隐式的交叉连接 student 和 student_score 表
SELECT
  student.*,
  student_score.*
FROM
  student, student_score;
```



#### 内连接

内连接基于连接条件组合两个表中的行。内连接相当于加了过滤条件的交叉连接。

内连接将第一个表的每一行与第二个表的每一行进行比较，如果满足给定的连接条件，则将两个表的行组合在一起作为结果集中的一行。

![](https://www.sjkjc.com/postgresql/join/inner-join.png)

```sql
# 将 student 表和 student_score 表内连接，以查找有效的学生成绩信息
SELECT
  student.*,
  student_score.*
FROM
  student
  INNER JOIN student_score
  ON student.student_id = student_score.student_id;

# 等同于
SELECT
  student.*,
  student_score.*
FROM
  student, student_score
WHERE
  student.student_id = student_score.student_id;
# student 表中 student_id 为 3 的行和 student_score 表中 student_id 为 5 的行没有出现在输出结果中，这是因为他们没有满足连接条件：student.student_id = student_score.student_id

# 由于两个表都使用相同的字段进行等值比较，因此可以使用 USING 以下查询中所示的子句
SELECT
  student.*,
  student_score.*
FROM
  student
  INNER JOIN student_score USING(student_id);
```



#### 自然连接

自然连接同样是基于条件的连接，它是一种特殊的内连接。两个表做自然连接时，两个表中所有同名的列都将做等值比较。这些连接条件都是隐式创建的。

以下 SQL 语句对 `student` 表和 `student_score` 做自然连接，等效于上面的内连接语句

自然连接不需要使用 `ON` 创建连接条件，它的连接条件是隐式创建的。 自然连接的结果集中，两个表中同名的列只出现一次

```sql
SELECT
  *
FROM
  student NATURAL JOIN student_score;
```

#### 左连接

左连接是左外连接的简称，左连接需要连接条件。

两个表左连接时，第一个表称为左表，第二表称为右表。例如 `A LEFT JOIN B`，`A` 是左表，`B` 是右表。

左连接以左表的数据行为基础，根据连接条件匹配右表的每一行，如果匹配成功则将左表和右表的行组合成新的数据行返回；如果匹配不成功则将左表的行和 NULL 值组合成新的数据行返回

![](https://www.sjkjc.com/postgresql/join/left-join.png)

```sql
# 将 student 表和 student_score 表左连接
SELECT
  student.*,
  student_score.*
FROM
  student
  LEFT JOIN student_score
  ON student.student_id = student_score.student_id;
```

1. 结果集中包含了 `student` 表的所有记录行。
2. `student_score` 表中不包含 `student_id = 3` 的记录行，因此结果集中最后一行中来自 `student_score` 的列的内容为 `NULL`。
3. `student_score` 表存在多个 `student_id` 为 `1` 的行，因此结果集中也产生了多个来自 `student` 表对应的行

由于两个表都使用相同的字段进行等值比较，因此可以使用 `USING` 以下查询中所示的子句

```sql
SELECT
  student.*,
  student_score.*
FROM
  student
  LEFT JOIN student_score USING(student_id);
```

#### 右连接

右连接是右外连接的简称，右连接需要连接条件。

右连接与左连接处理逻辑相反，右连接以右表的数据行为基础，根据条件匹配左表中的数据。如果匹配不到左表中的数据，则左表中的列为 `NULL` 值。



![表示 A 表和 B 表之间的右连接的维恩图](https://www.sjkjc.com/postgresql/join/right-join.png)

```sql
# 将 student 表和 student_score 表右连接
SELECT
  student.*,
  student_score.*
FROM
  student
  RIGHT JOIN student_score
  ON student.student_id = student_score.student_id;
```

由于左表中不存在到与右表 `student_id = 5` 匹配的记录，因此最后一行左表的列的值为 `NULL`。

右连接其实是左右表交换位置的左连接，即 `A RIGHT JOIN B` 就是 `B LEFT JOIN A`，因此右连接很少使用。

上面例子中的右连接可以转换为下面的左连接

```sql
SELECT
  student.*,
  student_score.*
FROM
  student_score
  LEFT JOIN student
  ON student.student_id = student_score.student_id;
```

#### 全连接

全连接是全外连接的简称，它是左连接和右连接的并集。全连接需要连接条件。



![表示 A 表和 B 表之间的全连接的维恩图](https://www.sjkjc.com/postgresql/join/full-join.png)

```sql
# 将 student 表和 student_score 表全连接
SELECT
  student.*,
  student_score.*
FROM
  student
  FULL JOIN student_score
  ON student.student_id = student_score.student_id;

# 由于两个表都使用相同的字段进行等值比较，因此可以使用 USING 以下查询中所示的子句
SELECT
  student.*,
  student_score.*
FROM
  student
  FULL JOIN student_score USING(student_id);
  
# 全连接是左连接和右连接的并集。 上面的全连接可以使用 LEFT JOIN, RIGHT JOIN, 和 UNION 改写
SELECT
  student.*,
  student_score.*
FROM
  student
  LEFT JOIN student_score USING(student_id)

UNION

SELECT
  student.*,
  student_score.*
FROM
  student
  RIGHT JOIN student_score  USING(student_id);
```



### 子查询

子查询是嵌套在另一个查询中的查询，也被称为内部查询。

通常情况下，我们会使用子查询构建更复杂的 SQL 语句。比如，您可以将子查询使用在 `EXISTS`, `IN`, `ANY`, `ALL` 等表达式中，也可以将子查询的结果直接和值比较

#### EXISTS运算符方式

```sql
# language 表查找那些在 film 表中用到的语言
SELECT *
FROM language
WHERE EXISTS(
    SELECT *
    FROM film
    WHERE film.language_id = language.language_id
  );
```

#### IN运算符方式

`IN` 运算符也需要一个集合作为操作数，因此也可以使用 子查询 作为 `IN` 运算符右侧的操作数。

比如，可以使用如下带有 `IN` 运算符和子查询的语句达到上面的目的

```sql
SELECT *
FROM language
WHERE language_id in(
    SELECT DISTINCT language_id
    FROM film
  );
```

#### 子查询直接和值进行比较

```sql
# 计算租金高于平均租金的影片的数量
SELECT count(*)
FROM film
WHERE rental_rate > (
    SELECT avg(rental_rate)
    FROM film
  );
```



### UNION合并结果集

`UNION` 是一个集合运算符，它返回两个集合的并集，它用于合并两个结果集。

其他的集合操作运算符还有： [`EXCEPT`](https://www.sjkjc.com/postgresql/except/) 和 [`INTERSECT`](https://www.sjkjc.com/postgresql/intersect/)

```sql
# 要合并两个结果集，请按照以下语法使用使用 UNION 运算符
SELECT_statement_1
UNION [ALL]
SELECT_statement_2
[ORDER BY ...];


# 也可以同时合并多个结果集
SELECT_statement_1
UNION [ALL]
SELECT_statement_2
UNION [ALL]
SELECT_statement_3
UNION [ALL]
...
[ORDER BY ...];
```

- `SELECT_statement_N` 都是个独立 `SELECT` 语句。
- 参与 `UNION` 运算的所有的结果集应该具有相同的列，并且列的数据类型和顺序应该相同。
- `UNION` 与 `UNION ALL` 具有不同的逻辑：
  - `UNION` 合并两个结果集，并删除重复的行。
  - `UNION ALL` 合并两个结果，保留所有的行。
- [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句用于对最终结果进行排序，它是可选的



使用 [`generate_series()`](https://www.sjkjc.com/postgresql-ref/generate_series/) 函数用来生成结果集

```sql
# 需要用到两个结果集，先看第一个结果集
SELECT generate_series(1, 5);


# 看一下第二个结果集
SELECT generate_series(3, 6);


# 对两个结果集进行 UNION 运算
SELECT generate_series(1, 5)
UNION
SELECT generate_series(3, 6)
ORDER BY generate_series;

# UNION 运算符合并了第一个结果集和第二个结果集后删除了其中的重复的行，并返回了合并后的所有行。

# 如果不想要删除重复的行，请使用 UNION ALL 运算符
SELECT generate_series(1, 5)
UNION ALL
SELECT generate_series(3, 6)
ORDER BY generate_series;
```



### INTERSECT计算两个结果集的交集

`INTERSECT` 是一个集合运算符，它返回两个集合的交集。也就是说，它返回那些同时位于两个结果集中的行。

其他的集合操作运算符还有： [`UNION`](https://www.sjkjc.com/postgresql/union/) 和 [`EXCEPT`](https://www.sjkjc.com/postgresql/except/)

```sql
# 要计算两个结果集的交集，请按照以下语法使用使用 INTERSECT 运算符
SELECT_statement_1
INTERSECT
SELECT_statement_2
[ORDER BY ...];


# 也可以同时计算多个结果集的交集
SELECT_statement_1
INTERSECT
SELECT_statement_2
INTERSECT
SELECT_statement_3
INTERSECT
...
[ORDER BY ...];
```



- `SELECT_statement_N` 都是个独立 `SELECT` 语句。
- 参与 `INTERSECT` 运算的所有的结果集应该具有相同的列，并且列的数据类型和顺序应该相同。
- [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句用于对最终结果进行排序，它是可选的



使用 [`generate_series()`](https://www.sjkjc.com/postgresql-ref/generate_series/) 函数用来生成结果集

```sql
# 第一个结果集
SELECT generate_series(1, 5);

# 第二个结果集
SELECT generate_series(3, 6);


# 对两个结果集进行 INTERSECT 运算
SELECT generate_series(1, 5)
INTERSECT
SELECT generate_series(3, 6)
ORDER BY generate_series;
# INTERSECT 运算符返回了第一个集合和第二个集合的共有的行
```



### EXCEPT 运算符对两个结果集做减法

 `EXCEPT` 是一个集合运算符，它用于从一个集合中减去出现在另外一个集合中的行。

其他的集合操作运算符还有： [`UNION`](https://www.sjkjc.com/postgresql/union/) 和 [`INTERSECT`](https://www.sjkjc.com/postgresql/intersect/)

```sql
# 要从一个结果集中减去另一个结果集，请按照以下语法使用 EXCEPT 运算符
SELECT_statement_1
EXCEPT
SELECT_statement_2
[ORDER BY ...];


# 也可以减去多个结果集
SELECT_statement_1
EXCEPT
SELECT_statement_2
EXCEPT
SELECT_statement_3
EXCEPT
...
[ORDER BY ...];
```

- `SELECT_statement_N` 都是个独立 `SELECT` 语句。
- 参与 `EXCEPT` 运算的所有的结果集应该具有相同的列，并且列的数据类型和顺序应该相同。
- [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句用于对最终结果进行排序，它是可选的

```sql
SELECT generate_series(1, 5)
EXCEPT
SELECT generate_series(3, 6);
```



[`generate_series()`](https://www.sjkjc.com/postgresql-ref/generate_series/) 函数用来生成结果集

```sql
# 第一个结果集
SELECT generate_series(1, 5);

# 第二个结果集
SELECT generate_series(3, 6);

# EXCEPT 运算符从第一个结果集中的所有的行中删除同时位于第二个结果集中的行，并返回了第一个结果集中剩下的行
```

```sql
# 从影片表 film 中获取评级为 G 的影片
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE rating = 'G';

# 从影片表 film 中获取评级为 G 的影片，但是不包括那些影片长度大于 55 分钟的影片
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE rating = 'G'
EXCEPT
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE length > 55;


# 从影片表 film 中获取评级为 G 的影片，但是不包括那些影片长度大于 55 分钟的影片，还不包括那些租金大于 2.99 美元的影片
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE rating = 'G'
EXCEPT
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE length > 55
EXCEPT
SELECT film_id, title, rating, length, rental_rate
FROM film WHERE rental_rate >= 2.99;
```







### CTE

通用表表达式，简称为 CTE，它提供了一种语句级别的临时表的功能，以帮助你构建复杂但是清晰的 SQL 语句

通用表表达式使用 `WITH` 关键字定义

```sql
WITH [RECURSIVE] cte_name [(cte_column_list)] AS (
    cte_definition
)
primary_statement;
```

- 通用表表达式以 `WITH` 关键字开始。
- `RECURSIVE` 关键字表示此通用表表达式是可递归查询的。它是可选的。
- `cte_name` 是通用表表达式是的名称，相当于临时表的表名。
- `cte_column_list` 是通用表表达式的列名的列表，多个列名使用逗号分隔。 它是可选的。
- `cte_definition` 是通用表表达式的辅助语句，它可以是 [`SELECT`](https://www.sjkjc.com/postgresql/select/), [`INSERT`](https://www.sjkjc.com/postgresql/insert/), [`UPDATE`](https://www.sjkjc.com/postgresql/update/), 或者 [`DELETE`](https://www.sjkjc.com/postgresql/delete/) 语句。
- `primary_statement` 是主要语句，它会用到上面 `WITH` 中定义的通用表表达式。 它可以是 `SELECT`, `INSERT`, `UPDATE`, 或者 `DELETE`

```sql
# 想要确定每个影片的租金是否比它坐在的评级的平均租金高
WITH file_rating_avg AS (	# 通用表表达式，名称为 file_rating_avg;file_rating_avg 作为一个临时表
  SELECT
    rating,
    avg(rental_rate) avg_rental_rate
  FROM film
  GROUP BY rating
)
SELECT
  f.film_id,
  f.title,
  f.rental_rate,
  a.avg_rental_rate,
  f.rental_rate > avg_rental_rate "Greater?"
FROM
  film f,
  file_rating_avg a
WHERE f.rating = a.rating
LIMIT 10;
```



#### 通用表表达式递归查询

通用表表达式支持递归查询，这很适合应用在一些存储树形数据的方案中，比如产品的分类、系统的导航菜单等。

接下来，设计一个用于保存产品分类的表，然后使用 PostgreSQL 通用表表达式获取一个指定分类以及该分类下的所有的下级分类

```sql
# 创建数据库
CREATE DATABASE testdb;

# 创建产品分类表 category
DROP TABLE IF EXISTS category;
CREATE TABLE category (
  id SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  parent_id INT,
  CONSTRAINT fk_category
    FOREIGN KEY(parent_id) REFERENCES category(id)
);

# 插入信息
INSERT INTO category (id, name, parent_id)
VALUES
  (1, 'ROOT', NULL),
  (2, 'Baby', 1),
  (3, 'Home And Kitchen', 1),
  (4, 'Baby Care', 2),
  (5, 'Feeding', 2),
  (6, 'Gifts', 2),
  (7, 'Safety', 2),
  (8, 'Bedding', 3),
  (9, 'Bath', 3),
  (10, 'Furniture', 3),
  (11, 'Grooming', 4),
  (12, 'Hair Care', 4),
  (13, 'Baby Foods', 5),
  (14, 'Food Mills', 5),
  (15, 'Solid Feeding', 5),
  (16, 'Bed Pillows', 8),
  (17, 'Bed Skirts', 8);
```

```sql
# 想要查询 id 为 2 的分类以及它的所有的下级分类
WITH RECURSIVE cte_categories AS (
  SELECT
    id,
    name,
    parent_id
  FROM category
  WHERE id = 2
  UNION
  SELECT
    c.id,
    c.name,
    c.parent_id
  FROM category c, cte_categories cs
  WHERE cs.id = c.parent_id
)
SELECT *
FROM cte_categories;

```





### 列别名

```sql
SELECT expr AS alias_name
[FROM table_name];


# 设置多列别名
SELECT
   expr1 AS alias_name1,
   expr2 AS alias_name2,
   ...
[FROM table_name];

```

- `expr` 是一个表达式或者列名。
- `alias_name` 是 `expr` 列的别名。 `SELECT` 语句返回的结果集中将使用别名。
- 如果列别名中包含空格，请使用双引号 `"` 将列别名包围起来。
- `AS` 是一个关键字，它是可选的。您可以省略它。



从 [`actor`](https://www.sjkjc.com/sakila/table-film/) 表中检索演员的名字和姓氏

```sql
SELECT
   first_name,
   last_name
FROM actor
LIMIT 10;


# 要为 last_name 指定一个别名 surname
SELECT
   first_name,
   last_name AS surname
FROM
   actor
LIMIT 10;

# 从 actor 表中检索演员的全名
# 使用了 || 操作符连接两个字符串。 表达式 first_name || ' ' || last_name 将 first_name, 空格 和 last_name 连接在一起
# 但输出列名?column?，这是没有意义的
SELECT
   first_name || ' ' || last_name
FROM
   actor
LIMIT 10;


# 可以为表达式分配 first_name || ' ' || last_name 一个列别名，例如 full_name
SELECT
    first_name || ' ' || last_name full_name
FROM
    actor
LIMIT 10;


# 包含空格的列别名
# 要使用 Full Name 作为列别名，因为它包含了空格，使用双引号引用起来
SELECT
    first_name || ' ' || last_name "Full Name"
FROM
    actor
LIMIT 10;

```



### 表别名

除了可以为列指定别名，也可以为表指定别名。使用表别名一般处于以下的目的：

- 表别名可以提高 SQL 语句的可读性。
- 表别名可以为书写 SQL 的带来便利。
- 表别名可以解决不同表具有相同列名时可能带来的冲突

**格式**

```sql
table_name [AS] table_alias;
```

- `table_alias` 是表 `table_name` 的别名。
- 如果表别名中包含空格，使用双引号 `"` 将别名包围起来。不过大多数情况下，使用表别名是为了简化，不建议使用带有空格的表别名。
- `AS` 关键字是可选的，它可以被省略



```sql
# 从 film 表中查找没有库存记录的影片
SELECT
    f.film_id,
    f.title
FROM film f
WHERE
    NOT EXISTS (
        SELECT 1
        FROM inventory i
        WHERE i.film_id = f.film_id
    );
```



### CASE逻辑处理

`CASE` 表达式是一个条件表达式，它与其他编程语言中的 if-else 语句作用相同。

您可以在 [`SELECT`](https://www.sjkjc.com/postgresql/select/) 语句以及 [`WHERE`](https://www.sjkjc.com/postgresql/where/), [`GROUP BY`](https://www.sjkjc.com/postgresql/group-by/), 和 [`HAVING`](https://www.sjkjc.com/postgresql/having/) 子句中使用 `CASE` 表达式

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE value3
END
```

- `condition1`, `condition2` 是一些布尔表达式，返回值为 `true` 或 `false`。
- 这个表达式可以理解为：如果 `condition1` 为真返回 `result1`，如果 `condition2` 为真返回 `result2`，否则返回 `result3`。
- 您可以指定一个或者多个 `WHEN ... THEN` 判断。
- `ELSE` 部分是可以省略的，您只能指定一个 `ELSE` 语句。
- 所有的判断从上向下依次判断，直到遇到条件为真，并返回此条件对应的值。如果没有条件为真，则返回 `ELSE` 指定的值。如果没有指定 `ELSE`，则返回 `NULL`

```sql
# 如果所有的条件都是针对同一个字段或者表达式进行等值判断，则可以将 CASE 表达式简写为如下形式
CASE expr
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE result3
END
# 如果 expr 等于 value1，则返回 result1，如果 expr 等于 value2，则返回 result2，否则返回 result3
```



**案例**

```sql
# 想要获取当前日期是星期几的名称
SELECT
  current_date "Today",
  CASE
    WHEN extract(DOW FROM current_date) = 1 THEN 'Monday'
    WHEN extract(DOW FROM current_date) = 2 THEN 'Tuesday'
    WHEN extract(DOW FROM current_date) = 3 THEN 'Wednesday'
    WHEN extract(DOW FROM current_date) = 4 THEN 'Thursday'
    WHEN extract(DOW FROM current_date) = 5 THEN 'Friday'
    WHEN extract(DOW FROM current_date) = 6 THEN 'Saturday'
    ELSE 'Sunday'
  END "Day of Week";
  
# 使用 current_date 获得当前的日期，并使用 extract() 函数获取当前日期的工作日编号。

# 由于上面的 CASE 表达式中的条件都是等值判断，因此我们可以将 CASE 表达式简化为
SELECT
  current_date "Today",
  CASE extract(DOW FROM current_date)
    WHEN 1 THEN 'Monday'
    WHEN 2 THEN 'Tuesday'
    WHEN 3 THEN 'Wednesday'
    WHEN 4 THEN 'Thursday'
    WHEN 5 THEN 'Friday'
    WHEN 6 THEN 'Saturday'
    ELSE 'Sunday'
  END "Day of Week";
```



#### CASE自定义排序

有时候单纯的按照字段的值排序并不能满足要求，我们需要按照自定义的顺序的排序。比如，我们需要按照电影分级 `'G', 'PG', 'PG-13', 'R', 'NC-17'` 的顺序对影片进行排序。

对于这样的需求，它可以理解为按照列表中元素的索引位置进行排序。我们使用 `CASE` 子句函数实现它。

在以下实例中，我们使用 Sakila 示例数据库中的 [`film` 表](https://www.sjkjc.com/sakila/table-film/)作为演示。

假设您要根据影片的分级按照的 `'G', 'PG', 'PG-13', 'R', 'NC-17'` 顺序对影片进行排序。 下面使用 `CASE` 表达式实现自定义排序

```sql
SELECT
    film_id, title, rating
FROM
    film
ORDER BY CASE rating
    WHEN 'G' THEN 1
    WHEN 'PG' THEN 2
    WHEN 'PG-13' THEN 3
    WHEN 'R' THEN 4
    WHEN 'NC-17' THEN 5
END;
```



# 约束

## 主键

主键是能够唯一标识表中的每一行的一个列或者多个列的组合

- 主键是定义在表上的。一个表不强制定义主键，但最多只能定义一个主键。
- 主键可以包含一个列或者多个列。
- 主键列的值必须是唯一的。如果主键包含多个列，则这些列的值组合起来必须是唯一的。
- 主键列中不能包含 `NULL` 值。

主键相当于 [`UNION`](https://www.sjkjc.com/postgresql/unique/) 约束和 [`NOT NULL`](https://www.sjkjc.com/postgresql/not-null/) 约束的组合。

如果不遵循上面的规则，则可能会引发以下的错误。

- 如果要定义了多个主键，会返回错误：`ERROR 1068 (42000): Multiple primary key defined`。
- 如果插入或者更新时有重复的主键值，则会返回类似的错误：`ERROR 1062 (23000): Duplicate entry '1' for key 'users.PRIMARY'`。
- 如果插入了 `NULL` 值，则会返回类似的错误：`ERROR 1048 (23000): Column 'id' cannot be null`。

```sql
# 创建表时定义主键
# 单列主键
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name VARCHAR(45)
);


# 多列主键
CREATE TABLE users (
  com_id INTEGER,
  user_number INTEGER,
  name VARCHAR(45),
  PRIMARY KEY(com_id, user_number)
);

# 建表后添加主键
ALTER TABLE users ADD PRIMARY KEY(id);

# 删除主键
# \d 命令查找主键约束的名称
\d users

ALTER TABLE users DROP CONSTRAINT users_pkey;
```

主键值

```sql
# 设置为 SERIAL
# 声明为 SERIAL 的列会自动生成连续的整数值
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(45)
);


# 主键列设置为 UUID 类型
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(45)
);
```



## 外键

外键用来定义两个实体之间的约束关系。外键对保证数据的完整性很有用

外键相对于主键而言，用来引用其他表。外键在子表中定义，它将子表的一个或多个列对应到父表的主键或唯一键值，将子表的行和父表行建立起关联关系。

![](https://www.sjkjc.com/postgresql/foreign-key/foreign-key-er.svg)

### 语法

```sql
# 创建表时添加外键
CREATE TABLE table_name (
  column_defination_1,
  ...
  [CONSTRAINT foreign_key_name]
    FOREIGN KEY (column)
      REFERENCES parent_table_name (column)
      ON UPDATE ...
      ON DELETE ...
;
);

# 查看city表外键约束
\d city
```

- `foreign_key_name` 是外键约束的名字。 `CONSTRAINT foreign_key_name` 是可选的。
- `FOREIGN KEY (column)` 指明了表中的 `column` 列是外键。
- `REFERENCES parent_table_name (column)` 指明了外键引用了 `parent_table_name` 表中的 `column` 列。
- `ON DELETE` 和 `ON UPDATE` 指定了删除或更新父表中的行时要采取的约束策略。你可以使用以下 5 个策略中的一个：
  - `NO ACTION`: 这是默认的策略。
  - `RESTRICT`: 如果父表中的一行在该表中有匹配的行，试图删除或更新父表中行时会引发 PostgreSQL 错误。
  - `CASCADE`：如果父表中的一行被删除或更新，该表中匹配行的值会自动删除或更新。
  - `SET NULL`：如果父表中的一行被删除或更新，该表中匹配行的值设置为 `NULL`。
  - `SET DEFAULT`: 如果父表中的一行被删除或更新，该表中匹配行的值设置为默认值

```sql
# 建表后添加外键
ALTER TABLE child_table_name
ADD [CONSTRAINT foreign_key_name]
  FOREIGN KEY (column)
    REFERENCES parent_table_name (column)
    ON UPDATE ...
    ON DELETE ...
;
```

- 使用 [`ALTER TABLE`](https://www.sjkjc.com/postgresql/alter-table/) 语句修改表的定义。
- 使用 `ADD [CONSTRAINT foreign_key_name]` 添加一个名为 `foreign_key_name` 的约束。`[CONSTRAINT foreign_key_name]` 是可选的。
- 使用 `FOREIGN KEY (column)) REFERENCES parent_table_name (column)` 定义了外键



**删除外键**

```sql
ALTER TABLE table_name DROP CONSTRAINT constraint_name;
```

### 案例

```sql
# 创建数据库
CREATE DATABASE testdb;


# 切换数据库
\c testdb

# 创建 users 表
CREATE TABLE users (
  user_id INTEGER NOT NULL,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (user_id)
);
```

#### CASCADE 策略实例

如果外键的 `ON DELETE` 和 `ON UPDATE` 使用了 `CASCADE` 策略：

- 当父表的行被删除的时候，子表中匹配的行也会被删除。
- 当父表的行的键值更新的时候，子表中匹配的行的字段也会被更新。

使用以下 SQL 创建 `user_hobbies` 表，它的外键采用 `CASCADE` 策略

```sql
DROP TABLE IF EXISTS user_hobbies;
CREATE TABLE user_hobbies (
  hobby_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL,
  PRIMARY KEY (hobby_id),
  FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
```

```sql
# 插入数据
DELETE FROM users;
DELETE FROM user_hobbies;
INSERT INTO users (user_id, name)
VALUES (1, 'Tim');
INSERT INTO user_hobbies (hobby_id, user_id, hobby)
VALUES (1, 1, 'Football'), (2, 1, 'Swimming');
```

```sql
# 将父表 users 中的键 user_id 的值从 1 修改为 100
# user_hobbies 表中与 users 表中 user_id 列中的 1 被自动修改为 100
UPDATE users
SET user_id = 100
WHERE user_id = 1;

# 父表进行 DELETE 操作
# user_hobbies 表中与 users 表中 user_id = 100 的那些行都被删除了
DELETE FROM users
WHERE user_id = 100;
```



#### RESTRICT 策略

如果外键的 `ON DELETE` 和 `ON UPDATE` 使用了 `RESTRICT` 策略：

- PostgreSQL 禁止删除父表中与子表匹配的行。
- PostgreSQL 禁止删除父表中与子表匹配的行的键的值。

使用以下 SQL 创建 `user_hobbies` 表，它的外键采用 `RESTRICT` 策略

```sql
DROP TABLE IF EXISTS user_hobbies;
CREATE TABLE user_hobbies (
  hobby_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL,
  PRIMARY KEY (hobby_id),
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);

# 插入数据
DELETE FROM users;
DELETE FROM user_hobbies;
INSERT INTO users (user_id, name)
VALUES (1, 'Tim');
INSERT INTO user_hobbies (hobby_id, user_id, hobby)
VALUES (1, 1, 'Football'), (2, 1, 'Swimming');


# 父表进行 UPDATE 操作
UPDATE users
SET user_id = 100
WHERE user_id = 1;

# ERROR:  update or delete on table "users" violates foreign key constraint "user_hobbies_user_id_fkey" on table    "user_hobbies"
# DETAIL:  Key (user_id)=(1) is still referenced from table "user_hobbies".

# 父表进行 DELETE 操作
DELETE FROM users
WHERE user_id = 1;

# ERROR:  update or delete on table "users" violates foreign key constraint "user_hobbies_user_id_fkey" on table "user_hobbies"
# DETAIL:  Key (user_id)=(1) is still referenced from table "user_hobbies".
```



#### SET NULL 策略

如果外键的 `ON DELETE` 和 `ON UPDATE` 使用了 `SET NULL` 策略：

- 当父表的行被删除的时候，子表中匹配的行的列的值被设置为 `NULL`。
- 当父表的行的键值被更新的时候，子表中匹配的行的列的值被设置为 `NULL`。

使用以下 SQL 创建 `user_hobbies` 表，它的外键采用 `SET NULL` 策略。

```sql
DROP TABLE IF EXISTS user_hobbies;
CREATE TABLE user_hobbies (
  hobby_id INTEGER NOT NULL,
  user_id INTEGER,
  hobby VARCHAR(45) NOT NULL,
  PRIMARY KEY (hobby_id),
  CONSTRAINT fk_user
    FOREIGN KEY (user_id)
    REFERENCES users (user_id)
    ON DELETE SET NULL
    ON UPDATE SET NULL
);

# 插入数据
DELETE FROM users;
DELETE FROM user_hobbies;
INSERT INTO users (user_id, name)
VALUES (1, 'Tim');
INSERT INTO user_hobbies (hobby_id, user_id, hobby)
VALUES (1, 1, 'Football'), (2, 1, 'Swimming');


# 父表进行 UPDATE 操作
# 父表中的 user_id 列的值后，user_hobbies 表中那些对应的行的 user_id 列的值被设置为 NULL
UPDATE users
SET user_id = 100
WHERE user_id = 1;


# 重新初始化数据
DELETE FROM users;
DELETE FROM user_hobbies;
INSERT INTO users (user_id, name)
VALUES (1, 'Tim');
INSERT INTO user_hobbies (hobby_id, user_id, hobby)
VALUES (1, 1, 'Football'), (2, 1, 'Swimming');

# 删除父表数据
# 删除父表中的 user_id 列的值后，user_hobbies 表中那些对应的行的 user_id 列的值被设置为 NULL
DELETE FROM users
WHERE user_id = 1;
```



## NOT NULL

`NOT NULL` 是列上的约束，它用来约束列中的值不能为 `NULL` 值。

注意， `NULL` 不是空串，也不是 `0`，它表示什么都没有。可以使用 [`IS NULL`](https://www.sjkjc.com/postgresql/is-null/) 操作符判断一个值是否是 NULL。

### 语法

```sql
# 建表创建
CREATE TABLE table_name (
  ...
  column_name data_type NOT NULL ...,
  ...
);


# 建表后添加
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;

# 删除约束
ALTER TABLE table_name
ALTER COLUMN column_name DROP NOT NULL;
```

### 案例

```sql
# 建表
DROP TABLE IF EXISTS user_hobby;
CREATE TABLE user_hobby (
  hobby_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL
);

# 插入数据
INSERT INTO user_hobby (user_id, hobby)
VALUES (1, 'Football'), (1, 'Swimming');

# 插入NULL数据
INSERT INTO user_hobby (user_id, hobby)
VALUES (1, NULL);

# ERROR:  null value in column "hobby" violates not-null constraint
# DETAIL:  Failing row contains (3, 1, null).
```

```sql
# 重新建表，允许NULL
DROP TABLE IF EXISTS user_hobby;
CREATE TABLE user_hobby (
  hobby_id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45)
);

# 插入数据
INSERT INTO user_hobby (user_id, hobby)
VALUES (1, 'Football'), (1, NULL);


# 更改不允许NULL
ALTER TABLE user_hobby
ALTER hobby SET NOT NULL;

# ERROR:  column "hobby" contains null values
# 因为其中一行的 hobby 列中的值为 NULL；如果需要更改，需要将NULL改为非NULL
```



## 唯一约束

唯一约束也是一个常用的约束，用来保证表中的一列或几列的中的值是唯一的。

我们在很多系统中都用到唯一约束约束，例如：

- 用户表中有登录名或电子邮件列是唯一的。
- 产品表中的产品编号列是唯一的。
- 订单表中有订单编号列是唯一的。
- 每天的统计报表中将 年、月、日 三个列作为组合唯一约束。

与主键相比，主键用于表示一个行的唯一性，主键的一般采用一个与业务无关的值，比如自增值，UUID 等。而唯一约束一般用于约束与业务相关的数据的唯一性。

主键列不能包含 `NULL` 值，而唯一约束列可以包含 `NULL` 值。



### 语法

```sql
# 建表是创建
CREATE TABLE table_name(
    ...,
    column_name data_type UNIQUE,
    ...
);

# 定义多列唯一约束
CREATE TABLE table_name(
   column_name1 column_definition,
   column_name2 column_definition,
   ...,
   [CONSTRAINT constraint_name]
      UNIQUE(column_name1, column_name2)
);


# 建表后添加唯一约束
ALTER TABLE table_name
ADD [CONSTRAINT constraint_name] UNIQUE (column_list);

# 删除唯一约束
ALTER TABLE table_name
  DROP CONSTRAINT constraint_name;
```

### 案例

唯一约束的两列出现了重复的 NULL 值。`NULL` 会让唯一约束失效

```sql
# 建表
DROP TABLE IF EXISTS user_hobby;
CREATE TABLE user_hobby (
  hobby_id SERIAL NOT NULL,
  user_id INTEGER NOT NULL,
  hobby VARCHAR(45) NOT NULL,
  PRIMARY KEY (hobby_id),
  CONSTRAINT unique_user_hobby
    UNIQUE(user_id, hobby)
);

# 插入数据
INSERT INTO user_hobby (user_id, hobby)
VALUES (1, 'Football'), (1, 'Swimming');

# 插入也有数据
INSERT INTO user_hobby (user_id, hobby)
VALUES (1, 'Football');

# ERROR:  duplicate key value violates unique constraint "unique_user_hobby"
# DETAIL:  Key (user_id, hobby)=(1, Football) already exists.

# 删除约束
ALTER TABLE user_hobby
  DROP CONSTRAINT unique_user_hobby;
```



## 生成列

生成列（GENERATED COLUMN）是一个特殊的列，它的值会根据列定义中的表达式自动计算得出。并且，你不能直接写入或更新生成列的值。 生成列是定义在列上的约束。

生成列有 2 种类型：

- 虚拟生成列：列值不会被存储下来。当读取该列时，该列的值会被计算。
- 存储生成列：列值会被存储下来。当插入或修改数据时，该列的值会被重新计算并存储在磁盘上

PostgreSQL 目前只支持 存储生成列，不支持 虚拟生成列。



### 语法

```sql
col_name data_type
  GENERATED ALWAYS AS (expr) STORED
```

- `GENERATED ALWAYS AS` 关键字指示此列是一个生成列。
- `expr` 是用于生成此列的值的表达式。
- `STORED` 只是此列是一个存储生成列。这是 PostgreSQL 目前唯一支持的生成列类型。

可以在通过 [`CREATE TABLE`](https://www.sjkjc.com/postgresql/create-table/) 语句创建表时定义生成列，或者通过 [`ALTER TABLE`](https://www.sjkjc.com/postgresql/alter-table/) 语句添加一个生成列



### 案例

```sql
# 建表
CREATE TABLE order_item (
  order_item_id SERIAL PRIMARY KEY,
  goods VARCHAR(45) NOT NULL,
  price DECIMAL NOT NULL,
  quantity INTEGER NOT NULL
);

# 插入数据
INSERT INTO order_item (goods, price, quantity)
VALUES ('Apple', 5, 3), ('Peach', 4, 4);

# 查找每个订单项目的总金额
# 使用 price * quantity 计算总金额，并使用了 total_amount 作为列别名
SELECT
  goods,
  price,
  quantity,
  (price * quantity) AS total_amount
FROM order_item;


# 使用生成列可以简化工作
ALTER TABLE order_item
  ADD COLUMN total_amount DECIMAL
    GENERATED ALWAYS AS (price * quantity) STORED;
```

```sql
# 不能直接写入或者更新生成列的值。这会引发错误
INSERT INTO order_item (goods, price, quantity, total_amount)
VALUES ('Banana', 6, 4, 24);

# ERROR:  cannot insert into column "total_amount"
# DETAIL:  Column "total_amount" is a generated column.

UPDATE order_item
SET total_amount = 30
WHERE goods = 'Apple';

# ERROR:  column "total_amount" can only be updated to DEFAULT
# DETAIL:  Column "total_amount" is a generated column.
```



## IDENTITY COLUMN 标识列

标识列是一个特殊的[生成列](https://www.sjkjc.com/postgresql/generated-columns/)，该列的值能自动生成并且是唯一的。标识列是定义在列上的约束。

标识列和 [`SERIAL`](https://www.sjkjc.com/postgresql/serial/) 类似，他们的内部都使用 [`SEQUENCE`](https://www.sjkjc.com/postgresql/sequences/) 实现。

不像[主键](https://www.sjkjc.com/postgresql/primary-key/)，一个表中允许存在多个标识列，并且标识列中允许存在重复的值

### 语法

```sql
col_name data_type
  GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ]
```

- 标识列的数据类型可以是：`SMALLINT`, `INT`，或 `BIGINT`。
- `GENERATED ALWAYS AS IDENTITY` 列的值不能被写入。 向此列中插入（或更新）值将会导致一个错误。有一个特殊情况，就在 `INSERT` 语句中使用 `OVERRIDING SYSTEM VALUE` 指令可以向此列插入值。
- `GENERATED BY DEFAULT AS IDENTITY` 列的值能被写入，包括插入和更新。
- `sequence_options` 指明了标识列内部使用的序列的选项。它是可选的，如果不指定，PostgreSQL 使用默认值产生一个序列。



```sql
# 建表时创建
CREATE TABLE table_name (
  column_definition,
  ...
  col_name data_type GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ],
  ...
);


# 建表后添加标识列
ALTER TABLE table_name
  ADD COLUMN col_name data_type
    GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ];


# 也有列设置为标识列
ALTER TABLE table_name
  ALTER COLUMN col_name
    ADD GENERATED { ALWAYS | BY DEFAULT } AS IDENTITY [ ( sequence_options ) ];

ALTER TABLE table_name
  ALTER COLUMN col_name
    SET GENERATED { ALWAYS | BY DEFAULT };


# 取消标识列
ALTER TABLE table_name
  ALTER COLUMN col_name
    DROP IDENTITY [ IF EXISTS ];
```



### 案例

```sql
# 创建一个表，其中 id 列是标识列
CREATE TABLE test_identity (
  id INTEGER GENERATED ALWAYS AS IDENTITY,
  txt VARCHAR(45) NOT NULL
);

# \d 命令查看 test_identity 中标识列的情况
\d test_identity


# 插入数据
INSERT INTO test_identity (txt)
VALUES ('Apple'), ('Peach');

# 使用 INSERT 向标识列中插入一个值
INSERT INTO test_identity (id, txt)
VALUES (1, 'Banana')
RETURNING *;

# ERROR:  cannot insert into column "id"
# DETAIL:  Column "id" is an identity column defined as GENERATED ALWAYS.
# HINT:  Use OVERRIDING SYSTEM VALUE to override.
# 由于 id 列带有 GENERATED ALWAYS AS IDENTITY 约束，因此不能直接插入值。按照 PostgreSQL 的提示，可以使用 OVERRIDING SYSTEM VALUE 强制插入

INSERT INTO test_identity (id, txt)
OVERRIDING SYSTEM VALUE
VALUES (1, 'Banana')
RETURNING *;
# 标识列是允许重复值的



# 一个表中可以存在多个标识列，下面的语句添加一个标识列 id_2，并且起始值为 10，每次自增 10
ALTER TABLE test_identity
  ADD COLUMN id_2 INTEGER GENERATED ALWAYS AS IDENTITY
    (START WITH 10 INCREMENT BY 10);
```



## CHECK

任何应用都对数据的正确性有要求。比如，用户的年龄必须是大于零的，用户的登录名中不能包含空格，用户的密码必须满足一定的复杂度，等等。

对于这些要求，虽然我们可以在应用界面来对用户输入的数据进行验证，但是这并不能替代数据库层面的数据验证。这能增加应用的安全性。

PostgreSQL 提供了 `CHECK` 约束来保证写入到表中的数据是符合你的要求的。不符合 `CHECK` 约束的数据会被 PostgreSQL 拒绝。

### 语法

```sql
[CONSTRAINT constraint_name]
CHECK(expr)
```

- `constraint_name` 是约束的名字。 `CONSTRAINT constraint_name` 是可选的，只有您需要指定约束名称的时候，才使用此子句。
- `expr` 是一个布尔表达式。如果表达式结算结果为真，则 PostgreSQL 允许将输入写入到表中，否则 PostgreSQL 拒绝写入数据

可以在一个列上或者一个表上使用 `CHECK` 约束。如果你为一个列使用 `CHECK` 约束，则 `CHECK` 表达式只能使用此列。如果你为一个表使用 `CHECK` 约束，则 `CHECK` 表达式可以使用表上的所有列



```sql
# 创建表
# age 列需要大于 0 
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL CHECK(age > 0)
);

# 创建表的时候在约束定义中使用 CHECK 约束
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    age INTEGER NOT NULL,
    CONSTRAINT users_age_check CHECK(age > 0)
);


# 建表后添加约束
ALTER TABLE users
ADD CONSTRAINT users_age_check CHECK(age > 0);
```

### 案例

设，需要一个 `users` 表存储用户的名称，登录名，密码，且需要符合以下要求：

1. 用户的名称不能为空。
2. 登录名的长度不少于 4 个字符。
3. 密码的长度不少于 8 个字符。
4. 密码不能和登录名相同。

注意，在实际的应用中，您不应该将密码的明文存放在数据库中，这是不安全的

```sql
# 创建表
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    login_name VARCHAR(45) NOT NULL CHECK(length(login_name) >= 4),
    password VARCHAR(45) NOT NULL CHECK(length(password) >= 8),
    CHECK(login_name <> password)
);

#  \d 命令查看表 users 上的约束
\d users
```

1. 在 `login_name` 列定义中的 `CHECK(length(login_name) >= 4)` 保证登录名的长度不小于 4。
2. 在 `password` 列定义中的 `CHECK(length(password) >= 8)` 保证登录名的长度不小于 8。
3. 在表上的约束 `CHECK(login_name <> password)` 保证密码不能和登录名相同。

```sql
# 验证登录名列的 CHECK 约束是否生效
INSERT INTO users (name, login_name, password)
VALUES ('Tim', 'tim', 'timisok');

# ERROR:  new row for relation "users" violates check constraint "users_login_name_check"
# DETAIL:  Failing row contains (1, Tim, tim, timisok).

# 验证密码列的 CHECK 约束是否生效
INSERT INTO users (name, login_name, password)
VALUES ('Tim', 'tim1', 'timisok');


# ERROR:  new row for relation "users" violates check constraint "users_password_check"
# DETAIL:  Failing row contains (2, Tim, tim1, timisok).

# 验证密码不能和登录名相同的 CHECK 约束是否生效
INSERT INTO users (name, login_name, password)
VALUES ('Tim', 'timisgood', 'timisgood');


# ERROR:  new row for relation "users" violates check constraint "users_check"
# DETAIL:  Failing row contains (3, Tim, timisgood, timisgood).
# 由于上面语句中给出的登录名和密码都是 timisgood


# 使用下面的语句插入一个完全符合 CHECK 约束的行
INSERT INTO users (name, login_name, password)
VALUES ('Tim', 'hitim', 'timisgood');

# CHECK 约束同样适用于 UPDATE 语句
UPDATE users
SET login_name = 'tim'
WHERE name = 'Tim';

# ERROR:  new row for relation "users" violates check constraint "users_login_name_check"
# DETAIL:  Failing row contains (4, Tim, tim, timisgood).
```



## SERIAL自增列

### 语法

```sql
column_name SERIAL

# SERIAL 作为一个数据类型跟在列名的后面
# SERIAL 列将自动添加 NOT NULL 约束，但不会自动成为主键列，但是您可以在列定义中使用 PRIMARY KEY 使该列成为主键列
```

```sql
# 建表时创建
CREATE TABLE table_name (
  column_name SERIAL,
  ...
);


# 建表后添加
ALTER TABLE table_name
  ADD COLUMN column_name SERIAL;
```

### SERIAL 种类

| 姓名          | 存储大小 | 取值范围                | 对应的数据类型 |
| ------------- | -------- | ----------------------- | -------------- |
| `SMALLSERIAL` | 2 bytes  | 1 - 32767               | `SMALLINT`     |
| `SERIAL`      | 4 bytes  | 1 - 2147483647          | `INTEGER`      |
| `BIGSERIAL`   | 8 bytes  | 1 - 9223372036854775807 | `BIGINT`       |

### 案例

```sql
# 创建以 id 列为 SERIAL 列的 test_serial 表
CREATE TABLE test_serial(
   id SERIAL PRIMARY KEY,
   notes VARCHAR NOT NULL
);


# 以\d查看表定义
\d test_serial
```

- `id` 列的数据类型为 `INTEGER`。
- `id` 列是一个 `NOT NULL` 列。
- `id` 列具有默认值 `nextval('test_serial_id_seq')`。 `test_serial_id_seq` 是内部序列的名称，这是由 PostgreSQL 自动生成的



```sql
# 可以通过 pg_get_serial_sequence() 函数获取此列对应的内部序列名
SELECT pg_get_serial_sequence('test_serial', 'id');

# 向 test_serial 表中插入几个新行，其中 id 是 SERIAL 列
INSERT INTO test_serial (notes)
VALUES ('A'), ('B'), ('C');


# 查看 test_serial 表中的行
SELECT * FROM test_serial;

# SERIAL 列的当前的值
# currval() 函数序列的名称作为参数，因此需要先获取 SERIAL 列对应的内部序列的名称。 通常情况下， PostgreSQL 会按照如下格式为 SERIAL 列创建内部序列
{table_name}_{column_name}_seq
# 可以通过上面实例中使用的 \d 命令或者 pg_get_serial_sequence() 函数来获取此列对应的内部序列名

SELECT currval('test_serial_id_seq');


# 也可以使用下一个语句来获取 SERIAL 列的当前的值
SELECT currval(pg_get_serial_sequence('test_serial', 'id'));
```



## SEQUENCE 序列生成器

`SEQUENCE` 用于生成一个有序的数字序列。它被称为序列、序列对象或者序列生成器。

可以使用 `CREATE SEQUENCE` 语句创建一个序列，使用 `DROP SEQUENCE` 删除一个序列



> 序列是一个独立的数据库对象，不是绑定到特定表或数据库的。序列是一个命名的数据库对象，它生成一个数字值序列，这些值可以用于填充表中的一个列。
>
> 以下是 PostgreSQL 中序列的一些关键特征：
>
> 1. **独立于表**：序列是一个独立的数据库对象，不是绑定到特定表的。这意味着一个序列可以用于生成多个表的值。
> 2. **数据库范围**：序列是一个数据库范围的对象，这意味着它不特定于特定表或 schema。
> 3. **命名对象**：序列是一个命名对象，这意味着它有一个唯一的名称，可以在 SQL 操作中引用。
> 4. **生成数字值**：序列生成一个数字值序列，这些值可以用于填充表中的一个列。
>
> 当您创建一个序列时，可以指定以下属性：
>
> 1. **起始值**：序列的起始值。
> 2. **增量值**：用于生成序列下一个值的增量值。
> 3. **最小值**：序列可以生成的最小值。
> 4. **最大值**：序列可以生成的最大值。
>
> 一旦创建了序列，就可以使用 `nextval()` 函数来生成表中的一个列的值。例如：
>
> 
>
> ```sql
> CREATE SEQUENCE 我的序列 START WITH 1 INCREMENT BY 1;
> 
> CREATE TABLE 我的表 (
>     id SERIAL PRIMARY KEY,
>     name VARCHAR(50)
> );
> 
> INSERT INTO 我的表 (id, name) VALUES (nextval('我的序列'), 'John');
> ```
>
> 在这个例子中，`我的序列` 序列被创建了，起始值为 1，增量值为 1。然后，`nextval()` 函数被用于生成序列的下一个值，该值用于填充 `我的表` 表中的 `id` 列。



### 语法

```sql
CREATE [ TEMPORARY | TEMP ] SEQUENCE [ IF NOT EXISTS ] seq_name
    [ AS data_type ]
    [ INCREMENT [ BY ] increment ]
    [ MINVALUE minvalue | NO MINVALUE ]
    [ MAXVALUE maxvalue | NO MAXVALUE ]
    [ START [ WITH ] start ]
    [ CACHE cache ]
    [ [ NO ] CYCLE ]
    [ OWNED BY { table_name.column_name | NONE } ]
```

*`TEMPORARY | TEMP`*

指定当前序列是一个临时序列。您只能在当前会话中使用。它会在会话结束时被自动删除。 它是可选的。

*`IF NOT EXISTS`*

如果指定，如果存在同名的序列，则不会引发错误。

*`seq_name`*

要创建的序列的名称。

*`data_type`*

它指示了这个序列的数据类型。可用值： `smallint`, `integer`, 和 `bigint`，并且 `bigint` 是默认值。

*`INCREMENT [ BY ] increment`*

序列增长的步幅，可以是整数或者负数。正值将产生一个升序序列，负值将产生一个降序序列。默认是值 1。

*`MINVALUE minvalue | NO MINVALUE`*

`minvalue` 是序列的最小值。 `NO MINVALUE` 意味着使用数据类型的最小值。 升序序列的默认值是 1, 降序序列的默认值是数据类型的最小值。

*`MAXVALUE maxvalue | NO MAXVALUE`*

`maxvalue` 是序列的最大值。 `NO MAXVALUE` 意味着使用数据类型的最大值。 降序序列的默认值是 1, 升序序列的默认值是数据类型的最大值。

*`START [ WITH ] start`*

`start` 是此序列的起始值。升序序列的默认值是 `minvalue`，降序序列的默认值是 `maxvalue`。

*`CACHE cache`*

`cache` 是缓存在内存中的序列值的数量，以便可以快速访问。 默认值是 1， 1 也是可接受的最小值。

*`[ NO ] CYCLE`*

指示序列是否可循环的。 如果指定 `NO CYCLE`，那么序列到结尾的时候，再取值则会发生错误。

*`OWNED BY { table_name.column_name | NONE }`*

将此序列与指定表的列关联起来。如果此列被删除，此序列会被自动删除

### 删除语法

```sql
# 删除一个或者多个序列
DROP SEQUENCE [ IF EXISTS ] seq_name [, ...]
[ CASCADE | RESTRICT ];
```

- *`IF EXISTS`*

  如果指定的序列不存在不会抛出一个错误。

- *`seq_name`*

  要删除的序列的名称。

- *`CASCADE`*

  自动删除依赖于此序列的对象，并依次删除依赖这些对象的对象。

- *`RESTRICT`*

  如果任何对象依赖此序列，则拒绝删除它。这是默认值。

### 访问 PostgreSQL 序列

您可以使用以下三个函数操作 PostgreSQL 序列：

- [`nextval`](https://www.sjkjc.com/postgresql-ref/nextval/): 获取并返回序列的下一个值。
- [`currval`](https://www.sjkjc.com/postgresql-ref/currval/): 返回当前会话中指定序列的当前值。
- [`setval`](https://www.sjkjc.com/postgresql-ref/setval/): 重置指定序列的当前值。

```sql
# 查看指定的序列
SELECT * FROM seq_name;
```

### 案例

```sql
# 创建一个从 10 开始步长为 10 的升序序列
CREATE SEQUENCE asc_seq
INCREMENT 10
START 10;


# 使用 nextval() 函数从序列中获取下一个值
SELECT nextval('asc_seq');

# 使用 currval() 函数获取序列的当前的值
SELECT currval('asc_seq');

# 用 setval() 函数设置序列的当前值
SELECT setval('asc_seq', 50);
```



## 临时表

临时表是一种特殊的表，他们只在会话期间存在。临时表会在会话结束的时候被自动删除

可以为临时表使用一个和常规表相同的表名，但是在临时表存在期间，不能访问常规表

相比于常规的 [`CREATE TABLE`](https://www.sjkjc.com/postgresql/create-table/) 语句，它只是多了一个 `TEMPORARY` 或者 `TEMP` 关键字，以指示当前创建的表是一个临时表。

```sql
# 使用 CREATE TEMPORARY TABLE 语句像创建普通表一样创建临时表
CREATE { TEMPORARY | TEMP } TABLE temp_table_name (
   column_name data_type column_contraint
   [, ...]
   table_constraint
);

# 要删除一个临时表
# 与删除常规表完全一样
# 也可以通过退出会话让 PostgreSQL 自动删除临时表
DROP TABLE temp_table_name;
```

### 案例

```sql
# 创建为test_temp 的临时表
CREATE TEMP TABLE test_temp (
  id SERIAL PRIMARY KEY,
  notes VARCHAR
);


# 使用 \dt 命令查看数据库中的表
# 临时表的 Schema 值是 pg_temp_4，而常规表的 Schema 值是 public
\dt
```

**创建与常规表同名的临时表的实例**

```sql
# 创建临时表 users 之前，先看以下常规表 users 的结构
\d users

# 创建一个名称为 users 的临时表，为了区分，临时表 users 只有一个 id 列
CREATE TEMP TABLE users (
  id SERIAL PRIMARY KEY
);

# 查看数据库中的表
# 常规表就不见了
\dt

# 删除临时表 users
DROP TABLE users;
```



## SELECT INTO从结果集创建新表

`SELECT INTO` 语句允许您从一个查询的结果创建一个新表并将结果集插入到新表，它与 [`CREATE TABLE ... AS`](https://www.sjkjc.com/postgresql/create-table/) 语句功能相同

```sql
# 使用 PostgreSQL SELECT INTO 语句创建一个新表
SELECT column_list
INTO [ TEMPORARY | TEMP ] [ TABLE ] new_table
[other_clauses]
```

- `column_list` 是查询语句要返回的中的列或者表达式的列表。这些列最终成为新表中的列。 您可以使用 [`DISTINCT`](https://www.sjkjc.com/postgresql/distinct/)。
- `INTO` 之后的 `new_table` 是要创建的表的名字。 `TEMPORARY` 或者 `TEMP` 代表新表是一个[临时表](https://www.sjkjc.com/postgresql/temporary-table/)。 `TABLE` 关键字是可以省略。
- `other_clauses` 是 `SELECT` 语句中可用的子句，这包括：
  - `FORM` 子句
  - [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句
  - [`ORDER BY`](https://www.sjkjc.com/postgresql/order-by/) 子句
  - [`GROUP BY`](https://www.sjkjc.com/postgresql/group-by/) 子句
  - [`HAVING`](https://www.sjkjc.com/postgresql/having/) 子句
  - [`LIMIT`](https://www.sjkjc.com/postgresql/limit/) 子句
  - [`FETCH`](https://www.sjkjc.com/postgresql/fetch/) 子句
  - [`OFFSET`](https://www.sjkjc.com/postgresql/offset/) 子句
  - 集合操作： [`UNION`](https://www.sjkjc.com/postgresql/union/), [`INTERSECT`](https://www.sjkjc.com/postgresql/intersect/)，或者 [`EXCEPT`](https://www.sjkjc.com/postgresql/except/)
  - [表连接](https://www.sjkjc.com/postgresql/join/)



### 案例

使用 `SELECT INTO` 完整复制影片表

```sql
# 将 film 表的所有的行复制到一个新表 film_copy
SELECT *
INTO TABLE film_copy
FROM film;


# 从新表中查询数据已验证表是否创建成功
SELECT count(*) FROM film_copy;
```

使用 `SELECT INTO` 完整复制部分行和列

```sql
# 将 film 表所有评级为 G 的影片的标题复制到一个新表 film_ranting_g_title
SELECT title
INTO TABLE film_ranting_g_title
FROM film
WHERE rating = 'G';

# 从新表中查询数据已验证表是否创建成功
SELECT * FROM film_ranting_g_title;
```





# 事务

数据库事务是一种保证交易的完整性的机制。事务是一个不可分隔的工作单元，一个事务之内的所有的操作要么全部执行，要么全部不执行。

比如，在一个银行系统中，用户 A 向用户 B 转账 500 元。这个交易主要包含两个操作：

1. 从用户 A 的账户余额扣除 500 元。
2. 将用户 B 的账户余额增加 500 元。

上面的两个操作要么全部执行，要么全部不执行，否则会带来错误



数据库事务具有四大特性：

- 原子性(Atomicity)： 事务中的操作要么全部执行，要么全部不执行。
- 一致性(Consistency)： 一个事务必须是数据库从一个一致状态变成另一个一致状态。
- 隔离性(Isolation)： 多个事务并发执行时，一个事务的执行不应影响其他事务的执行。
- 持久性(Durability)： 已提交的事务将永久存储在数据库中。

数据库事务的四大特性通常被简称为 ACID



事务命令：开启一个事务、提交一个事务、回滚一个事务



## 开启事务

- `START TRANSACTION;`
- `BEGIN TRANSACTION;`
- `BEGIN WORK;`
- `BEGIN;`

开启一个事务后，后续的所有操作都属于该事务，直到事务被提交或者被回滚



## 提交事务

- `COMMIT TRANSACTION;`
- `COMMIT WORK;`
- `COMMIT;`

提交事务将当前事务内的所有操作写入数据库，并结束当前事务



## 回滚事务

- `ROLLBACK TRANSACTION;`
- `ROLLBACK WORK;`
- `ROLLBACK;`

回滚事务将撤销当前事务内的所有的操作，并结束当前事务



## 案例

```sql
# 建表
CREATE TABLE user_balance (
  id INTEGER PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  balance DEC(15,2) NOT NULL
);


# 在一个事务中插入一个数据
# 会话1
BEGIN;
# 插入一行数据
INSERT INTO user_balance (id, name, balance)
VALUES (1, 'Tom', '2500');
# 查看 user_balance 表中数据
SELECT * FROM user_balance;


# 会话2
# 查看 user_balance 表中数据
# 并不能看到刚刚插入的行。这是因为在会话 1 中的插入操作在一个事务中，并且事务还未提交，因此事务之外并不能看到还未提交的数据
SELECT * FROM user_balance;


# 会话1
COMMIT;		# 提交事务

# 会话2
# 查看 user_balance 表中数据
# 由于会话 1 中的事务已经提交，您可以在会话 2 中看到刚刚插入的行了
SELECT * FROM user_balance;
```

**模拟转账操作**

```sql
# 插入 2 行数据
INSERT INTO user_balance (id, name, balance)
VALUES (2, 'Tim', '1500'), (3, 'Jim', '1000');

# 查看数据
SELECT * FROM user_balance;

# 假设， Tom 需要向 Tim 转账 500 元。您需要完成如下两个操作：

# 将 Tom 的余额扣减 500 元
# 将 Tim 的余额增加 500 元
# 开启事务
BEGIN;

# 将 Tom 的余额减少 500 元
UPDATE user_balance
SET balance = balance - 500
WHERE id = 1;

# 将 Tim 的余额增加 500 元
UPDATE user_balance
SET balance = balance + 500
WHERE id = 2;

# 查看 user_balance 表中数据，已验证数据的是否正确
SELECT *
FROM user_balance
WHERE id IN (1, 2);

# Tom 和 Tim 转账后的余额都是正确的
# 提交事务
COMMIT;
```

**回滚事务**

如果在提交事务之前出现了任何异常，您都可以通过回滚事务来撤销之前的操作。

比如，不小心将钱转账给了 id 为 3 的用户，只要您在提交之前发现了问题， 您可以通过 `ROLLBACK` 命令回滚当前事务。

```sql
# 查看数据
SELECT * FROM user_balance;

# 假设不小心将钱转账给了 id 为 3 的用户
BEGIN;

UPDATE user_balance
SET balance = balance - 500
WHERE id = 1;

UPDATE user_balance
SET balance = balance + 500
WHERE id = 3;


# 在提交之前使用以下语句检查操作是否正确
SELECT *
FROM user_balance
WHERE id IN (1, 2);


# 发现 Tom 的余额少了 500， 而 Tim 的余额没有变化。这是一个错误。因此您需要使用 ROLLBACK 来回滚事务。

# 事务被回滚后，数据恢复到操作之前的状态，您就可以继续完成转账了
ROLLBACK;
```



# 索引

## 索引类型

PostgreSQL 支持几种不同类型的索引：B-tree、Hash、GiST、SP-GiST、GIN 和 BRIN。每种索引类型使用不同的存储结构和算法来应对不同类型的查询。不同的数据可能要采用不同的索引类型。

PostgreSQL 默认使用 B-tree 索引类型，因为它最适合最常见的查询。 你在使用 [`CREATE INDEX`](https://www.sjkjc.com/postgresql/create-index/) 语句创建索引时，如果不知道索引类型，默认采用 B-tree

### B-tree 索引

B-tree 是一种自平衡树，它维护已排序的数据。

每当索引列涉及使用以下运算符之一的比较时，PostgreSQL 查询规划器将考虑使用 B-tree 索引：

- `<`
- `<=`
- `=`
- `>=`
- `BETWEEN`
- `IN`
- `IS NULL`
- `IS NOT NULL`

如果模式是一个常量并且在模式的开头是锚点， 查询规划器可以对涉及模式匹配运算符 [`LIKE`](https://www.sjkjc.com/postgresql/like/) 和 `~` 的查询使用 B-tree 索引

```sql
column_name LIKE 'foo%'
column_name LKE 'bar%'
column_name  ~ '^foo'
```

`col LIKE '%bar'` 则不会使用 B-tree 索引。

对于模式匹配运算符 `ILIKE` 和 `~*`，如果模式以以非字母字符(不受大小写影响的字符)开头，查询规划器将考虑使用 B-tree 索引。



### 哈希索引

哈希索引只能处理简单的相等比较 (`=`)。这意味着每当索引列使用 `=` 运算符进行比较时，查询计划器将考虑使用哈希索引。

要创建哈希索引，在子句中使用 `CREATE INDEX` 带有 `HASH` 索引类型的 `USING` 语句

```sql
CREATE INDEX index_name
ON table_name USING HASH (indexed_column);
```

### GIN 索引

GIN 索引是“倒排索引”。它很适合索引那些复杂的值(比如 [`array`](https://www.sjkjc.com/postgresql/array-type/), [`hstore`](https://www.sjkjc.com/postgresql/hstore-type/), [`json`](https://www.sjkjc.com/postgresql/json-type/) 和 [`range`](https://www.sjkjc.com/postgresql/range-type/))。

倒排索引中为每一个组成值都包含一个单独的项，它可以高效地处理测试指定组成值是否存在的查询。

将多个值存储在单个列中时，GIN 索引最有用



### BRIN 索引

BRIN 表示块范围索引（Block Range Indexes），存储有关存放在一个表的连续物理块范围上的值摘要信息。BRIN 是 PostgreSQL 9.5 版本新增的索引类型。与 B-tree 索引相比，BRIN 更小，维护成本更低。

BRIN 允许在非常大的表上使用索引，这在以前使用没有水平分区的 B-tree 是不切实际的。

BRIN 常用于具有线性排序顺序的列，例如，销售订单表的创建日期列

### GiST 索引

GiST 索引不是单独一种索引类型，而是一种架构，可以在这种架构上实现很多不同的索引策略。

GiST 代表广义搜索树。GiST 索引允许构建通用的树结构。GiST 索引可用于索引几何数据类型和全文搜索。

### SP-GiST 索引

SP-GiST 代表空间分区的 GiST。SP-GiST 支持分区搜索树，有助于开发各种不同的非平衡数据结构。

SP-GiST 索引最适用于具有自然聚类元素但也不是均衡树的数据，例如 GIS、多媒体、电话路由和 IP 路由



## 创建索引

### 语法

```sql
CREATE [ UNIQUE ] INDEX [ [ IF NOT EXISTS ] name ]
    ON table_name [ USING method ]
(
    column_name [ ASC | DESC ] [ NULLS { FIRST | LAST } ]
    [, ...]
);
```

- `name` 索引的名称。它是可选的。如果您不指定索引名称，PostgreSQL 将会自动生成一个。
- `table_name` 是要为其创建索引的表名。
- `method` 是索引方法的名称。包括 `btree`, `hash`, `gist`, `spgist`, `gin`, 和 `brin`。 `btree` 是默认的方法。您可以查看[索引类型](https://www.sjkjc.com/postgresql/index-types/)以了解更多。
- `column_name` 是要创建索引的列名。
- `[ ASC | DESC ]` 指定排序是顺序还是逆序。 它是可选的， `ASC` 是默认值。
- `NULLS FIRST` 或 `NULLS LAST` 指定排序时空值在非空值之前或之后。当指定 `DESC` 时, `NULLS FIRST` 是默认的，否则 `NULLS LAST` 是默认的。
- [`UNIQUE`](https://www.sjkjc.com/postgresql/unique/) 指示创建一个[唯一索引](https://www.sjkjc.com/postgresql/unique-index/)。
- `IF NOT EXISTS` 指示只有指定的索引名称不存在时才创建索引。

PostgreSQL 会对[主键](https://www.sjkjc.com/postgresql/primary-key/)列自动创建索引。

要检查查询是否使用索引，请使用该 [`EXPLAIN`](https://www.sjkjc.com/postgresql/explain/) 语句。

如果在一个索引中使用了多个列，那么此索引被称为[多列索引或复合索引](https://www.sjkjc.com/postgresql/multicolumn-indexes/)

### 案例

```sql
# 以查询查找邮编为 x 的地址
SELECT * FROM address
WHERE postal_code = 'x';

# 由于该 postal_code 列没有可用的索引， PostgreSQL 不得不进行全表扫描。进可以通过查看查询计划来验证这一点
# 要显示执行计划，使用 EXPLAIN 
EXPLAIN
SELECT * FROM address
WHERE postal_code = 'x';


# 为 address 表 postal_code 列中的值创建索引
# 没有指定索引名，将会自动生成一个索引名称：address_postal_code_idx
CREATE INDEX ON address (postal_code);


# 再次执行计划查询
EXPLAIN
SELECT * FROM address
WHERE postal_code = 'x';
# 存在 using address_postal_code_idx 说明了 PostgreSQL 使用了索引进行查找
```

## 删除索引

### 语法

```sql
DROP INDEX  [ CONCURRENTLY ]
[ IF EXISTS ]  name
[ CASCADE | RESTRICT ];
```

- `name` 是要删除的索引的名称。

- `IF EXISTS` 指示如果指定的索引不存在将不会给出错误， PostgreSQL 将会发出一个通知。

- `CASCADE` 指示 PostgreSQL 自动删除那些依赖于此索引的对象。

- `RESTRICT` 指示如果有其他对象依赖于此索引，则拒绝删除。 这是默认的行为。

- 删除索引时， PostgreSQL 默认会获取该表的排他锁并阻止任何其他的访问，知道索引删除完成。您可以使用 `CONCURRENTLY` 选项改变这一行为。

  注意，当使用 `CASCADE` 选项时， 不支持 `CONCURRENTLY`

```sql
# 简单的删除索引的语句
DROP INDEX name;

# 可以使用一个语句同时删除多个索引
DROP INDEX name1, name2,... ;
```

### 案例

为 `actor` 表的 `first_name` 列[创建索引](https://www.sjkjc.com/postgresql/create-index/)

```sql
CREATE INDEX idx_actor_first_name
ON actor (first_name);
```

```sql
# 有时，查询优化器不使用索引。例如，以下语句查找名为 John 的 actor
SELECT * FROM actor
WHERE first_name = 'John';


# 该查询未使用 idx_actor_first_name 之前定义的索引，如以下 EXPLAIN 语句中所述
EXPLAIN
SELECT * FROM actor
WHERE first_name = 'John';

# 因为查询优化器认为只扫描整个表来定位行更为优化。因此，在这种情况下没有用 idx_actor_first_name
DROP INDEX idx_actor_first_name;
```



### 查看索引

有两种方法查看表的索引：

1. 在 psql 工具中使用 `\d` 命令查看表的索引。
2. 在 `pg_indexes` 视图中检索索引信息



##  psql查看索引

```sql
# \d 命令将返回表的所有信息，包括表的结构、索引、约束和触发器
#  Indexes 部分就是表中的所有的索引
\d table_name

\d customer
```



### pg_indexes 视图列出索引

PostgreSQL 内置的 `pg_indexes` 视图允许您访问有关 PostgreSQL 数据库中每个索引的有用信息。该 `pg_indexes` 视图由五列组成：

- `schemaname`: 存储包含表和索引的模式的名称。
- `tablename`: 存放索引所属表的名称。
- `indexname`: 存储索引的名称。
- `tablespace`: 存储包含索引的表空间的名称。
- `indexdef`: 以 [`CREATE INDEX`](https://www.sjkjc.com/postgresql/create-index/) 语句的形式存储索引定义命令

```sql
# 列出 customer 表的所有索引
SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'customer';
```



## 多列索引

多列索引是在表的多个列上定义的索引。多列索引，又称为复合索引或组合索引。

在 PostgreSQL 中，只有 B-tree、GIST、GIN 和 BRIN 索引类型支持多列索引。一个多列索引最多支持 32 个列

定义多列索引时，应将 [`WHERE`](https://www.sjkjc.com/postgresql/where/) 子句中常用的列放在列列表的开头，将不常用的列放在后面的条件中。否则， PostgreSQL 优化器可能不会使用索引

```sql
# 例如，在 a, b 和 c 列上定义上了索引
CREATE INDEX index_name
ON table_name(a, b, c);

# PostgreSQL 优化器在以下情况下会考虑使用索引
WHERE a = v1 and b = v2 and c = v3;
# 或者
WHERE a = v1 and b = v2;
# 或
WHERE a = v1;


# 不考虑使用索引情况
WHERE  c = v3;
# 或
WHERE b = v2 and c = v3;
```

### 案例

```sql
# 查看 customer 表的信息
\d customer

# 在 customer 表中已经存在两个索引，为了演示多列索引，先删掉 idx_last_name 索引
DROP INDEX idx_last_name;

# 在 last_name 和 first_name 列上创建索引
CREATE INDEX ON customer (last_name, first_name);

# 查看 customer 表的信息
\d customer

# 发现在 在 last_name 和 first_name 列上定义了 customer_last_name_first_name_idx 索引
# 通过 EXPLAIN 语句查看以下语句是否使用了索引
EXPLAIN
SELECT * FROM customer
WHERE last_name = 'A'
AND first_name = 'B';

# EXPLAIN
SELECT * FROM customer
WHERE last_name = 'A';

# 当 SELECT 语句的 WHERE 条件中只有 last_name 时， PostgreSQL 优化器选择使用索引。这是因为 last_name 列是索引中的第一列

# 当 SELECT 语句的 WHERE 条件中只有 first_name 时， PostgreSQL 优化器选择不使用索引。 这是因为 first_name 列不是索引的第一列
EXPLAIN
SELECT * FROM customer
WHERE first_name = 'B';
```



## 唯一索引

创建唯一索引以确保一列或多列中值的唯一性。

PostgreSQL `UNIQUE` 索引用于强制一列或多列中值的唯一性。

只有[索引类型](https://www.sjkjc.com/postgresql/index-types/)为 B-Tree 的索引可以声明为唯一索引

```sql
CREATE UNIQUE INDEX index_name
ON table_name(column_name, [...]);
```

`UNIQUE` 关键字用于将索引声明为唯一索引。

如果一个列被定义为唯一索引，那么该列不能存储具有相同的值。

如果两列或更多列被定义为唯一索引，则这些列中的组合值不能重复。

但是，可以在具有 `UNIQUE` 索引的列中使用多个 `NULL` 值 。

当为表定义[主键](https://www.sjkjc.com/postgresql/primary-key/)或[唯一约束](https://www.sjkjc.com/postgresql/unique/)时，PostgreSQL 会自动创建相应的 `UNIQUE` 索引。

### 案例

```sql
# 建表
# id 是主键列， email 列有唯一约束，因此，PostgreSQL 创建了两个 UNIQUE 索引，每个列一个
CREATE TABLE staff (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE
);


# 显示 staff 表的索引
SELECT
  tablename,
  indexname,
  indexdef
FROM
  pg_indexes
WHERE
  tablename = 'staff';
```

### 单列示例

```sql
# 将 mobile_phone 列添加到 staff 表中
ALTER TABLE staff
ADD mobile_phone VARCHAR(20);

# 确保所有员工的手机号码都是不同的，可以为该 mobile_phone 列定义一个 UNIQUE 索引
CREATE UNIQUE INDEX idx_staff_mobile_phone
ON staff(mobile_phone);


# 在 staff 表中插入一个新行
INSERT INTO staff(first_name, last_name, email, mobile_phone)
VALUES ('Adam','Z','adam@sqliz.com', '13333333333');

# 唯一列插入相同数据
INSERT INTO staff(first_name, last_name, email, mobile_phone)
VALUES ('Jack','W','jack@sqliz.com', '13333333333');

# ERROR:  duplicate key value violates unique constraint "idx_staff_mobile_phone"
# DETAIL:  Key (mobile_phone)=(13333333333) already exists.
```



### 多列示例

```sql
# 将添加两个新列 work_phone 和 extension 到 staff 表中
ALTER TABLE staff
ADD work_phone VARCHAR(20),
ADD extension VARCHAR(5);


# 多个员工可以共享同一个工作电话号码。但是，它们不能具有相同的分机号码。要强制执行此规则，可以在 work_phone 和 extension 列上定义 UNIQUE 索引
CREATE UNIQUE INDEX idx_staff_workphone
ON staff(work_phone, extension);


# 测试索引
INSERT INTO staff(first_name, last_name, work_phone, extension)
VALUES('Lily', 'Bush', '1234567','3564');

# 无异常
INSERT INTO staff(first_name, last_name, work_phone, extension)
VALUES('Joan', 'Doe', '1234567','3565');

# ERROR:  duplicate key value violates unique constraint "idx_staff_workphone"
# DETAIL:  Key (work_phone, extension)=(1234567, 3565) already exists.
INSERT INTO staff(first_name, last_name, work_phone, extension)
VALUES('Tommy', 'Stark', '1234567','3565');
```





# 问题

## 数据库；表空间

表空间（Tablespace）是指一个存储表、索引和其他数据库对象的文件系统目录。每个表空间都对应一个文件系统目录，用于存储该表空间中的所有对象。

PG 中的表空间有以下几个特点：

1. **存储**: 表空间用于存储 PG 数据库中的表、索引、视图、函数、触发器等对象。
2. **文件系统目录**: 每个表空间对应一个文件系统目录，PG 将对象存储在该目录下。
3. **独立管理**: 每个表空间都是独立的，可以单独管理和配置。
4. **存储位置**: 表空间可以位于不同的存储设备上，例如不同的硬盘、RAID 阵列等。
5. **权限控制**: PG 提供了权限控制机制，可以控制用户对表空间的访问权限。

PG 中有两个默认的表空间：

1. **pg_default**:这是 PG 的默认表空间，用于存储系统对象和用户创建的对象。
2. **pg_global**:这是 PG 的全局表空间，用于存储系统对象和跨数据库的对象。

创建表空间的语法为：

```sql
CREATE TABLESPACE tablespace_name LOCATION '/path/to/tablespace';
```

其中，`tablespace_name` 是表空间的名称，`/path/to/tablespace` 是表空间对应的文件系统目录。

总之，表空间是 PG 中的一个逻辑概念，用于管理和存储数据库对象，它可以帮助数据库管理员更好地管理存储空间和权限



## 表；标识列

标识列（Identity Column）是一种特殊类型的列，用于自动生成唯一的标识符，通常用于主键或唯一标识符。

PG 中的标识列有以下特点：

1. **自动增长**: 标识列的值会自动增长，每次插入新行时，PG 会自动分配一个唯一的值。
2. **唯一性**: 标识列的值是唯一的，PG 保证每个值都不同。
3. **不重复**: 标识列的值不能被重复使用，即使删除了某行，也不能将其值重新分配给其他行。

PG 中有两种类型的标识列：

1. **SERIAL**: SERIAL 是 PG 中的一种标识列类型，用于生成整数类型的标识符。SERIAL 等同于创建一个整数列，并将其设置为自动增长。
2. **IDENTITY**: IDENTITY 是 PG 中的一种标识列类型，用于生成任意数据类型的标识符，包括整数、字符串等

创建标识列的语法为：



```sql
CREATE TABLE table_name (
    column_name SERIAL PRIMARY KEY
);
```

或

```sql
CREATE TABLE table_name (
    column_name INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);
```

其中，`column_name` 是标识列的名称，`SERIAL` 或 `IDENTITY` 是标识列的类型。

PG 中的标识列可以使用 `nextval` 函数来获取下一个可用的标识符值，例如：

```sql
INSERT INTO table_name (column_name) VALUES (nextval('table_name_column_name_seq'));
```

总之，标识列是 PG 中的一种特殊类型的列，用于自动生成唯一的标识符，通常用于主键或唯一标识符





## FETCH 和 OFFSET分页和limit分页

**1. FETCH/OFFSET 分页**

FETCH/OFFSET 分页是 PG 中的一种标准分页方法，用于从查询结果中提取指定范围的记录。

语法：

```sql
SELECT *
FROM table_name
OFFSET offset_value ROWS
FETCH NEXT fetch_value ROWS ONLY;
```

其中：

- `offset_value`：指定从哪一行开始提取记录。
- `fetch_value`：指定要提取的记录数。

例如，要从 `table_name` 表中提取从第 10 行开始的 5 行记录，可以使用以下语句：

```sql
SELECT *
FROM table_name
OFFSET 9 ROWS
FETCH NEXT 5 ROWS ONLY;
```

**2. LIMIT 分页**

LIMIT 分页是 PG 中的一种简洁的分页方法，用于从查询结果中提取指定数量的记录。

语法：

```sql
SELECT *
FROM table_name
LIMIT limit_value OFFSET offset_value;
```

其中：

- `limit_value`：指定要提取的记录数。
- `offset_value`：指定从哪一行开始提取记录。

例如，要从 `table_name` 表中提取从第 10 行开始的 5 行记录，可以使用以下语句：

```sql
SELECT *
FROM table_name
LIMIT 5 OFFSET 9;
```

**比较**

两种分页方法都可以实现分页，但是它们有不同的语法和使用场景：

- FETCH/OFFSET 分页更灵活，允许你指定要提取的记录范围和偏移量。
- LIMIT 分页更简洁，适合简单的分页场景。

在性能方面，两种方法的性能基本相同，但是 FETCH/OFFSET 分页可能会比 LIMIT 分页更快，因为它可以更好地利用索引。

总之，FETCH/OFFSET 分页和 LIMIT 分页都是 PG 中的分页方法，选择哪种方法取决于你的具体需求和使用场景。
