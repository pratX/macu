#! /bin/bash
for file in /home/pratikku/test/macu/hypotheses/*
do
    echo $file
    metric=`echo $file | sed 's/.*\///'| sed 's/\.mat//'`
    echo $metric
    curl "http://dashboard.reports.mn:99/render?target=${metric}&format=json&from=-15min" > /home/pratikku/test/macu/kmeans/graphite_data 
    python /home/pratikku/test/macu/kmeans/graphite_data_2_csv.py 
done
