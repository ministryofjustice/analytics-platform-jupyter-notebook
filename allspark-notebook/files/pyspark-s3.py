#!/usr/bin/env python

import pyspark
sc = pyspark.SparkContext("local[*]")

hadoopConf = sc._jsc.hadoopConfiguration()
hadoopConf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
