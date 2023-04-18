#!/bin/bash

# Script for updating IP addresses in BigBlueButton configuration files

# Variables
old_ip="XXX.XXX.XXX.XXX"
new_ip="XXX.XXX.XXX.XXX"
fqdn="bbbX.example.com"
dry_run=false

# Array of configuration files
config_files=(/etc/bigbluebutton/bbb-web.properties /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties /etc/nginx/sites-available/bigbluebutton /opt/freeswitch/etc/freeswitch/vars.xml /opt/freeswitch/etc/freeswitch/sip_profiles/external.xml /usr/local/bigbluebutton/core/scripts/bigbluebutton.yml /etc/bigbluebutton/nginx/sip.nginx /usr/local/bigbluebutton/bbb-webrtc-sfu/config/default.yml /etc/bigbluebutton/bbb-webrtc-sfu/production.yml /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml /etc/bigbluebutton/bbb-html5.yml /usr/share/bbb-web/WEB-INF/classes/spring/turn-stun-servers.xml)

# Loop through the config files and update IP addresses
for file in "${config_files[@]}"; do
    if [ -f "$file" ]; then
        # Check if the file exists
        if $dry_run ; then
            echo "Updating IP address in $file"
        else
            echo "Updating IP address in $file"
            sed -i "s/$old_ip/$new_ip/g" $file
        fi
    else
        echo "$file not found"
    fi
done

# Set IP address
if [[ $dry_run -eq 0 ]]; then
    bbb-conf --setip $fqdn
else
    echo "Dry run: IP address would be set to $fqdn"
fi

# Update IP addresses in bbb-monitoring
if [ -d "/root/bbb-monitoring" ]; then
    cd /root/bbb-monitoring
    if [ -f "docker-compose.yaml" ]; then
        if [[ $dry_run -eq 0 ]]; then
            sed -i "s/$old_ip/$new_ip/g" docker-compose.yaml
            docker-compose up -d --force-recreate
        else
            echo "Dry run: IP address in /root/bbb-monitoring/docker-compose.yaml would be updated"
        fi
    else
        echo "File docker-compose.yaml does not exist in /root/bbb-monitoring"
    fi
else
    echo "Directory /root/bbb-monitoring does not exist"
fi

# Restart BigBlueButton
if [[ $dry_run -eq 0 ]]; then
    bbb-conf --restart
else
    echo "Dry run: BigBlueButton would be restarted"
fi

# print bigbluebutton's secret
bbb-conf --secret
