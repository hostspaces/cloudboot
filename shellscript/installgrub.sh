#!/bin/bash

DISK=/dev/$1
MP=/mnt/`basename ${DISK}`1
mkdir $MP
mount ${DISK}1 $MP

#cd $MP && tar xvf /grub.tar
cp -r /grub/ $MP
echo "(hd0)   ${DISK}" > $MP/grub/device.map

echo "setup grub"
grub <<EOF
    device (hd0) ${DISK} 
    root (hd0,0)
    setup (hd0)
    install (hd0,0)/grub/stage1 (hd0) (hd0,0)/grub/stage2 p (hd0,0)/grub/menu.lst    
    quit
EOF

cd /
umount $MP
rm -r $MP

