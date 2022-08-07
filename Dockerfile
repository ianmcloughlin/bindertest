FROM python:3.9-slim



# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

USER root
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${USER}
RUN chown -R ${NB_UID} ${HOME}

RUN apt update && apt install git

USER ${USER}
COPY . ${HOME}
WORKDIR ${HOME}
RUN git clone https://github.com/jupyter/notebook
RUN pip install -e ./notebook/
RUN pip install -r requirements.txt