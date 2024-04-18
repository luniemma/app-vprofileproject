#!/bin/bash

# Install Java and wget
yum install java-1.8.0-openjdk.x86_64 wget -y

# Create directories
mkdir -p /opt/nexus/
mkdir -p /tmp/nexus/

# Download Nexus
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
wget $NEXUSURL -O /tmp/nexus/nexus.tar.gz

# Extract Nexus
tar xzf /tmp/nexus/nexus.tar.gz -C /opt/nexus/
NEXUSDIR=$(basename /opt/nexus/nexus-*/)

# Remove downloaded tar file
rm -f /tmp/nexus/nexus.tar.gz

# Set ownership
chown -R nexus:nexus /opt/nexus/$NEXUSDIR

# Create nexus.service file
cat <<EOT > /etc/systemd/system/nexus.service
[Unit]
Description=Nexus Service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOT

# Set run_as_user in nexus.rc
echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc

# Reload systemd daemon
systemctl daemon-reload

# Start and enable Nexus service
systemctl start nexus
systemctl enable nexus
