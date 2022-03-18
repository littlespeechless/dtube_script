cd /result
# make unique ipfs dir
mkdir $(date +%F)-ipfs
export IPFS_PATH=$(date +%F)-ipfs
ipfs init && \
ipfs config --json Gateway.PublicGateways '{"localhost": {"Paths": ["/ipfs"],"UseSubdomains": false} }' && \
ipfs config Reprovider.Strategy pinned && \
ipfs config Reprovider.Interval 0 
ipfs repo gc
ipfs daemon --enable-gc &
mkdir $(date +%F)
sleep 600
python /scripts/run.py
killall ipfs
# start record hop information
cd $(date +%F)
killall ipfs
echo $(pwd)
~/ipfs_bin/ipfs repo gc
~/ipfs_bin/ipfs daemon --enable-gc > $(date +%F)_daemon.txt 2>&1 &
sleep 600
~/ipfs_bin/ipfs log level dht warn
python /scripts/record.py
killall ipfs

# Init IPFS and setup system udp
    
