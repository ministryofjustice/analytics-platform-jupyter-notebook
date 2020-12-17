from pyspark.context import SparkContext
from pyspark.sql import SparkSession

sc = SparkContext.getOrCreate()
spark = SparkSession(sc)

df = spark.read.csv("s3a://bucket/path/to/file.csv")
df.limit(10).show()
