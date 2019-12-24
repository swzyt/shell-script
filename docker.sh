# !/bin/bash
# 参考链接 
# https://www.cnblogs.com/xiamaojjie/p/12083120.html
# https://www.cnblogs.com/yufeng218/p/8370670.html

# 日志格式化输出函数
function log() {
    echo ""
    echo "*********************************************************************************************************************"
    echo `date "+%Y-%m-%d %H:%M:%S":` $1 $2 $3
}

log "卸载docker"

log "删除系统已安装的docker及其依赖命令"
yum remove docker  docker-common docker-selinux docker-engine

log "开始安装"

log "安装docker依赖包"
yum install -y yum-utils device-mapper-persistent-data lvm2

log "添加docker镜像源"
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

log "更新yum缓存"
yum makecache fast

log "安装docker"
yum install docker-ce

log "docker info"
docker info

log "启动并加入开机启动"
systemctl start docker
systemctl enable docker
systemctl daemon-reload

log "安装完成"