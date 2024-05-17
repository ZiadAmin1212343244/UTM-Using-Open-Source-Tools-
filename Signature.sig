signature detect_ftp_traffic {
    ip-proto == tcp
    dst-port == 21
    event "FTP traffic detected on Port 21"
}

signature detect_unusual_ssh {
    ip-proto == tcp
    dst-port == 22
    event "Unusual SSH traffic detected"
}

signature detect_syn_scan {
    ip-proto == tcp
    dst-port < 1024  # Focus on well-known ports
    event "Possible SYN scan detected on well-known ports"
}
