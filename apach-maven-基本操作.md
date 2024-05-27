# apach-maven

[TOC]



## 目录详解:

### bin:

包含了mvn(主要用来构建项目)运行的脚本，在命令行输入任意一条mvn命令其实就是调用了这些脚本



### boot：

该jar是maven的类加载框架用来加载自己的类库，相对于默认的java类加载器，提供了更丰富的语法及配置



### conf：

包含settings.xml文件，可以全局定制maven行为。一般情况下，我们会将settings.xml文件复制到~/.m2/目录下，在用户范围内定制maven行为



### lib：

该目录包含了maven运行时需要的java类库



其中注意的一点是：可以在lib包下找到maven内置的超级POM，一般存放在名叫maven-model-builder的jar包里面

![image-20200509092921653](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200509092921653.png)

解压之后进入\org\apache\maven\model\目录就能找到

![image-20200509092858413](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200509092858413.png)

#### 超级POM详解

超级POM是所有maven项目的父pom，所有项目都继承这个超级pom，在maven的发行版中都会有

超级pom中配置有

　　1.中央仓库地址

　　2.项目构建的默认目录

　　3.自带的profile

### LICENSE：

记录maven使用的软件许可证

### NOTICE：

记录maven包含的第三方软件



## 配置环境变量(需要依赖JAVA_HOME)

1、复制解压后的maven目录

2、在环境变量中，新建MAVEN_HOME：变量值：复制的目录

 3、进入path——>新建：%MAVEN_HOME%\bin

4、测试是否配置成功：mvn -v



## maven仓库的种类和关系

例如：已有一个maven项目，其中maven并不会jar包，只有jar包的坐标

​	启动maven项目时，maven会根据jar包坐标找到对应的jar包

maven的仓库：maven文件夹/conf/settings.xml

![image-20200509101633872](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200509101633872.png)

表示在系统盘的用户目录、创建一个.m2文件夹、在创建一个repository文件夹、作为默认的本地仓库的位置



启动maven项目，会根据jar包坐标(在本地仓库)找到对应的jar包，如果本地仓库没有，那么会自动进行联网，到<span style='color:red'>中央仓库(近乎囊括了所有开源的jar包)</span>>进行下载<span style='color:red'>(无网络，则报错)</span>

![image-20200509103154726](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200509103154726.png)



一般本地仓库不会放置太多的文件，且可以通过（再复制一行）

<localRepository>/path/to/local/repo</localRepository>

修改指定的路径，标签中放指定maven仓库的路径

如：<localRepository>E:\maven_repository</localRepository>





## 常用maven命令(在项目中执行)

**mvn -v ->** 查看maven版本	

**mvn compile(编译) ->** 编译(src下java文件夹)项目

**mvn test ->** 运行测试(编译src下java文件夹和test文件夹)

**mvn package ->** 打包、放在target目录下，会把test和java目录下的文件进行编译；如何生成一个war包

在pom.xml文件内，指定了打包为war包

![image-20200509122746759](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200509122746759.png)



**mvn clean ->** 删除target，该文件夹存放的是编译后的类以及测试报告等。移除所有上一次构建生成的文件。

**mvn install ->** 安装jar包到本地仓库中（target包是项目编译/打包后的(test和java文件夹)，且把war包安装在了本地仓库)

<localRepository>E:\maven_repository</localRepository>

或者是系统盘内默认的位置







## maven的核心是一键构建(通过命令)

清除项目编译信息	编译			测试			打包			安装			发布

clean						compile		test		package	install		deploy

![](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\maven的生命周期.png)

默认周期最常用







## idea集成maven插件(IntelliJ IDEA 2020.1/plugins/maven/lib/maven3有包含)

进入settings——>Build,Execution,Deployment——>Build Tools

——>Maven——>右侧的<span style='color:red'>Maven home directory选择本地解压的目录</span>——><span style='color:red'>User settings file选择maven目录下的conf/settings.xml</span>>

如果Local repository没有自动填充——>那么就手动选择本地仓库的路径



在Maven下<span style='color:red'>Runner的VM Options：-DarchetypeCatalog=internal</span>

表示，在断网时，也可以正常创建项目(在本地有对应插件时)



## 创建maven项目

(若不使用idea提供的模板，就省略勾选和后一步)

(idea提供的maven项目的模板，需要联网，不联网就需要上面设置的不联网)

选择maven项目——>勾选Create from archetype——>选择quitstart结尾的(idea提供的maven骨架)——>next——>GruupId：项目所在的坐标(公司或公司域名：com.itheima)——>ArtiactId：项目名称(maven_java)——>Version：项目的版本(一般不用改)

以下的信息是，确认使用的maven环境

第一个：使用的本地maven

第二个：选择maven下conf配置文件settings.xml

第三个：编译或运行时，在某处找jar包

![image-20200510115201050](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200510115201050.png)

项目名称和项目所放位置

![image-20200510115445423](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200510115445423.png)



如果出现











## 创建web项目，其余后面都是一样的

选择maven项目——>勾选Create from archetype——>选择webapp结尾的(idea提供的maven骨架)——>next——>GruupId：项目所在的坐标(公司或公司域名：com.itheima)——>ArtiactId：项目名称(maven_java)——>Version：项目的版本(一般不用改)





想在其他目录也创建jsp/jspx，那么在以下位置，添加对应的文件夹，左斜杠表示，子目录也可以创建

![image-20200510225857141](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200510225857141.png)







![image-20200510230107741](C:\Users\17291\AppData\Roaming\Typora\typora-user-images\image-20200510230107741.png)

mvn: tomcat:run表示启动tomcat