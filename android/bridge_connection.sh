#!/bin/sh
#### Description: Script to bridge the connection of the emulated device

IP_ADDRESS=172.17.200.200

echo "\n==============================================================="
echo    "                  BRIDGE CONNECTION SCRIPT                     "
echo    "==============================================================="

# Hack part to fix lib issues
mkdir /dev/net
mknod /dev/net/tun c 10 200

echo "Adding new bridge interface..."
ip link add br0 type bridge
echo "--> Interface added"

echo "Flushing the eth0 interface for security reason (we don't know what's in the pipe)..."
ip addr flush dev eth0
echo "--> Flushed"

echo "Linking the eth0 interface with the new bridge..."
ip link set eth0 master br0
echo "--> Linked"

echo "Add right to user"
ip tuntap add name tap0 mode tap user `whoami`
echo "--> Added"

echo "Linking the tap0 interface with the bridge..."
ip link set tap0 master br0
echo "--> Linked"

echo "Correct 'DOWN' status of the bridge"
ip link set dev br0 up
echo "--> br0 might now be up"

echo "Correct 'DOWN' status of the tap0 interface"
ip link set tap0 up
ip link set dev tap0 up
echo "--> tap0 might now be up"

echo "Adding an IP address ($IP_ADDRESS) to access to the device"
ip addr add $IP_ADDRESS dev tap0
echo "--> IP address added"

sleep 2s
exit 0