# Basis-Image mit OpenJDK
FROM openjdk:11

# Spark- und Hadoop-Versionen
ENV SPARK_VERSION=3.5.1
ENV HADOOP_VERSION=3

# Arbeitsverzeichnis
WORKDIR /opt

# Spark herunterladen und entpacken
RUN apt-get update && apt-get install -y curl && \
    curl -fSL https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
    rm -rf /var/lib/apt/lists/*

# Umgebungsvariablen setzen
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH

# Portfreigabe (Web UI + Master/Worker)
EXPOSE 7077 8080 4040

# Default-Befehl: Spark Master starten
CMD ["spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]
