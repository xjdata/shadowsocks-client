#!/bin/bash

docker stop shadowsocks-client
docker rm shadowsocks-client
docker rmi xjdata/shadowsocks-client 

docker build -t xjdata/shadowsocks-client ./