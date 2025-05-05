FROM openjdk:11

# Build-Zeit-Variablen definieren
ARG SPARK_VERSION=3.5.1
ARG HADOOP_VERSION=3

# Laufzeitvariablen (für späteren Gebrauch)
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

WORKDIR /opt

# Spark herunterladen und entpacken
RUN apt-get update && apt-get install -y curl && \
    curl -fSL https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz && \
    tar -xzf spark.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
    rm spark.tgz && \
    rm -rf /var/lib/apt/lists/*

# Ports für Web UI und Kommunikation
EXPOSE 7077 8080 4040

# Startet Spark Master im Standalone-Modus
CMD ["spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]
