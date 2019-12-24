# !/bin/bash
# shell install mysql5.7
# 添加执行权限 chmod +x ./shell/mysql.sh
# 参考链接 
# https://blog.csdn.net/q13554515812/article/details/85317942

# 日志格式化输出函数
function log() {
    echo ""
    echo "*********************************************************************************************************************"
    echo `date "+%Y-%m-%d %H:%M:%S":` $1 $2 $3
}

PASSWORD="P@ssW0rd"

log "卸载mysql"
log "检测系统是否已安装mysql"
yum list installed | grep mysql
log "删除系统已安装的mysql及其依赖命令"
yum -y remove mysql mysql-server mysql-libs mysql-server

log "开始安装"

log "创建mysql包文件夹并进入"
cd /app/tools && mkdir mysql && cd mysql
log "下载 mysql Yum Repository"
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
log "安装 mysql Yum Repository"
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server
log "启动 mysql 服务"
systemctl start  mysqld.service
log "输出 mysql 运行状态"
systemctl status mysqld.service
log "查询 mysql 初始密码"
grep "password" /var/log/mysqld.log
log "自动进入 mysql 服务，设置自定义密码"
log "输入 mysql 初始密码: "
read -p "(Default password: root):" mysqlrootpwd
log "初始密码: " ${mysqlrootpwd}
log "重置密码为: " ${PASSWORD} "。并开启远程登录"
# mysql安全策略 交换模式下，使用 --connect-expired-password 这个选项，否则会报错
# --connect-expired-password
mysql --connect-expired-password -uroot -p${mysqlrootpwd} <<EOF
set password for root@localhost = password('${PASSWORD}');
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${PASSWORD}' WITH GRANT OPTION;
flush privileges;
EOF
# mysql -uroot -p${mysqlrootpwd} -e "set password for root@localhost = password('${PASSWORD}');GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${PASSWORD}' WITH GRANT OPTION;flush privileges;exit;"
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${PASSWORD}' WITH GRANT OPTION;
# mysqladmin -u root -p${mysqlrootpwd} password "${PASSWORD}"

log "设置开机自启"
systemctl enable mysqld
systemctl daemon-reload

if ps -ef | grep firewalld | egrep -v grep >/dev/null; 
then     
    log "防火墙已启动"; 
else     
    log "防火墙未启动，即将启动";     
    systemctl start firewalld; 
fi

log "开启mysql监听的3306端口"
firewall-cmd --zone=public --add-port=3306/tcp --permanent
log "重载防火墙"
firewall-cmd --reload

log "安装完成"