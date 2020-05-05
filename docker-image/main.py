#!/usr/bin/env python
import os
from os import environ
import snowflake.connector

ctx = snowflake.connector.connect(
  user='XXXX',
  password='XXXXXX',
  account='XXXXXXX',
  warehouse=None,
  database="XXXX",
  schema="XXXXX"
)
cs = ctx.cursor()

try:
    cs.execute("SELECT current_version()")
    # cs.execute("USE DATABASE mydatabase")
    cs.execute("""Create or replace STAGE mystage url='s3://mynewsuperbucket/' CREDENTIALS=(AWS_ROLE = 'arn:aws:iam::338456148177:role/snowflake_mynewsuperbucket_role')""")
    rows = cs.fetchall()
    for row in rows:
        print(row)

    aws_external_id = None
    snowflake_iam_user = None
    cs.execute("desc stage mystage")
    rows = cs.fetchall()
    for row in rows:
        propertyKey = row[1]
        propertyValue = row[3]
        if propertyKey == 'AWS_EXTERNAL_ID':
            aws_external_id = propertyValue
        if propertyKey == 'SNOWFLAKE_IAM_USER':
            snowflake_iam_user = propertyValue

    file = open("mystage.env","w")
    file.write("export AWS_EXTERNAL_ID=" + aws_external_id)
    file.write("\nexport SNOWFLAKE_IAM_USER=" + snowflake_iam_user)
    file.close()
finally:
    cs.close()
ctx.close()
