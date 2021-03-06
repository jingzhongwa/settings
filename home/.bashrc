#!/bin/bash
# ----------------------------------------------------------------------------------------bash命令简写
alias ll='ls -al'
alias pv='php -v'
alias rdv='redis-server -v'
alias rdc='redis-cli'



# ----------------------------------------------------------------------------------------laravel
alias larac="composer create-project laravel/laravel --prefer-dist"


# ----------------------------------------------------------------------------------------composer
alias composerr="composer require"


# ----------------------------------------------------------------------------------------git--------------------

# 初始化git作者信息
function gitset (){
	git config --global user.name "jingzhongwa"
	git config --global user.email "jingzhongwa@yahoo.com"
}

# 初始化本地仓库并关联远程仓库 gitinit $remote_name
function gitinit(){
	git init
	git add -A
	git commit -m "first commit"
	url=git@github.com:${2:="jingzhongwa"}/${1:=$basename}.git
	git remote add origin $url
	git push -u origin master
}
# 将本地仓库与远程仓库进行关联 gitremote $remote_name
function gitremote(){
	url=git@github.com:${2:="jingzhongwa"}/${1:=$basename}.git
	#git remote add origin git@github.com:${2:="jingzhongwa"}//$1.git
	git remote add origin $url
	echo "---"
	echo $url
	echo "---"
	git push -u origin master
}

function gitpush(){
	git add -A;
	git commit -m $1;
	git push
}

# ----------------------------------------------------------------------------------------docker
alias dc='docker'
function dbt(){
	docker build -t jingzhongwa/$1 $2
}
function dpush(){
	docker push jingzhongwa/$1
}
alias dps="docker ps -a"
alias dim="docker images"
function drm(){
	docker rm $1;
}
function drmi(){
	docker rmi $1;
}

# ----------------------------------------------------------------------------------------docker-compose
alias dclist="sed -n '64,p;76q' /Users/yanyiming/.bashrc"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
alias dcstart="docker-compose start"
alias dcres="docker-compose restart"
alias dcstop="docker-compose stop"
alias dcps="docker-compose ps"
alias dcpsa="docker-compose ps -a"
# 进入容器：dcrun+容器名称
function dcrun () {
	docker-compose exec $1 bash;
}

# ----------------------------------------------------------------------------------------jmeter 采用brew安装的jmeter代替
#alias jmeter="/Users/yanyiming/Software/apache-jmeter-5.2.1/bin/jmeter"
alias jm="/usr/local/Cellar/jmeter/5.2.1/bin/jmeter"


# ----------------------------------------------------------------------------------------redis
alias rds='redis-server'
alias rdc='redis-cli'
alias rdb='redis-benchmark'

# ----------------------------------------------------------------------------------------vagrant
alias vg='vagrant'


# ----------------------------------------------------------------------------------------forever
alias fv='forever'
alias fvs='forever start'
alias fvstop='forever start'


# ----------------------------------------------------------------------------------------tail -n
alias tn='tail -n'
alias tn50='tail -n 50'
