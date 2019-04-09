#!/bin/bash

cp /tmp/reddit.service /etc/systemd/system
chmod 664 /etc/systemd/system/reddit.service
systemctl daemon-reload
systemctl enable reddit
systemctl start reddit
journalctl -u reddit
