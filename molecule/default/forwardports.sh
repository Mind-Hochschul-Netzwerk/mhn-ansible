#!/bin/bash
# Script to Forward Port 80 and 443 to the VM Ports outside the protected port range.
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8043