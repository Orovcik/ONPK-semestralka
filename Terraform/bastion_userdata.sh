#!/bin/bash
# POVOLIT IP FORWARDING
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p

# Define variables
private_IP_addr="${IP_addr}"

network_interface="ens3"
destination_port=22

# Set up NAT rules
sudo iptables -t nat -A PREROUTING -p tcp -i $network_interface --dport $destination_port -j DNAT --to-destination $private_IP_addr:$destination_port
sudo iptables -t nat -A POSTROUTING -j MASQUERADE