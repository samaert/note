## [linux安装mysql](https://www.jianshu.com/p/099c2fc943d6)



## 表结构查看

### 1、简单描述表结构，字段类型

```sql
desc tabl_name;
```

### 2、表生成的DDL

```sql
show create table table_name;
```

### 3、复制表结构

```sql
create table table1 like table;
```

### 4、复制数据

```sql
insert into table1 select * from table;
```

### 5、授权远程登录

```sql
grant select on *.* to 'reader'@'%' identified by '123456' WITH GRANT OPTION;
flush privileges;
```

### 6、查询数据直接插入

```sql
insert into t_visual_user_domain(`user_id`,`domain`,`group`) select id,'www.baidu.com' as domain,`group` from t_visual_user;
```

### 7、修改表结构

```sql
alter table competitor_goods add sku_id bigint(20) unsigned DEFAULT NULL COMMENT '商品销售码';
```



## 替换字符串其中一段

```sql
UPDATE emergency_plan set download_url = REPLACE(download_url, '127.0.0.1:8080', 'www.baidu.com');
```



### 计算两个时间差-分钟

```sql
SELECT TIMESTAMPDIFF(MINUTE, DATE_FORMAT('2021-12-13 16:10:59', '%Y-%m-%d %H:%i'), SYSDATE()) FROM DUAL
```



## Mysql中随机选择10条记录

```sql
SELECT * FROM article_info ORDER BY RAND() LIMIT 10;
```



## 创建存储过程

```sql
CREATE PROCEDURE `test_task`()
BEGIN
	DECLARE d bigint(20);
	DECLARE fail int(2);
	DECLARE time datetime;
	DECLARE has_data INT DEFAULT 1;
	DECLARE result CURSOR FOR SELECT id, fail_number, update_time FROM sys_users WHERE fail_number >= 5;
	DECLARE EXIT HANDLER FOR NOT FOUND SET has_data = 0;
	OPEN result;
		REPEAT
			FETCH result INTO d, fail, time;
			IF 30 < (SELECT TIMESTAMPDIFF(MINUTE, time, SYSDATE()) FROM DUAL) THEN
				UPDATE sys_users SET fail_number = 0 WHERE id = d;
			END IF;
			UNTIL has_data = 0
		END REPEAT;
		CLOSE result;
END
```



## 删除存储过程

```sql
drop procedure test_proce;
```



## 查看定时任务功能是否可用

```sql
show variables like '%event_sche%';
```

## 开启定时任务功能

```sql
# 临时设置，重启后就会恢复
set global event_scheduler=1;

# 长久性开启;需要在配置文件加入以下配置
[mysqld]event_scheduler=ON
```



## 查看所有定时任务信息

```sql
SELECT event_name,event_definition,interval_value,interval_field,STATUS FROM information_schema.EVENTS;
```



## 创建定时任务

```sql
-- 创建定时任务;30秒执行一次
CREATE EVENT test_job
	ON SCHEDULE EVERY 30 SECOND
	ON COMPLETION PRESERVE DISABLE
DO CALL test_task();
```

## 开启和关闭定时任务

```sql
-- 开启定时任务
ALTER EVENT test_proce ON COMPLETION PRESERVE ENABLE;
-- 关闭定时任务
ALTER EVENT test_proce ON COMPLETION PRESERVE DISABLE;
```



## 删除定时任务

```sql
drop event test_proce;
```



## 定时任务其他规则

```sql
-- 每秒执行1次
ON SCHEDULE EVERY 1 SECOND;
-- 每两分钟执行1次
ON SCHEDULE EVERY 2 MINUTE;
-- 每3天执行1次
ON SCHEDULE EVERY 3 DAY;


-- 5天后执行
ON SCHEDULE AT CURRENT_TIMESTAMP()+INTERVAL 5 DAY;
-- 10分钟后执行
ON SCHEDULE AT CURRENT_TIMESTAMP()+INTERVAL 10 MINUTE;
-- 在2016年10月1日，晚上9点50执行
ON SCHEDULE AT '2016-10-01 21:50:00';


-- 5天后开始每天都执行执行到下个月底
ON SCHEDULE EVERY 1 DAY STARTS CURRENT_TIMESTAMP()+INTERVAL 5 DAY ENDS CURRENT_TIMESTAMP()+INTERVAL 1 MONTH;

-- 从现在起每天执行，执行5天
ON SCHEDULE EVERY 1 DAY ENDS CURRENT_TIMESTAMP()+INTERVAL 5 DAY;

```



## 创建索引

```sql
ALTER TABLE 表名 ADD 索引类型(UNIQUE,PRIMARY,KEY,FULLTEXT,INDEX) 索引名 (字段名)  COMMENT '描述';
ALTER TABLE sys_operation_log ADD INDEX del_flag (del_flag) COMMENT '删除状态普通索引';
```

## 删除索引

```sql
DROP INDEX index_name ON table_name;
或者
ALTER TABLE table_name DROP INDEX index_name;
删除主键
ALTER TABLE table_name DROP PROMARY KEY;
```



## 数据库备份

```shell
mysqldump -uroot -proot --databases lsky mine wordpress > /myProject/mysqlbackup/backDb.sql
			用户名	密码					数据库 多个以空格隔开	输出路径和文件名
```





## MySql中MATCH函数使用

### 1.语法糖：

```sql
MATCH(title) against('KEY' IN BOOLEAN MODE)
MATCH(title,body) against('KEY' IN BOOLEAN MODE) -- mysql优化

```

### 2.使用注意：

> MySql默认支持全文检索的字符长度是4
> 能够用SHOW VARIABLES LIKE 'ft_min_word_len' 来查看指定的字符长度
> 也能够在mysql配置文件my.ini 更改最小字符长度，在my.ini 增长一行
> 好比：ft_min_word_len = 2，改完后重启mysql便可。
>
> mysql在集和查询中的对每一个合适的词都会先计算它们的权重，一个出如今多个文档中的词将有较低的权重(可能甚至有一个零权重)，由于在这个特定的集中，它有较低的语义值。
> 不然，若是词是较少的，它将获得一个较高的权重，mysql默认的阀值是50%，上面‘you’在每一个文档都出现，所以是100%，只有低于50%的才会出如今结果集中

### 3.检索表达式及语法

```sql
MATCH(title) against('+zhang -lishi ~wangwu zhaoliu*' IN BOOLEAN MODE)
-- +表示and,-表示not，~表示异或运算符，*表示全部，空格表示or 等等
```

### 4.特殊符号处理

> 当全文检索碰到特殊符号的时候，会触发函数自动对检索条件进行分词搜索。
> 注意：一些特殊符号属于函数的保留符号，函数会把符号解析成条件进行分词
> 例如：欣欣贸易（北京）有限公司 会自动拆分红 欣欣贸易，北京，有限公司去作搜索，返回包含欣欣贸易或者北京或者有限公司的记录。
>
> 这里注意下：mysql默认检索长度是4，这些条件中北京是两个字符，不会触发检索
> 也就是说最后检索的结果是只包含 欣欣贸易和有限公司 这两个条件的数据优化
>
> 不触发自动分词，须要把本身的检索条件用“双引号”包含起来
> 例如：MATCH(title) against('“欣欣贸易（北京）有限公司” “大华贸易（北京）股份有限公司”' IN BOOLEAN MODE)
>
> 上面所述但愿能对你们有帮助



## int(1) 和 int(10) 区别

> ## 困惑
>
> 最近遇到个问题，有个表的要加个user_id字段，user_id字段可能很大，于是我提mysql工单`alter table xxx ADD user_id int(1)`。领导看到我的sql工单，于是说：这`int(1)`怕是不够用吧，接下来是一通解释。 其实这不是我第一次遇到这样的问题了，其中不乏有工作5年以上的老司机。包括我经常在也看到同事也一直使用int(10)，感觉用了int(1)，字段的上限就被限制，真实情况肯定不是这样。
>
> ## 数据说话
>
> 我们知道在mysql中 int占4个字节，那么对于无符号的int，最大值是2^32-1 = 4294967295，将近40亿，难道用了int(1)，就不能达到这个最大值吗？
>
> ```
> CREATE TABLE `user` (
>   `id` int(1) unsigned NOT NULL AUTO_INCREMENT,
>    PRIMARY KEY (`id`)
> ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
> ```
>
> id字段为无符号的int(1)，我来插入一个最大值看看。
>
> ```
> mysql> INSERT INTO `user` (`id`) VALUES (4294967295);
> Query OK, 1 row affected (0.00 sec)
> ```
>
> 可以看到成功了，说明int后面的数字，不影响int本身支持的大小，int(1)、int(2)...int(10)没什么区别。
>
> ## 零填充
>
> 一般int后面的数字，配合zerofill一起使用才有效。先看个例子：
>
> ```
> CREATE TABLE `user` (
>   `id` int(4) unsigned zerofill NOT NULL AUTO_INCREMENT,
>    PRIMARY KEY (`id`)
> ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
> ```
>
> 注意int(4)后面加了个zerofill，我们先来插入4条数据。
>
> ```
> mysql> INSERT INTO `user` (`id`) VALUES (1),(10),(100),(1000);
> Query OK, 4 rows affected (0.00 sec)
> Records: 4  Duplicates: 0  Warnings: 0
> ```
>
> 分别插入1、10、100、1000 4条数据，然后我们来查询下：
>
> ```
> mysql> select * from user;
> +------+
> | id   |
> +------+
> | 0001 |
> | 0010 |
> | 0100 |
> | 1000 |
> +------+
> 4 rows in set (0.00 sec)
> ```
>
> 通过数据可以发现 int(4) + zerofill实现了不足4位补0的现象，单单int(4)是没有用的。 而且对于0001这种，底层存储的还是1，只是在展示的会补0。
>
> ## 总结
>
> int后面的数字不能表示字段的长度，int(num)一般加上zerofill，才有效果。zerofill的作用一般可以用在一些编号相关的数字中，比如学生的编号 001 002 ... 999这种，如果mysql没有零填充的功能，但是你又要格式化输出等长的数字编号时，那么你只能自己处理了。
>
> 
>
> 来源：juejin.cn/post/6992574502282477605

