# !/bin/bash

# 日志格式化输出函数
function log() {
    echo ""
    echo "*********************************************************************************************************************"
    echo `date "+%Y-%m-%d %H:%M:%S":` $1 $2 $3
}

log "开始安装"

log "安装 nginx"
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install -y nginx
log "启动 nginx 服务"
nginx

if ps -ef | grep firewalld | egrep -v grep >/dev/null; 
then     
    log "防火墙已启动"; 
else     
    log "防火墙未启动，即将启动";     
    systemctl start firewalld; 
fi

log "开启nginx监听的80端口"
firewall-cmd --zone=public --add-port=80/tcp --permanent
log "重载防火墙"
firewall-cmd --reload

log "安装完成"