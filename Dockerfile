FROM phenomics/cloudgene:v2.5.1

MAINTAINER Sebastian Schoenherr <sebastian.schoenherr@i-med.ac.at>, Lukas Forer <lukas.forer@i-med.ac.at>

# Install dependencies for R packages
RUN apt update && \
apt -y install \
libxml2-dev \
libcurl4-openssl-dev && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Install R Packages
RUN R -e "install.packages('RColorBrewer', repos = 'http://cran.rstudio.com' )"
RUN R -e "install.packages('BiocInstaller', repos='https://bioconductor.org/packages/3.6/bioc')"
RUN R -e 'BiocInstaller::biocLite("geneplotter")'

# Add imputationserver specific pages
ADD pages /opt/cloudgene/sample/pages

# Add apps.yaml file with imputationserver and hapmap2
ADD apps.yaml /opt/cloudgene/apps.yaml

# Imputation Server Branding
ENV CLOUDGENE_SERVICE_NAME="Michigan Imputation Server"
ENV CLOUDGENE_HELP_PAGE="http://imputationserver.readthedocs.io"
ENV CLOUDGENE_REPOSITORY="/opt/cloudgene/apps.yaml"

COPY custom_startup.sh /root/

# run startup script to start Hadoop and Cloudgene
CMD ["bash", "/root/custom_startup.sh"]
