## vim查看行号

```shell
:set number
:set nu
```

## vim到第一行

```shell
gg

# 到文本最后一行
G

# 到文本指定行数
:n
```



## vim搜索

```shell
:/关键词
```



## 查看内核版本

```shell
uname -a
```



## 查看linux版本

```shell
cat /etc/redhat-release
```



## 硬盘使用情况

```shell
df -h
```



## cpu查看

```shell
more /proc/cpuinfo | grep "model name"
```



## 查看cpu是32位还是64位

```shell
getconf LONG_BIT
```



## 查看内存

```shell
free -m
```



## 查看dns

```shell
cat /etc/resolv.conf
```

## 保存用户信息的文件

```shell
/etc/passwd
```

## 保存密码的文件

```shell
/etc/shadow
```



# 关机命令

```shell
reboot #重启
shutdown -r 10 #过十分钟重启
shutdown -r 20:00 #在8:00时重启
halt/poweroff/shutdown -h now/init 0 #关机
shutdown -h 10 #过10分钟关机
```



# 防火墙设置

```shell
#查看防火墙状态
systemctl status firewalld 
#开启防火墙
systemctl start firewalld
#关闭防火墙
systemctl stop firewalld
#禁止开机启动
systemctl disable firewalld
```



# 目录操作命令

```shell
# 目录操作命令
pwd
#切换工作目录
cd [目录位置]

#列表
ll
ls	[选项]... [目录或文件名]
    #-l ：详细信息显示
    #-a：显示所有子目录和文件的信息，包括隐藏文件
    #-A：类似于“-a”，但不显示“.”和“…”目录的信息
    #-R：递归显示内容
    
# 创建新的目录
mkdir [-p] [/路径/]目录名

#统计目录及文件的空间占用情况
du [选项]... [目录或文件名]
	#-a：统计时包括所有的文件，而不仅仅只统计目录
	#-h：以更易读的字节单位（K、M等）显示信息
	#-s：只统计每个参数所占用空间总的大小
```



# 文件操作命令

```shell
#新建空文件
touch 文件名
#查看文件类型
file 文件名
#复制（copy）文件或目录
cp [选项] 源文件或目录… 目标文件或目录
	#-r：递归复制整个目录树
	#-p：保持源文件的属性不变
	#-f：强制覆盖目标同名文件或目录
	#-i：需要覆盖文件或目录时进行提醒

#删除（Remove）文件或目录
rm [选项] 文件或目录
	#-f：强行删除文件，不进行提醒
	#-i：删除文件时提醒用户确认
	#-r：递归删除整个目录树

# 移动（Move）文件或目录
mv [选项]... 源文件或目录… 目标文件或目录

# 显示系统命令所在目录
which <选项> command（命令名称）
	# -a：将所有由PATH路径中可以找到的指令均列出，而不止第一个被找到的指令名称
	
# find查找
find <路径> <选项> [表达式]
			# -name 根据文件名查找
			# -user 根据文件拥有者查找
			# -group 根据文件所属组寻找文件
			# -perm 根据文件权限查找文件
			# -size 根据文件大小查找文件
			# -type 根据文件类型查找（f-普通文件，c-字符设备文件，b-块设备文件，l-链接文件，d-目录）
			# -o 表达式或
			# -and 表达式与
```



# 文件内容操作命令

```shell
# 显示出文件的全部内容
cat 文件名
# 全屏方式分页显示文件内容
more 文件名
[交互操作方法
按Enter键向下逐行滚动
按空格键向下翻一屏、按b键向上翻一屏
按q键退出]

# 与more命令相同
less

# 查看文件开头的一部分内容（默认为10行）
head -n 文件名

# 查看文件结尾的少部分内容（默认为10行）
tail -n 文件名
tail -f 文件名

# 统计文件中的单词数量（Word Count）等信息
wc [选项] 目标文件
	# -l：统计行数
	#-w：统计单词个数
	#-c：统计字节数
	
# 查找文件里符合条件的字符串
grep [选项] <关键字> <文件…>
	# -c:计算匹配关键字的行数
	# -i:忽略字符大小写的差别
	# -n:显示匹配的行及其行号
	# -s:不显示不存在或不匹配文本的错误信息
	# -h: 查询多个文件时不显示文件名
	# -l:查询文件时只显示匹配字符所在的文件名
	# –color=auto:将找到的关键字部分加上颜色显示
```



# 压缩命令

```shell
# 压缩（解压）文件或目录，压缩文件后缀为gz
gzip [选项] 压缩（解压缩）的文件名
gzip file1	#压缩 file1
gzip -9 file1                                #最大程度压缩 file1
gunzip file1.gz                            #解压 file1.gz
	# -d将压缩文件解压（decompress）
	# -l显示压缩文件的大小，未压缩文件的大小，压缩比（list）
	# -v显示文件名和压缩比（verbose）
	# -num用指定的数字num调整压缩的速度，-1或–fast表示最快压缩方法（低压缩比），-9或–best表示最慢压缩方法（高压缩比）。系统缺省值为6

# 压缩（解压）文件或目录，压缩文件后缀为bz2
bzip2 [-cdz] 文档名
bzip2 file1 
bunzip2 file1.bz2	#bunzip2 file1.bz2
	# -c将压缩的过程产生的数据输出到屏幕上
	#-d解压缩的参数（decompress）
	#-z压缩的参数（compress）
	#-num 用指定的数字num调整压缩的速度，-1或–fast表示最快压缩方法（低压缩比），-9或–best表示最慢压缩方法（高压缩比）。系统缺省值为6
	
# 压缩、解压tar文件
tar [cvf]...	压缩名 文件名（压缩文件）
tar [xvf]...	文件名.tar（解压文件）
tar -xvf archive.tar                      #释放一个包
tar -xvf archive.tar -C /tmp         把#压缩包释放到 /tmp目录下
	# -c：创建 .tar 格式的包文件
	# -x：解开.tar格式的包文件
	# -v：输出详细信息
	# -f：表示使用归档文件
	
# 压缩、解压zip文件
zip file1.zip file1                          #创建一个zip格式的压缩包
zip -r file1.zip file1 dir1               #把文件和目录压缩成一个zip格式的压缩包
unzip file1.zip                             #解压一个zip格式的压缩包到当前目录
unzip test.zip -d /tmp/                 #解压一个zip格式的压缩包到 /tmp 目录
```



## 软连接

usr/sbin目录内--->全局都可访问

```shell
ln -s  源文件(最好写绝对路径)  目标文件
修改
ln –snf  源文件    软连接

删除 只删除软连接
rm -rf 软连接名

只删除源文件
rm -rf 源文件

-r循环
-f强制
```





# [Centos端口命令](https://www.cnblogs.com/gavin-yao/p/10505619.html)

> [Centos7开放及查看端口 - heqiuyong - 博客园 (cnblogs.com)](https://www.cnblogs.com/heqiuyong/p/10460150.html)
>
> 1、开放端口
>
> **firewall-cmd --zone=public --add-port=5672/tcp --permanent**  # 开放5672端口
>
> **firewall-cmd --zone=public --remove-port=5672/tcp --permanent** #关闭5672端口
>
> **firewall-cmd --reload**  # 配置立即生效
>
>  
>
> 2、查看防火墙所有开放的端口
>
> **firewall-cmd --zone=public --list-ports**
>
>  
>
> 3.、关闭防火墙
>
> 如果要开放的端口太多，嫌麻烦，可以关闭防火墙，安全性自行评估
>
> **systemctl stop firewalld.service**
>
>  
>
> 4、查看防火墙状态
>
>  **firewall-cmd --state**
>
>  
>
> 5、查看监听的端口
>
> **netstat -lnpt**
>
> ![img](http://47.98.232.139:9993/2022/01/05/90c32bd4f149c.png)
>
> *PS:centos7默认没有 netstat 命令，需要安装 net-tools 工具，yum install -y net-tools*
>
> **[Linux](https://www.centos.bz/tag/linux/):**
>
> ```
> netstat -nap #会列出所有正在使用的端口及关联的进程/应用
> lsof -i :portnumber #portnumber要用具体的端口号代替，可以直接列出该端口听使用进程/应用
> ```
>
> **1、检查端口被哪个进程占用**
>
> 代码如下复制代码
>
> ```shell
> netstat -lnp|grep 88   #88请换为你的apache需要的端口，如：80
> ```
>
> SSH执行以上命令，可以查看到88端口正在被哪个进程使用。如下图，进程号为 1777 。
>
> **2、查看进程的详细信息**
>
> ```shell
> ps 1777
> ```
>
> SSH执行以上命令。查看相应进程号的程序详细路径。如下图。
>
> **3、杀掉进程，重新启动[apache](https://www.centos.bz/tag/apache/)**
>
> 代码如下复制代码
>
> ```shell
> kill -9 1777        #杀掉编号为1777的进程（请根据实际情况输入）
> service httpd start #启动apache
> ```
>
> SSH执行以上命令，如果没有问题，apache将可以正常启动。
>
> **[Windows](https://www.centos.bz/tag/windows/)系统:**
>
> ```shell
> netstat -nao #会列出端口关联的的进程号，可以通过任务管理器查看是哪个任务
> ```
>
> 最后一列为程序PID，再通过tasklist命令：tasklist | findstr 2724
>
> 再通过任务管理结束掉这个程序就可以了
>
> 原文出处：stnkw -> http://www.stnkw.com/linux/centoschakanduankouzhanyongqingkuanghekaiqiduankoumingling
>
>  
>
> 章二：
>
> 1.netstat  -anp  |grep  端口号
>
> 如下，我以3306为例，netstat  -anp  |grep  3306（此处备注下，我是以普通用户操作，故加上了sudo，如果是以root用户操作，不用加sudo即可查看），如下图1：
>
> ![img](http://47.98.232.139:9993/2022/01/05/1050807d702cb.png)
>
> ​                                           图1
>
> 图1中主要看监控状态为LISTEN表示已经被占用，最后一列显示被服务mysqld占用，查看具体端口号，只要有如图这一行就表示被占用了。
>
> 2.netstat  -nultp（此处不用加端口号）
>
> 该命令是查看当前所有已经使用的端口情况，如图2：
>
> ![img](http://47.98.232.139:9993/2022/01/05/b57b57ddf45eb.png)
>
> ​                                            图2
>
> 图中可以看出我的82端口没有被占用
>
> 3.netstat  -anp  |grep  82查看82端口的使用情况，如图3：
>
> ![img](http://47.98.232.139:9993/2022/01/05/f75000b108c51.png)
>
> ​                                                             图3
>
> 可以看出并没有LISTEN那一行，所以就表示没有被占用。此处注意，图中显示的LISTENING并不表示端口被占用，不要和LISTEN混淆哦，查看具体端口时候，必须要看到tcp，端口号，LISTEN那一行，才表示端口被占用了







---

# 修改Linux操作系统下22端口两种方法

[出自](https://www.edu.cn/xxh/ji_shu_ju_le_bu/200807/t20080703_306552.shtml)

需要先开端口；在进行修改；且改完需要重启

```sh
systemctl restart ssh
```



## **第一种**

01假如要改SSH的默认端口（22），那么你只要修改：/etc/ssh/sshd_config中Port 22，这里把22改成自己要设的端口就行了，不过千万别设和现已有的端口相同哦，以防造成未知后果。



02假如要限制SSH登陆的IP，那么可以如下做：



先：修改/etc/hosts.deny，在其中加入sshd:ALL

然后：修改：/etc/hosts.allow，在其中进行如下设置：sshd:192.168.0.241

这样就可以限制只有192.168.0.241的IP通过SSH登陆上LINUX机器了。当然在做为服务器方面，我都不装gnome和KDE的，而且很多东东都不装，这样增加安全系数



## **第二种**

首先修改配置文件

vi /etc/ssh/sshd_config



找到#Port 22一段，这里是标识默认使用22端口，修改为如下：



Port 22

Port 50000

然后保存退出



执行/etc/init.d/sshd restart

这样SSH端口将同时工作与22和50000上。



现在编辑防火墙配置：vi /etc/sysconfig/iptables



启用50000端口。

执行/etc/init.d/iptables restart



现在请使用ssh工具连接50000端口，来测试是否成功。如果连接成功了，则再次编辑sshd_config的设置，将里边的Port22删除，即可。



之所以先设置成两个端口，测试成功后再关闭一个端口，是为了方式在修改conf的过程中，万一出现掉线、断网、误操作等未知情况时候，还能通过另外一个端口连接上去调试以免发生连接不上必须派人去机房，导致问题更加复杂麻烦
