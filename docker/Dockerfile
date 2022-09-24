FROM adoptopenjdk:14-jre-hotspot-bionic

ENV PKI_CHAIN_DOWNLOAD_URL=https://pki.pca.dfn.de/dfn-ca-global-g2/pub/cacert/chain.txt
ENV PKI_CHAIN_SHA256=3faab8a9915b567c25cd982c92daa6dbd65807d14436adec2f1040a78701522a
ENV WAIT_FOR_IT_DOWNLOAD_URL=https://raw.githubusercontent.com/vishnubob/wait-for-it/81b1373f17855a4dc21156cfe1694c31d7d1792e/wait-for-it.sh
ENV WAIT_FOR_IT_SHA256=b7a04f38de1e51e7455ecf63151c8c7e405bd2d45a2d4e16f6419db737a125d6

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