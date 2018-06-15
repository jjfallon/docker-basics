FROM alpine

RUN apk add --no-cache --update-cache \
        build-base wget gfortran freetype-dev libpng-dev openblas-dev \
        sed gawk vim \
        python python-dev py-pip

COPY ./requirements.txt /home
WORKDIR /home

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN jupyter lab --generate-config

CMD jupyter lab --port=8888 --ip='*' --no-browser --allow-root --NotebookApp.token='bbbbb'

