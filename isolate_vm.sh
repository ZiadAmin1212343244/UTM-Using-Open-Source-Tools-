#!/bin/bash

# Configuration for API and SSH details
SSH_USER="ziad"
SSH_PASS="kali"
REMOTE_HOST="192.168.10.30"
NEW_IP="192.168.20.20"
INTERFACE="eth0"  # Specify the network interface you want to configure

# Path to the expect script
EXPECT_SCRIPT_PATH="./ssh_sudo_expect.sh"

# Execute the expect script with necessary arguments
"$EXPECT_SCRIPT_PATH" $REMOTE_HOST $SSH_USER $SSH_PASS $NEW_IP $INTERFACE
