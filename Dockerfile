FROM ubuntu:14.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN \
  apt-get update && \
  apt-get install -y alien software-properties-common autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN wget https://sfc-repo.snowflakecomputing.com/odbc/linux/latest/snowflake-odbc-2.21.1.x86_64.rpm
RUN wget https://sfc-repo.snowflakecomputing.com/snowcd/linux/latest/snowflake-snowcd-1.0.2.x86_64.rpm
RUN wget https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowflake-snowsql-1.2.3-1.x86_64.rpm

RUN alien -i ./snowflake-odbc-2.21.1.x86_64.rpm
RUN alien -i ./snowflake-snowcd-1.0.2.x86_64.rpm
RUN alien -i ./snowflake-snowsql-1.2.3-1.x86_64.rpm
RUN apt update
RUN apt install -y curl

COPY odbc.ini /etc/odbc.ini
