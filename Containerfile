FROM docker.io/bioconductor/bioconductor_docker:RELEASE_3_22-R-4.5.2

WORKDIR /project
COPY DESCRIPTION DESCRIPTION

RUN apt-get update && \
    apt-get install --no-install-recommends -y libcurl4-openssl-dev pandoc && \
    quarto install tinytex && \
    R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" && \
    R -e "remotes::install_deps(dependencies = TRUE)"

RUN wget https://github.com/mothur/mothur/releases/download/v1.48.5/Mothur.Ubuntu_22.x86_64.zip && \
    unzip Mothur.Ubuntu_22.x86_64.zip  && \
    cd mothur && \
    chmod +x mothur
