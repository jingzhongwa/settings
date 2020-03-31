#!/usr/bin/expect
set timeout 120
spawn pecl install ./swoole-4.4.14.tgz
expect "enable sockets supports?"
send "yes\n"
expect "enable openssl support?"
send "yes\n"
expect "enable http2 support?"
send "no\n"
expect "mysqlnd"
send "no\n"
expect eof