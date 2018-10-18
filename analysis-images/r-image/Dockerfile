FROM rocker/tidyverse

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    libudunits2-dev libgdal-dev librsvg2-dev libpoppler-cpp-dev libgsl2 \
    sed gawk vim curl

RUN add-apt-repository -y ppa:jonathonf/ffmpeg-3 \
&& apt-get update \
&& apt-get install -y libavfilter-dev

RUN rm -rf /var/lib/apt/lists/*

COPY ./install-packages.r /home
WORKDIR /home

RUN R -f install-packages.r
