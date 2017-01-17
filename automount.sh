#!/bin/bash -f

mount_nas () {
    nas_ip=$1
    nas_dir=$2
    nas_id=$3
    nas_pw=$4
    echo mounting $nas_ip$nas_dir

    nas_up=`ping -c 1 $nas_ip | grep icmp* | wc -l`
    if [ $nas_up = 1 ]; then
        mount_point=`mount | grep $nas_dir | awk '{print $3}'`
        if [ "$mount_point" != "/Volumes$nas_dir" ]; then
            terminal-notifier -title 'Shares watchdog' -message 'Mounting '$nas_ip$nas_dir' share'
            osascript -e 'mount volume "afp://'$nas_id':'$nas_pw'@'$nas_ip$nas_dir'"'
        fi
    else
        terminal-notifier -title 'Shares watchdog' -message 'NAS('$nas_ip') is not reachable'
    fi
}

mount_nas [ip] "/Datas"    [id] [pw]
mount_nas [ip] "/P2P"      [id] [pw]
mount_nas [ip] "/Movies"   [id] [pw]
mount_nas [ip] "/Music"    [id] [pw]
mount_nas [ip] "/Pictures" [id] [pw]

