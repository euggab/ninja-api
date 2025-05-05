FROM openjdk:11-jdk-slim

RUN apt-get update && apt-get install -y curl bash && apt-get clean

ENV SPARK_VERSION=3.5.1 \
    HADOOP_VERSION=3-scala2.12 \
    SPARK_HOME=/opt/spark

RUN curl -fsSL https://downloads.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | \
    tar -xz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}

ENV PATH="${SPARK_HOME}/bin:${PATH}"

EXPOSE 4040 7077 8080 18080

CMD ["spark-class", "org.apache.spark.deploy.master.Master"]
