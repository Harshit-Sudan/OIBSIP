#!/bin/bash

# Task 2 - Basic Firewall Configuration with UFW

# Set default firewall policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH access
sudo ufw allow ssh

# Block HTTP traffic
sudo ufw deny 80/tcp

# Enable firewall
sudo ufw enable

# Display firewall status
sudo ufw status verbose