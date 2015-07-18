# lvyou_iOS
感想来自学生时代的时候做了大学生时代web作品之一     

弗兰迪维（php&amp;android&amp;ios）  

浙江省第九届大学生电子商务竞赛 参赛作品  浙江省浙大网新服务外包大赛 参赛作品 

只好还做了一个app(Ios Android)，

为配合第二个服务外包大赛的旅游管理功能


系统之初考虑采用Splider技术，它是搜索引擎进行互联网数据采集的核心系统，它现值入一个url地址，<br/>
再通过这个url地中页面上所有的内容进行筛选入库，其中在此页面上的url进行二次入库，<br/>
当此页面所需内容全部采集成功，再将新入库的url地址进行内容采集！然后再对新入库的Url进行采集，<br/>
并且负责对采集过的Url进行更新采集，如此循环。<br/>

根据以上原理，本系统搭建之初对一家国际网站开始进行数据采集<br/>

上demo将一个机票网站url填入，然后从指定的url获取html内容其获取html内容demo<br/>

将内容获取到，则程序将会从这些内容通过正则表达来匹配出url的地址，<br/>
并且返回保存这些地址，关于匹配url地址的demo如下，$url就为传入的参数<br/>

接下来就说获取正确的内容，由于系统核心就是关于获取怎样的内容<br/>
所以关于获取内容的正则匹配不便于公开展示！<br/>
但是原理如上所属的获取从html内容中的url相同！<br/>

##WEB
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/web_1.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/web_2.png?raw=true)<br/>

当系统获取新的一层url将再去执行这些url抓取内容和链接，新的链接一旦新增入库，<br/>
将又从这些新增入库的url链接再去执行内容抓取！<br/>
这就是本系统基于Splider技术的基础demo！<br/>

![image](https://github.com/fengss/lvyou_iOS/blob/master/img/web_3.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/web_4.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/web_5.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/wen_6.jpg?raw=true)<br/>

##IOS
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/1.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/2.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/3.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/4.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/5.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/6.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/7.png?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/8.png?raw=true)<br/>

##Adnroid
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/android_1.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/android_2.jpg?raw=true)<br/>
![image](https://github.com/fengss/lvyou_iOS/blob/master/img/android_3.jpg?raw=true)<br/>
