FROM ubuntu:artful
MAINTAINER Timo Furrer <tuxtimo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade --yes

# Install pandoc and necessary latex packages
RUN apt-get install --yes pandoc texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-fonts-recommended texlive-fonts-extra

# Install mermaid-filter for pandoc: https://github.com/raghur/mermaid-filter
#RUN apt-get install --yes npm
#RUN apt-get install --yes libasound2 libpangocairo-1.0-0 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0
#RUN npm install --global mermaid-filter

COPY crapinclude /usr/local/bin/

# Install eisvogel template
COPY template/eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

VOLUME ["/notes"]

WORKDIR /notes

#CMD cat index.md | crapinclude | pandoc -o output.pdf --from markdown --template eisvogel --listings --filter mermaid-filter --filter pandoc-plantuml-filter
CMD cat index.md | crapinclude | pandoc -o output.pdf --from markdown --template eisvogel --listings
