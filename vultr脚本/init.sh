#
$url = 'http://jingzhongwa.cn'
# wget $url/add_swoole_extension_to_phpini.sh /root/
# wget $url/pecl_install_swoole.sh /root/
# wget $url/swoole-4.4.14.tgz /root/
wget https://getcomposer.org/download/1.10.1/composer.phar;
mv composer.phar /usr/bin/composer;
git clone https://github.com/walkor/phptty;
cd phptty;
composer install;
cd;


#

yum install epel-release -y; \
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm; \
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm; \
curl -sL https://rpm.nodesource.com/setup_13.x | bash -;\
yum install -y yum-utils device-mapper-persistent-data lvm2;
yum-config-manager --add-repo http://download.docker.com/linux/centos/docker-ce.repo;
yum install -y docker-ce
yum -y remove php*; \
yum -y install php72w \
php72w-cli \
php72w-fpm \
php72w-common \
php72w-devel \
php72w-embedded \
php72w-gd \
php72w-mbstring \
php72w-mysqlnd \
php72w-opcache \
php72w-pdo \
php72w-xml \
php72w-pear \
php72w-pecl-redis \
php72w-process \
gcc \
gcc-c++ \
git \
automake \
autoconf \
libtool \
make \
vim \
net-tools \
iputils \
nginx \
openssl \
openssl-devel \
expect \
nodejs;
# chmod a+x /tmp/pecl_install_swoole.sh; \
# npm install -g forever; \
# expect脚本不能和其他脚本或命令在同一个RUN里面，必须单独进行
# /tmp/pecl_install_swoole.sh ; \
# expect脚本不能和其他脚本或命令在同一个RUN里面，必须单独进行
# sh /tmp/add_swoole_extension_to_phpini.sh;


#启动docker
systemctl start docker;
systemctl enable  docker;
docker pull jingzhongwa/php-swoole:0.2;
docker pull jingzhongwa/centos-worker:0.5;
docker pull mysql:5.7;
docker pull redis;