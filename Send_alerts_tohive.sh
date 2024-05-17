#!/bin/bash

# The file to monitor
LOG_FILE="/opt/zeek/logs/current/signatures.log"

# TheHive API endpoint
THEHIVE_API="http://192.168.1.20:9000/api/alert"

# The updated TheHive API key
API_KEY="kYnuLr3TbO+LY4+EmbsTBwtvAHpOftrc"

# Function to send data to TheHive
send_to_thehive() {
    while IFS= read -r line
    do
        # Parse the log line into variables (adjust based on log format)
        read -r timestamp uid src_addr src_port dst_addr dst_port signature_type event_message <<< $(echo $line)

        # Determine the type of attack and appropriate details
        case $dst_port in
            21)
                title="FTP Traffic"
                description="FTP traffic detected on Port 21: $event_message"
                type="external"
                severity=3
                tlp=2
                tags_json='["FTP"]'
                ;;
            22)
                title="Unusual SSH Traffic"
                description="Unusual SSH traffic detected: $event_message"
                type="external"
                severity=3
                tlp=2
                tags_json='["SSH"]'
                ;;
            *)
                if [[ $dst_port -lt 1024 ]]; then
                    title="SYN Scan"
                    description="Possible SYN scan detected on well-known ports: $event_message"
                    type="external"
                    severity=3
                    tlp=2
                    tags_json='["SYN_Scan", "Port_Scan"]'
                else
                    continue
                fi
                ;;
        esac

        # Construct the JSON data payload
        JSON_PAYLOAD=$(cat <<EOF
{
    "title": "$title",
    "description": "$description",
    "type": "$type",
    "severity": $severity,
    "tlp": $tlp,
    "tags": $tags_json,
    "source": "Zeek Detection",
    "sourceRef": "$uid",
    "artifacts": []
}
EOF
        )

        echo "Sending the following JSON payload to TheHive:"
        echo "$JSON_PAYLOAD"

        # Use curl to send the alert to TheHive
        response=$(curl -s -o /dev/null -w "%{http_code}" -X POST "$THEHIVE_API" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -d "$JSON_PAYLOAD")

        echo "HTTP response code: $response"
    done < "$LOG_FILE"
}

# Call the function to start sending logs
send_to_thehive
