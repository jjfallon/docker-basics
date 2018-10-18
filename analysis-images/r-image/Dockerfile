FROM rocker/tidyverse

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    libudunits2-dev libgdal-dev librsvg2-dev libpoppler-cpp-dev libgsl2 libavfilter-dev \
    sed gawk vim curl \
&& rm -rf /var/lib/apt/lists/*

COPY ./install-packages.r /home
WORKDIR /home

RUN R -f install-packages.r
