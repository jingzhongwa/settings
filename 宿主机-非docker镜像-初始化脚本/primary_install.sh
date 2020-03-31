yum install epel-release -y; \
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm; \
rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm; \
curl -sL https://rpm.nodesource.com/setup_13.x | bash -;\
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
gcc \
gcc-c++ \
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
nodejs; \
chmod a+x ./pecl_install_swoole.sh; \
npm install -g forever; \
# expect脚本不能和其他脚本或命令在同一个RUN里面，必须单独进行
./pecl_install_swoole.sh ; \
# expect脚本不能和其他脚本或命令在同一个RUN里面，必须单独进行
sh ./add_swoole_extension_to_phpini.sh;