FROM debian:latest
MAINTAINER Martin Malek <github@marten-online.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  make \
  python-pip \
  python-dev \
  texlive texlive-latex-recommended \
  texlive-latex-extra \
  texlive-fonts-recommended

RUN pip install Sphinx==1.5.3 sphinx_rtd_theme alabaster \
  sphinx_bootstrap_theme sphinx-intl

CMD ["/bin/bash"]

WORKDIR /doc
