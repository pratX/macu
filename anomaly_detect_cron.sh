#! /bin/bash
/home/pratikku/test/macu/populate_live.sh
octave /home/pratikku/test/macu/regression/anomalyDetect.m
sshpass -p 'P8NFjoET1' scp /home/pratikku/test/macu/regression/anomaly_op root@d9-webtest.srv.media.net:/opt/macu-pratik-stage/
