FROM ubuntu:artful
MAINTAINER Timo Furrer <tuxtimo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN useradd -ms /bin/bash batman

WORKDIR /root

RUN apt-get update
RUN apt-get upgrade --yes

# Install pandoc and necessary latex packages
RUN apt-get install --yes pandoc texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-fonts-recommended texlive-fonts-extra
RUN apt-get install --yes python3-pip

# Install pandoc-mermaid-filter: https://github.com/timofurrer/pandoc-mermaid-filter
RUN apt-get install --yes npm
RUN apt-get install --yes libasound2 libpangocairo-1.0-0 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0
USER batman
WORKDIR /home/batman
RUN npm install mermaid.cli
ENV MERMAID_BIN /home/batman/node_modules/.bin/mmdc
USER root
RUN pip3 install pandoc-mermaid-filter

# Install pandoc-plantuml-filter: https://github.com/timofurrer/pandoc-plantuml-filter
RUN apt-get install --yes plantuml
RUN pip3 install pandoc-plantuml-filter

COPY crapinclude /usr/local/bin/

# Install eisvogel template
COPY template/eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

USER batman

VOLUME ["/notes"]

WORKDIR /notes

#CMD cat index.md | crapinclude | pandoc -o output.pdf --from markdown --template eisvogel --listings --filter pandoc-mermaid --filter pandoc-plantuml
CMD cat index.md | crapinclude | pandoc -o output.pdf --from markdown --template eisvogel --listings --filter pandoc-plantuml
