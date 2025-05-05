FROM openjdk:11

# Build-Zeit-Variablen
ARG SPARK_VERSION=3.5.1
ARG HADOOP_VERSION=3

WORKDIR /opt

# Spark herunterladen und entpacken
RUN apt-get update && apt-get install -y curl && \
    curl -fSL https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
    rm -rf /var/lib/apt/lists/*
