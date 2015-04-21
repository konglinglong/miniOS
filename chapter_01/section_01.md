## 计算机启动过程
### 加电
&#160; &#160; &#160; &#160;电源开关被按下时，机器就开始供电，主板的控制芯片组会CPU（Central Processing Unit，中央处理器）发出并保持一个RESET（重置）信号，让CPU恢复到初始状态。当芯片组检测到电源已经开始稳定供电时就会撤去RESET信号（松开台式机的重启键是一样的效果），这时CPU就从0xffff0处开始执行指令。这个地址在系统BIOS（Basic Input/Output System，基本输入输出系统）的地址范围内，大部分系统BIOS厂商放在这里的都只是一条跳转指令，跳到系统BIOS真正的启动代码处。
### 自检
&#160; &#160; &#160; &#160;系统BIOS的启动代码首先要做的事情就是进行POST（Power-On Self Test，加电后自检），POST的主要任务是检测系统中一些关键设备是否存在和能否正常工作，例如内存和显卡等。由于POST是最早进行的检测过程，此时显卡还没有初始化，如果系统BIOS在POST的过程中发现了一些致命错误，例如没有找到内存或者内存有问题（此时只会检查640K常规内存），那么系统BIOS就会直接控制喇叭发声来报告错误，声音的长短和次数代表了错误的类型。
### 初始化设备
&#160; &#160; &#160; &#160;接下来系统BIOS将查找显卡的BIOS，存放显卡BIOS的ROM芯片的起始地址通常设在0xC0000处，系统BIOS在这个地方找到显卡 BIOS之后就调用它的初始化代码，由显卡BIOS来初始化显卡，此时多数显卡都会在屏幕上显示出一些初始化信息，介绍生产厂商、图形芯片类型等内容。系统BIOS接着会查找其它设备的BIOS程序，找到之后同样要调用这些BIOS内部的初始化代码来初始化相关的设备。
### 测试设备
&#160; &#160; &#160; &#160;查找完所有其它设备的BIOS之后，系统BIOS将显示出它自己的启动画面，其中包括有系统BIOS的类型、序列号和版本号等内容。接着系统BIOS将检测和显示CPU的类型和工作频率，然后开始测试所有的RAM（Random Access Memory，随机访问存储器），并同时在屏幕上显示内存测试的进度。内存测试通过之后，系统BIOS将开始检测系统中安装的一些标准硬件设备，包括硬盘、光驱、串口、并口、软驱等，另外绝大多数较新版本的系统BIOS在这一过程中还要自动检测和设置内存的定时参数、硬盘参数和访问模式等。标准设备检测完毕后，系统BIOS内部的支持即插即用的代码将开始检测和配置系统中安装的即插即用设备，每找到一个设备之后，系统BIOS都会在屏幕上显示出设备的名称和型号等信息，同时为该设备分配中断（INT）、DMA（Direct Memory Access，直接存储器存取）通道和I/O（Input/Output，输入输出）端口等资源。