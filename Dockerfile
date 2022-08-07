FROM python:3.9-slim



# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

USER root
COPY . ${HOME}
WORKDIR ${HOME}
RUN pip install -r requirements.txt

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}

USER ${USER}