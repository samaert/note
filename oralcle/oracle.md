## 2021年11月12日-条件存在则修改,不存在新增-天工楼

```sql
MERGE INTO  Tt_Vs_Cic_Clearance_Define T1
       USING (SELECT '" + 字段 + "' as DEALER_CODE FROM dual) T2 on (T1.DEALER_CODE=T2.DEALER_CODE)
        WHEN MATCHED THEN UPDATE SET T1.Update_Date = sysdate
        WHEN NOT MATCHED THEN  INSERT (CLEARANCE_ID, COUNTRY, DEALER_ID, DEALER_CODE, DEALER_NAME, CREATE_DATE) VALUES
        (?, ?, ?, ?, ?,sysdate)
```



## 2021年12月13日-新增表-天工楼

```sql
create table Tt_Vs_Ciclearance_Dtl_color(
       CLEARANCE_DTL_COLOR_ID number(16) primary key,
       CLEARANCE_ID number(16),
       clearance_dtl_id number(16),
       MATERIAL_ID number(16),
       EXTERIOR_COLOR_NAME VARCHAR2(30),
       EXTERIOR_COLOR_CODE VARCHAR2(30),
       MODEL_NAME varchar2(100),
       PACKAGE_CODE varchar2(100)
);
COMMENT ON table Tt_Vs_Ciclearance_Dtl_color IS '清关单基础数据颜色表';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.CLEARANCE_DTL_COLOR_ID is 'id';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.CLEARANCE_ID is '清关单基础表id';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.MATERIAL_ID is '物料表id';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.EXTERIOR_COLOR_NAME is '外饰颜色名称';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.EXTERIOR_COLOR_CODE is '外饰颜色code';
comment on column Tt_Vs_Ciclearance_Dtl_color.clearance_dtl_id is '清关单详细id';
COMMENT ON COLUMN Tt_Vs_Ciclearance_Dtl_color.MODEL_NAME is '车型编码';
comment on column Tt_Vs_Ciclearance_Dtl_color.PACKAGE_CODE is '配置编码';
```



## 2021年12月13日-新增字段-天工楼

```sql
alter table TT_PART_DLR_ORDER_MAIN
add (
  COUN_NAME_EN VARCHAR2(200)
  );
  comment on column TT_PART_DLR_ORDER_MAIN.COUN_NAME_EN is '国家名称(英文)';
```



## 2021年11月29日-存储过程-天工楼

```sql
CREATE OR REPLACE PROCEDURE I_WMS_CLOSE_MAKER IS
countMarkReq number;
countCaseNum number;

BEGIN

  -- 获取接口表数据；
  FOR C IN (select t.* from I_PACK_PKG_OPEN t where t.handle_status = 51101001)
      
   LOOP
     select count(1) into countMarkReq  from TT_PART_LABEL where MARK_REQ = C.CASE_NO;
     select count(1) into countMarkReq from TT_PART_LABEL_DETAILED where PKG_NO = C.CASE_NO;
    -- 业务 判断接口表类型;2:唛头主表,1:唛头明细
    if C.PACKING_TYPE = 2 and 0 < countMarkReq   THEN
      -- 唛头信息插入到备份表
      INSERT INTO TT_PART_LABEL_BAK select * from TT_PART_LABEL la where la.MARK_REQ = C.CASE_NO;
      -- 插入唛头对应明细表
      INSERT INTO TT_PART_LABEL_DETAILED_BAK select * from TT_PART_LABEL_DETAILED de where de.LABEL_ID IN (SELECT label_id FROM TT_PART_LABEL p WHERE p.MARK_REQ = C.CASE_NO);
      -- 删除唛头对应明细表
      DELETE FROM TT_PART_LABEL_DETAILED de WHERE de.label_id in (SELECT label_id FROM TT_PART_LABEL p WHERE p.MARK_REQ = C.CASE_NO);
      -- 删除唛头主表信息
      DELETE FROM TT_PART_LABEL p WHERE p.MARK_REQ = C.CASE_NO;
      -- 更改接口表状态，修改时间
      UPDATE I_PACK_PKG_OPEN SET HANDLE_STATUS = 51101002, handle_time = sysdate where CASE_NO = C.CASE_NO;
     elsif  C.PACKING_TYPE = 1 and 0 < countMarkReq THEN
      -- 唛头明细信息插入到备份表
      INSERT INTO TT_PART_LABEL_DETAILED_BAK select * from TT_PART_LABEL_DETAILED de where de.PKG_NO = C.CASE_NO;
      -- 删除唛头明细信息
      DELETE FROM TT_PART_LABEL_DETAILED d WHERE d.PKG_NO = C.CASE_NO;
      -- 更改接口表状态，修改时间
      UPDATE I_PACK_PKG_OPEN SET HANDLE_STATUS = 51101002, handle_time = sysdate where CASE_NO = C.CASE_NO;
      
    END IF;
  END LOOP;
  commit;
  EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    proc_error_log('I_WMS_CLOSE_MAKER', '');
END I_WMS_CLOSE_MAKER;

```





## 2021年11月29日-定时任务-天工楼

参考地址：https://www.cnblogs.com/Chestnuts/p/7068456.html

```sql
begin
  sys.dbms_job.submit(job => :job,
                      what => 'I_WMS_CLOSE_MAKER;',
                      next_date => to_date('29-11-2021 16:55:11', 'dd-mm-yyyy hh24:mi:ss'),
                      interval => 'SYSDATE + 20/1440');
  commit;
end;
/

```



## 修改表名

```sql
rename 旧表名 to 新表名;
rename user to newuser;
```



## 清除表数据

```sql
delete from 表名;	# 一条一条的删除数据，后面可以添加where条件，不删除表结构
truncate table 表名; # 次性删掉所有数据，不删除表结构
drop table 表名;	# 删除所有数据，会删除表结构
```



## 修改表字段

```sql
alter table 表名 modify (字段名 字段类型 默认值 是否为空);
alter table user modify((age number(8));
```



## 注释修改

```sql
oracle添加表注释：COMMENT ON table t1 IS '个人信息';
Oracle添加字段注释：comment on column t1.id is 'id';
```



## 修改字段名

```sql
alter table 表名 rename  column 列名 to 新列名;
alter table user rename column course to newcourse;
```



## 删除字段

```sql
alter table 表名 drop column 字段名;
alter table user drop column course;
```



### 查询日期，拼接日期

```sql

```



### trunc()函数的用法

```sql
/***************日期********************/
1.select trunc(sysdate) from dual --2013-01-06 今天的日期为2013-01-06
2.select trunc(sysdate, 'mm') from dual --2013-01-01 返回当月第一天.
3.select trunc(sysdate,'yy') from dual --2013-01-01 返回当年第一天
4.select trunc(sysdate,'dd') from dual --2013-01-06 返回当前年月日
5.select trunc(sysdate,'yyyy') from dual --2013-01-01 返回当年第一天
6.select trunc(sysdate,'d') from dual --2013-01-06 (星期天)返回当前星期的第一天
7.select trunc(sysdate, 'hh') from dual --2013-01-06 17:00:00 当前时间为17:35 
8.select trunc(sysdate, 'mi') from dual --2013-01-06 17:35:00 TRUNC()函数没有秒的精确
/***************数字********************/
/*
TRUNC（number,num_digits） 
Number 需要截尾取整的数字。 
Num_digits 用于指定取整精度的数字。Num_digits 的默认值为 0。
TRUNC()函数截取时不进行四舍五入
*/
9.select trunc(123.458) from dual --123
10.select trunc(123.458,0) from dual --123
11.select trunc(123.458,1) from dual --123.4
12.select trunc(123.458,-1) from dual --120
13.select trunc(123.458,-4) from dual --0
14.select trunc(123.458,4) from dual --123.458
15.select trunc(123) from dual --123
16.select trunc(123,1) from dual --123
17.select trunc(123,-1) from dual --120
```



## 日期计算

```sql
-- 计算两个日期相差秒数
SELECT TO_NUMBER((TO_DATE(TRUNC(SYSDATE)) - TO_DATE(TRUNC(t.lastsignin_time))) * 24 * 60 * 60) FROM tc_user t;

-- 计算两个日期相差分钟
SELECT TO_NUMBER((TO_DATE(TRUNC(SYSDATE)) - TO_DATE(TRUNC(t.lastsignin_time))) * 24 * 60) FROM tc_user t;

-- 计算两个日期相差小时
SELECT TO_NUMBER((TO_DATE(TRUNC(SYSDATE)) - TO_DATE(TRUNC(t.lastsignin_time))) * 24) FROM tc_user t;

-- 计算两个日期相差天数
SELECT TO_NUMBER(TO_DATE(TRUNC(SYSDATE)) - TO_DATE(TRUNC(t.lastsignin_time))) FROM tc_user t;

-- 计算两个日期相差月数
SELECT FLOOR(MONTHS_BETWEEN(TO_DATE(TRUNC(SYSDATE)), TO_DATE(TRUNC(t.lastsignin_time)))) FROM tc_user t;

-- 计算两个日期相差年份
SELECT (MONTHS_BETWEEN(TO_DATE(TRUNC(SYSDATE)), TO_DATE(TRUNC(t.lastsignin_time))) / 12) FROM tc_user t;
```

