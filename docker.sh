mkdir -p result
docker build -t dtube-script .
sudo sysctl -w net.core.rmem_max=2500000
docker run -d --name $(date +%F)-dtube\
       -v /home/ax/workspace/dtube_script/result:/result \
       -v /home/ax/workspace/dtube_script/scripts:/scripts \
       --cap-add=NET_ADMIN \
       dtube-script

