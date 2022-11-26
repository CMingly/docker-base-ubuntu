FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

ENV C_USER=app
ENV C_UID=1000
ENV C_GROUP=${C_USER}
ENV C_GID=${C_UID}
ENV C_HOME=/home/${C_USER}

ENV C_TIMEZONE=Europe/Copenhagen

RUN apt-get update && \
    apt-get install -yq tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/share/zoneinfo/${C_TIMEZONE} /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN addgroup --gid ${C_GID} ${C_GROUP} && \
    adduser --home ${C_HOME} --uid ${C_UID} --gid ${C_GID} ${C_USER}

USER ${C_USER}
WORKDIR ${C_HOME}

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
