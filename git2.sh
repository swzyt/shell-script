cd tools && mkdir git && cd git

yum remove git 
wget --no-check-certificate https://www.kernel.org/pub/software/scm/git/git-2.8.4.tar.gz

tar -zxvf git-2.8.4.tar.gz

yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel
yum install -y gcc perl-ExtUtils-MakeMaker

# 升级 解决  SSL connect error
yum update -y nss curl libcurl

# 切换到git目录
cd git-2.8.4
# 创建要安装的目录
mkdir -p  /usr/local/git
# 编译安装
make prefix=/usr/local/git all
make prefix=/usr/local/git install

# 添加环境变量
vim /etc/profile
# 添加以下配置
export PATH=$PATH:/usr/local/git/bin

#使新加的环境变量生效
source /etc/profile
# 验证是否配置成功
git --version