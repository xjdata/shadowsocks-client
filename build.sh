#!/bin/bash

# 清除已有的
docker stop shadowsocks-client
docker rm shadowsocks-client
docker rmi xjdata/shadowsocks-client 

# 重新生成
docker build -t xjdata/shadowsocks-client ./