cd /result
# make unique ipfs dir
mkdir $(date +%F)-ipfs
mkdir $(date +%F)
export IPFS_PATH=$(date +%F)-ipfs
~/ipfs_bin/ipfs init && \
~/ipfs_bin/ipfs config --json Gateway.PublicGateways '{"localhost": {"Paths": ["/ipfs"],"UseSubdomains": false} }' && \
~/ipfs_bin/ipfs config Reprovider.Strategy pinned && \
~/ipfs_bin/ipfs config Reprovider.Interval 0 && \
~/ipfs_bin/ipfs config Datastore.StorageMax "0" && \
~/ipfs_bin/ipfs config Datastore.GCPeriod "0h" && \
~/ipfs_bin/ipfs config show
~/ipfs_bin/ipfs repo gc
~/ipfs_bin/ipfs daemon --enable-gc > $(date +%F)/$(date +%F)_daemon.txt 2>&1 &
sleep 600
~/ipfs_bin/ipfs log level dht warn
~/ipfs_bin/ipfs log level bitswap warn
python /scripts/collect_data.py
killall ipfs
# start record hop information
cd $(date +%F)
killall ipfs
echo $(pwd)
export IPFS_PATH=/result/$(date +%F)-ipfs
~/ipfs_bin/ipfs repo gc
~/ipfs_bin/ipfs daemon --enable-gc > $(date +%F)_analysis.txt 2>&1 &
sleep 600
python /scripts/record.py -p
killall ipfs

# Init IPFS and setup system udp
    
