





















### binlog简介

[地址](https://blog.csdn.net/mshxuyi/article/details/94212369)

binlog是一个二进制格式的文件，用于记录用户对数据库**增量操作**的SQL语句信息，例如更改数据库表和更改内容的SQL语句都会记录到binlog里，但是对库表等内容的**查询不会记录**。

默认情况下，binlog日志是二进制格式的，不能使用查看文本工具的命令（比如，cat，vi等）查看，而使用mysqlbinlog解析查看

```bash
mysqlbinlog --base64-output=decode-rows -v /var/lib/mysql/mysql-bin.000001
log_bin                 = /var/lib/mysql/mysql-bin.log   #默认路径可修改



expire_logs_days        = 7                              #日志过期时间，设置为0则永不过期
binlog_format           = ROW          #复制模式
max_binlog_size         = 100M         #超过max_binlog_size或超过6小时会切换到下一序号文件
binlog_cache_size       = 16M           



#二进制日志缓冲大小,通过show status like 'binlog_%';查看调整写入磁盘的次数，写入磁盘为0最好
max_binlog_cache_size   = 256M
relay_log_recovery      = 1            



#当slave从库宕机后，假如relay-log损坏了，



#导致一部分中继日志没有处理，则自动放弃所有未执行的relay-log，



#并且重新从master上获取日志，这样就保证了relay-log的完整性。
sync_binlog             = 1            #二进制日志（binary log）同步到磁盘的频率
innodb_flush_log_at_trx_commit = 1     #每次事务提交将日志缓冲区写入log file，并同时flush到磁盘。
```

**以下2个参数可以减少网络问题导致的主从数据同步延迟**

```bash
slave_net_timeout       = 5       #当slave从主数据库读取log数据失败后，等待多久重新建立连接并获取数据,默认3600秒



 



 



#此选项为从库 change master to 的参数



master-connect-retry    = 60      #当重新建立主从连接时，如果连接建立失败，间隔多久后重试
```

**MySQL binlog的三种工作模式**

- **Statement level（默认）**

每一条被修改数据的sql都会记录到master的bin-log中，slave在复制的时候sql进程会解析成和原来master端执行过的相同的sql再次执行

优点：不需要记录每一行的数据变化，减少bin-log日志量，节约磁盘IO，提高新能

缺点：容易出现主从复制不一致

```bash
BEGIN



/*!*/;



# at 503



# at 535



#190629 22:44:03 server id 2  end_log_pos 535 CRC32 0x5f886e71 	Intvar



SET INSERT_ID=1/*!*/;



#190629 22:44:03 server id 2  end_log_pos 687 CRC32 0x0f3e188e 	Query	thread_id=2	exec_time=0	error_code=0



SET TIMESTAMP=1561819443/*!*/;



insert into student (name,age) values



('tom',20),('alice',16),('helen',22)



/*!*/;



# at 687



#190629 22:44:03 server id 2  end_log_pos 718 CRC32 0x10c379a2 	Xid = 25



COMMIT/*!*/;
```

- **Row level**

日志中会记录每一行数据被修改的情况，然后在slave端对相同的数据进行修改。

优点：能清楚的记录每一行数据修改的细节

缺点：数据量太大

```bash
BEGIN



/*!*/;



# at 194



#190629 21:39:57 server id 2  end_log_pos 250 CRC32 0xa2b4d227 	Table_map: `school`.`student` mapped to number 73



# at 250



#190629 21:39:57 server id 2  end_log_pos 328 CRC32 0x69783f01 	Write_rows: table id 73 flags: STMT_END_F



### INSERT INTO `school`.`student`



### SET



###   @1=1



###   @2='tom'



###   @3=20



### INSERT INTO `school`.`student`



### SET



###   @1=2



###   @2='alice'



###   @3=16



### INSERT INTO `school`.`student`



### SET



###   @1=3



###   @2='helen'



###   @3=22



# at 328



#190629 21:39:57 server id 2  end_log_pos 359 CRC32 0x91fe958e 	Xid = 50



COMMIT/*!*/;
```

- **Mixed（混合模式）**

以上两种模式的混合使用，一般的复制使用STATEMENT模式保存binlog，对于STATEMENT模式无法复制的操作使用ROW模式保存binlog，MySQL会根据执行的SQL语句选择日志保存方式。

### sync_binlog

```bash
sync_binlog=0
```

当事务提交之后，MySQL不做fsync之类的磁盘同步指令刷新binlog_cache中的信息到磁盘，而让Filesystem自行决定什么时候来做同步，或者cache满了之后才同步到磁盘。这个是性能最好的。

```bash
sync_binlog=1
```

当每进行1次事务提交之后，MySQL将进行一次fsync之类的磁盘同步指令来将binlog_cache中的数据强制写入磁盘。

```bash
sync_binlog=n
```

当每进行n次事务提交之后，MySQL将进行一次fsync之类的磁盘同步指令来将binlog_cache中的数据强制写入磁盘。

注：大多数情况下，对数据的一致性并没有很严格的要求，所以并不会把 sync_binlog 配置成 1. 为了追求高并发，提升性能，可以设置为 100 或直接用 0，而对于支付服务这样的应用，还是比较推荐 sync_binlog = 1.

## innodb_flush_log_at_trx_commit

```bash
innodb_flush_log_at_trx_commit=0
```

设置为0，该模式速度最快，但不太安全，mysqld进程的崩溃会导致上一秒钟所有事务数据的丢失。log buffer将每秒一次地写入log file中，并且log file的flush(刷到磁盘)操作同时进行。该模式下在事务提交的时候，不会主动触发写入磁盘的操作。

```bash
innodb_flush_log_at_trx_commit=1
```

当设置为1，该模式是最安全的，但也是最慢的一种方式。在mysqld 服务崩溃或者服务器主机crash的情况下，binary log 只有可能丢失最多一个语句或者一个事务。每次事务提交时MySQL都会把log buffer的数据写入log file，并且flush(刷到磁盘)中去，该模式为系统默认。

```bash
innodb_flush_log_at_trx_commit=2
```

当设置为2，该模式速度较快，也比0安全，只有在操作系统崩溃或者系统断电的情况下，上一秒钟所有事务数据才可能丢失。每次事务提交时MySQL都会把log buffer的数据写入log file，但是flush(刷到磁盘)操作并不会同时进行。该模式下，MySQL会每秒执行一次 flush(刷到磁盘)操作。









---

[地址](https://www.cnblogs.com/ilanni/p/4080504.html)

## **1**、基础知识

日志是把数据库的每一个变化都记载到一个专用的文件里，这种文件就叫做日志文件。mysql默认只开启错误日志，因为过多的日志将会影响系统的处理性能。

在mysql5.0以前版本支持文本格式和二进制格式的日志，但是在mysql5.0后版本就只支持二进制格式的日志。因为二进制日志在性能、信息处理等方面有更多的优点。

## **2**、启用mysql二进制日志

mysql二进制日志由配置文件my.cnf的log-bin选项负责启用的。

mysql服务器默认会在数据根目录创建两个新文件：XXX-bin.000001和XXX-bin.index。若配置选项没有给出文件名，mysql将使用mysql-bin来命名这两个文件，其中.index文件包含一份完整的日志文件清单。如下：

cat /etc/my.cnf

ll /usr/local/mysql/data/

cat /usr/local/mysql/data/mysql-bin.index

[![clip_image001[4\]](https://images0.cnblogs.com/blog/62984/201411/070951426273757.png)](https://images0.cnblogs.com/blog/62984/201411/070951421425073.png)

[![clip_image002[4\]](https://images0.cnblogs.com/blog/62984/201411/070951434083885.png)](https://images0.cnblogs.com/blog/62984/201411/070951430497928.png)

**mysql**会把用户对所有数据库的内容和结构的修改情况记入XXX-bin.n文件，但是不会记录SELECT和没有实际更新的UPDATE语句。**

当然我们也可以同过相关命令查询，mysql是否已经开启binlog日志。如下：

show variables like 'log_%';

[![clip_image003[4\]](https://images0.cnblogs.com/blog/62984/201411/070951444865455.png)](https://images0.cnblogs.com/blog/62984/201411/070951439393257.png)

## **3**、binlog日志文件的生成

当mysql停止或重启时，服务器会把日志文件记入下一个日志文件，mysql会在重启时生成一个新的日志文件，文件序号依次递增。

如果日志文件超过max_binlog_size（在my.cnf文件中配置）系统变量配置的上限时，也会生成新的日志文件。

除此之外，如果在mysql命令中执行flush logs命令也会生成新的日志文件。

[![clip_image004[4\]](https://images0.cnblogs.com/blog/62984/201411/070951452363826.png)](https://images0.cnblogs.com/blog/62984/201411/070951449243856.png)

## **4**、查看系统中的binlog日志

查看系统中的binlog日志，使用show master logs命令。如下：

show master logs;

[![clip_image005[4\]](https://images0.cnblogs.com/blog/62984/201411/070951465958311.png)](https://images0.cnblogs.com/blog/62984/201411/070951455498498.png)

## **5**、查看binlog日志文件

mysql提供了mysqlbinlog命令来查看日志文件，在记录每条变更日志的时候，日志文件都会把当前时间给记录下来，以便进行数据库恢复。如下：

mysqlbinlog mysql-bin.000001| more

[![clip_image006[4\]](https://images0.cnblogs.com/blog/62984/201411/070951474556182.png)](https://images0.cnblogs.com/blog/62984/201411/070951469707497.png)

## **6**、使用binlog日志进行数据库恢复

如果遇到灾难事件，应该用最近一次制作的完整备份恢复数据库，然后使用备份之后的binlog日志件把数据库恢复到最接近现在的可用状态。

使用binlog日志进行恢复时需要依次进行，即最早生成的日志文件要最先恢复。恢复数据的命令格式如下：

mysqlbinlog xxx-bin.000001|mysql -u root –p password dataname

有关使用binlog进行数据库的恢复，我会以后的文章进行详细介绍。

## **7**、binlog命令行参数详解

log-bin [=file_name] 此参数表示启用binlog日志功能，并可以定制路径名称，默认为mysql-bin。

binlog_format 此参数配置binlog的日志格式，默认为mixed。

max_binlog_size此参数配置binlog的日志最大值，最大和默认值是1GB。

max_binlog_cache_size此参数表示binlog使用最大内存的数。

binlog-do-db=db_name 此参数表示只记录指定数据库的二进制日志。

binlog-ignore-db=db_name此参数表示不记录指定的数据库的二进制日志。

expire_logs_days 此参数表示binlog日志保留的时间，默认单位是天。

my.cnf配置文件有关binlog配置如下：

cat /etc/my.cnf |grep -v ^#|grep -v ^$

[![clip_image007[4\]](https://images0.cnblogs.com/blog/62984/201411/070951488928410.png)](https://images0.cnblogs.com/blog/62984/201411/070951481588567.png)

## **8**、删除binlog日志

### **8.1**删除部分binlog日志

删除binlog部分日志，我们可以日志名称和日志生成的时间来进行删除。删除命令如下：

purge {master|binary} logs to 'log_name';

根据日志名称删除，只删除log_name之前的日志，log_name本身不会被删除。

[![clip_image008[4\]](https://images0.cnblogs.com/blog/62984/201411/070951500641953.png)](https://images0.cnblogs.com/blog/62984/201411/070951495649038.png)

通过上图我们可以看到，mysql-bin.000003之前的日志已经被全部删除。

purge {master|binary} logs before 'date’;

根据日志生成的时间删除，只删除date之前的日志，date本身不会被删除。

[![clip_image009[4\]](https://images0.cnblogs.com/blog/62984/201411/070951510179794.png)](https://images0.cnblogs.com/blog/62984/201411/070951504391138.png)

### **8.2**删除全部binlog日志

删除之前所有的binlog日志，并重新生成新的binlog，后缀从000001开始。使用命令：

reset master;

[![clip_image010](https://images0.cnblogs.com/blog/62984/201411/070951523923808.png)](https://images0.cnblogs.com/blog/62984/201411/070951516272208.png)