# !/bin/bash

# 日志格式化输出函数
function log() {
    echo ""
    echo "*********************************************************************************************************************"
    echo `date "+%Y-%m-%d %H:%M:%S":` $1 $2 $3
}

log "开始安装"

log "下载 node.js"
curl --silent --location https://rpm.nodesource.com/setup_11.x | sudo bash -
log "安装 node.js"
yum -y install nodejs
log "安装 cnpm"
npm install -g cnpm --registry=https://registry.npm.taobao.org
log "安装 pm2"
cnpm install pm2 -g

log "版本输出"
log "nodejs"
node -v
log "npm"
npm -v
log "cnpm"
cnpm -v
log "pm2"
pm2 -v

log "安装完成"