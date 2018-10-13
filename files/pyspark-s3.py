#!/usr/bin/env python

import os
os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages com.amazonaws:aws-java-sdk:1.7.4,org.apache.hadoop:hadoop-aws:2.7.1 pyspark-shell'

import pyspark
sc = pyspark.SparkContext("local[*]")

from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)

hadoopConf = sc._jsc.hadoopConfiguration()
hadoopConf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
