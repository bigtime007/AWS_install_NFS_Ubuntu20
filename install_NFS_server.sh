#!/bin/bash
apt-get update && apt-get upgrade -y
apt install nfs-kernel-server
echo "Please declare file path for NFS, Example: /mnt/nfs_share"
read FILE_PATH
mkdir -p $FILE_PATH
echo "Your File Path is $FILE_PATH"
chown -R nobody:nogroup $FILE_PATH
chmod 777 $FILE_PATH
echo "Input a CIDR Block, Example 192.168.0.0/24 or 10.0.0.0/24
read CIDR_BLOCK
sudo cd /etc/exports
cat >> ./exports << EOF
$FILE_PATH  $CIDR_BLOCK(rw,sync,no_subtree_check)
EOF
exportfs -a
systemctl restart nfs-kernel-server
systemctl status nfs-kernel-server
cd ~
