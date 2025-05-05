# Базовый образ с Java
FROM openjdk:11-jdk-slim

# Устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y curl bash && apt-get clean

# Устанавливаем Spark
ENV SPARK_VERSION=3.5.1 \
    HADOOP_VERSION=3 \
    SPARK_HOME=/opt/spark

RUN curl -fsSL https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | \
    tar -xz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}

ENV PATH="${SPARK_HOME}/bin:${PATH}"

# Копируем конфиги, если есть
# COPY conf/* $SPARK_HOME/conf/

# Открываем нужные порты
EXPOSE 4040 7077 8080 18080

# Команда по умолчанию — запуск Spark master
CMD ["spark-class", "org.apache.spark.deploy.master.Master"]
