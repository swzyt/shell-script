#!/bin/bash
#Author:GaoHongYu
#QQ:1061767621
#Time:2019-12-24 18:43:22
#Name:ncjk.sh
#Version:V1.0
clear
xtip=$(ip a | grep "inet"|tail -1|cut -d " " -f 6)
cprl=$(df -Th |head -2|tail -1|cut -d " " -f 10)
cpky=$(df -Th |head -2|tail -1|cut -d " " -f 12)
cpbfb=$(df -Th |head -2|tail -1|cut -d " " -f 18)
ncrl=$(free -m |head -2|tail -1|cut -d " " -f 13)
ncsy=$(free -m |head -2|tail -1|cut -d " " -f 22)
i=1
while [ $i -le 60 ];do
   echo -e '\n' 
   echo -e '\n' 
   echo "-----磁盘监控系统-----"
   echo "--作者：Mr_GaoHongYu--"
   echo -n "监控本机IP地址："$xtip
   echo -e '\n'
   echo "-----磁盘使用情况-----"
   echo -n "系统磁盘总容量："$cprl
   echo -e '\n'
   echo -n "当前磁盘可用容量："$cpky
   echo -e '\n'
   echo -n "可用容量百分比："$cpbfb
   echo -e '\n'
   echo "-----内存使用情况-----"
   echo -n "内存总容量："$ncrl
   echo -e '\n'
   echo -n "内存已使用："$ncsy
   echo -e '\n'
   echo -n "内存已用百分比："
   echo $((ncrl/ncsy))'%'
        sleep 60
    let i++
done