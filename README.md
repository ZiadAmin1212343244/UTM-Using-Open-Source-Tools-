# UTM-Using-Open-Source-Tools
UTM Project 

Project Overview :

This project implements a Unified Threat Management (UTM) suite using open-source tools to provide comprehensive network security. The suite integrates Zeek for network traffic monitoring, TheHive for alert management, and custom scripts for automated threat response and isolation.

Features :

Network Traffic Monitoring: Uses Zeek to monitor and analyze network traffic.
Alert Management: Integrates with TheHive for managing and responding to security alerts.
Automated Incdient Response: Custom scripts for parsing logs, generating alerts, and isolating compromised machines.
Incident Containment: Automated scripts to isolate infected machines by disabling their network interfaces.

Architecture :
The UTM suite consists of the following components:

Zeek: A powerful network analysis tool for monitoring network traffic and generating logs.
TheHive: An alert management system for correlating and responding to security events.
Custom Scripts: Bash and Expect scripts for parsing Zeek logs, sending alerts to TheHive, and isolating compromised machines.

Installation :
Install Zeek:
Follow the Zeek installation guide to install and configure Zeek on your system.

Install TheHive:
Follow the TheHive installation guide to set up TheHive.

Install Dependencies:
Install necessary dependencies using:
sudo apt-get install expect
sudo apt-get install python3


Configuration :
Zeek Configuration:
Edit the node.cfg file in the Zeek installation directory to monitor the desired network interfaces.
Configure the local.zeek script to include custom signature rules.

Custom Scripts:
Update the custom scripts (send_alerts_tohive.sh, isolate_vm.sh, and ssh_sudo_expect.sh) with the appropriate paths and credentials.


TheHive Configuration:

Configure TheHive to accept alerts from the custom scripts.
Update TheHive API keys and endpoint URLs in the scripts.

Testing :

Simulate Attacks:

Use tools like Nmap and Hydra from a Kali Linux machine to simulate various network attacks (e.g., SYN scans, SSH brute force, FTP brute force).
Verify Detection and Alerts

Check the signatures.log file in Zeek logs for detection of simulated attacks.
Verify that alerts are generated and appear in TheHive.

Verify Isolation:
Ensure that the isolation script successfully disables the network interface of the attacker machine upon detection of a threat.


