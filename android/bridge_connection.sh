#!/bin/sh
#### Description: Script to bridge the connection of the emulated device

IP_ADDRESS=172.17.200.200

echo "\n==============================================================="
echo    "                  BRIDGE CONNECTION SCRIPT                     "
echo    "==============================================================="

# Hack part to fix lib issues
mkdir /dev/net
mknod /dev/net/tun c 10 200

ip link add br0 type bridge
ip tuntap add name tap0 mode tap user `whoami`
ip link set tap0 master br0
ip link set dev br0 up
ip link set tap0 up
ip link set dev tap0 up
ip addr add $IP_ADDRESS dev tap0
sleep 2s
exit 0
