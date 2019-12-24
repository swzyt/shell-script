# 日志格式化输出函数
function log() {
    echo ""
    echo "*********************************************************************************************************************"
    echo `date "+%Y-%m-%d %H:%M:%S":` $1 $2 $3
}
log "安装git"
yum install -y git

log "git 配置"
git config --global user.email "915429829@qq.com"
git config --global user.name "swzyt"

log "clone 脚本库"
cd /app
git clone https://github.com/swzyt/shell-script.git