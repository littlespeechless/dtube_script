docker run -d --name test\
       -v /home/ax/workspace/dtube_script/result:/result \
       -v /home/ax/workspace/dtube_script/scripts:/scripts \
       --cap-add=NET_ADMIN \
       test

