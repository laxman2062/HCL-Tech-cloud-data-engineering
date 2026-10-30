import os
import sys

os.environ["PYSPARK_PYTHON"] = sys.executable
os.environ["PYSPARK_DRIVER_PYTHON"] = sys.executable

from pyspark.sql import SparkSession
from pyspark.sql.types import (
    StructType, StructField, IntegerType,
    StringType, DoubleType, DateType
)
from pyspark.sql.functions import col, avg, count, year, month
from datetime import date

spark = SparkSession.builder \
    .appName("EmployeeDataFrameOperations") \
    .master("local[*]") \
    .getOrCreate()

schema = StructType([
    StructField("EmployeeID", IntegerType(), False),
    StructField("EmployeeName", StringType(), False),
    StructField("Department", StringType(), False),
    StructField("Salary", DoubleType(), False),
    StructField("JoiningDate", DateType(), False)
])

data = [
    (101, "Amit", "IT", 75000.0, date(2022, 1, 10)),
    (102, "Priya", "HR", 55000.0, date(2021, 3, 15)),
    (103, "Rahul", "Finance", 65000.0, date(2020, 7, 20)),
    (104, "Sneha", "IT", 85000.0, date(2019, 5, 12)),
    (105, "Kiran", "Sales", 60000.0, date(2023, 2, 1)),
    (106, "Neha", "HR", 62000.0, date(2022, 8, 18)),
    (107, "Arjun", "Finance", 90000.0, date(2018, 4, 22)),
    (108, "Divya", "IT", 58000.0, date(2023, 6, 5)),
    (109, "Vikram", "Sales", 72000.0, date(2020, 9, 14)),
    (110, "Ananya", "Finance", 68000.0, date(2021, 11, 8)),
    (111, "Rohan", "IT", 95000.0, date(2017, 12, 3)),
    (112, "Meera", "HR", 48000.0, date(2024, 1, 17)),
    (113, "Kavya", "Sales", 65000.0, date(2022, 4, 25)),
    (114, "Suresh", "Finance", 78000.0, date(2019, 10, 30)),
    (115, "Pooja", "IT", 62000.0, date(2021, 7, 19))
]

df = spark.createDataFrame(data, schema)

print("SCHEMA:")
df.printSchema()

print("FIRST FIVE RECORDS:")
df.show(5, truncate=False)

print("EMPLOYEES WITH SALARY > 60000:")
df.filter(col("Salary") > 60000).show(truncate=False)

df_annual = df.withColumn(
    "AnnualSalary", col("Salary") * 12 )

print("EMPLOYEES WITH ANNUAL SALARY:")
df_annual.show(truncate=False)


print("DEPARTMENT-WISE SUMMARY:")
df.groupBy("Department").agg(
    avg("Salary").alias("AverageSalary"),
    count("*").alias("EmployeeCount")
).orderBy("Department").show(truncate=False)


print("TOP FIVE HIGHEST-PAID EMPLOYEES:")
df.orderBy(col("Salary").desc()).limit(5).show(
    truncate=False
)
spark.stop()