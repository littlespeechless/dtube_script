cd /result
ipfs repo gc
ipfs daemon --enable-gc &
mkdir $(date +%F)
sleep 600
python /scripts/run.py
killall ipfs
# start record hop information
cd $(date +%F)
echo $(pwd)
~/ipfs_bin/ipfs repo gc
~/ipfs_bin/ipfs daemon --enable-gc > $(date +%F)_daemon.txt 2>&1 &
sleep 600
~/ipfs_bin/ipfs log level dht warn
python /scripts/record.py
killall ipfs
