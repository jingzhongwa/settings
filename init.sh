# 本文件将本配置文件目录中的所有配置文件依次放置到本地电脑对应位置
# 将home目录中的配置文件向系统的~/目录移动配置文件,因为全部拷贝不方便git进行版本控制，因此采用软链接的方式
# cp home/.[^.]* ~/
ln -s home/.bashrc ~/.bashrc

