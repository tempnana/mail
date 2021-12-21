#!/bin/bash
cd /root/james-server-app-3.1.0/bin
./james stop
./run.sh >/dev/null &
./james start &
sleep 10s
netstat -nltp
