FROM adoptopenjdk:14-jre-hotspot-bionic

RUN export DEBIAN_FRONTEND=no && \
    useradd -Ums /bin/bash spring

WORKDIR /home/spring

COPY docker/prod/application.yml .
COPY src/main/resources/scripts/entrypoint.sh entrypoint.sh
ADD  target/easy-backend.jar .

RUN chmod 664 -R * && \
    chmod +x entrypoint.sh && \
    chmod 775 easy-backend.jar && \
    chown -R spring:spring *


EXPOSE 8080

CMD ["./entrypoint.sh"]

USER spring
