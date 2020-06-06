#!/bin/bash
sudo mount -t cifs -o uid=1000,gid=1000,user=samba //192.168.0.121/nas-pi /mnt/nas
