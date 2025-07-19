# Dockerfile para Java + Tomcat + Jakarta EE
FROM openjdk:21-jdk-slim

# Instalar Tomcat 10 (compatible con Jakarta EE)
ENV TOMCAT_VERSION=10.1.16
ENV CATALINA_HOME=/opt/tomcat

# Descargar e instalar Tomcat
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://archive.apache.org/dist/tomcat/tomcat-10/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    tar -xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    mv apache-tomcat-${TOMCAT_VERSION} ${CATALINA_HOME} && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Configurar usuario para Tomcat
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat
RUN chown -R tomcat:tomcat ${CATALINA_HOME}
RUN chmod +x ${CATALINA_HOME}/bin/*.sh

# Copiar tu WAR file
COPY target/*.war ${CATALINA_HOME}/webapps/ROOT.war

# Configurar variables de entorno
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom"

# Exponer puerto
EXPOSE 8080

# Configurar puerto para Render
ENV PORT=8080
RUN sed -i 's/port="8080"/port="${PORT}"/g' ${CATALINA_HOME}/conf/server.xml

# Cambiar a usuario tomcat
USER tomcat

# Comando de inicio
CMD ["sh", "-c", "${CATALINA_HOME}/bin/catalina.sh run"]
