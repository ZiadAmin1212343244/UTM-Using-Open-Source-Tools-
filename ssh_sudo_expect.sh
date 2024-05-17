#!/usr/bin/expect -f

# Set variables from command line arguments
set host [lindex $argv 0]
set user [lindex $argv 1]
set password [lindex $argv 2]
set new_ip [lindex $argv 3]
set interface [lindex $argv 4]

# Set timeout to ensure long-running commands do not fail
set timeout 30

# Start SSH session
spawn ssh -o StrictHostKeyChecking=no $user@$host

# Handle SSH login
expect "$user@$host's password:"
send "$password\r"

# Execute network commands using sudo
expect "$ "
send "echo '$password' | sudo -S ifconfig $interface down\r"
expect "$ "
send "echo '$password' | sudo -S ifconfig $interface $new_ip netmask 255.255.255.0 up\r"
expect "$ "
send "logout\r"

# End expect script
expect eof
