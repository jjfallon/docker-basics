FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        build-essential gfortran \
        sed gawk vim \
        python python-dev python-pip

COPY ./requirements.txt /home
WORKDIR /home

RUN pip install -r requirements.txt

RUN jupyter lab --generate-config

CMD jupyter lab --port=8888 --ip='*' --no-browser --allow-root --NotebookApp.token='a1111'

