FROM ubuntu:artful
MAINTAINER Timo Furrer <tuxtimo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade --yes

# Install pandoc and necessary latex packages
RUN apt-get install --yes pandoc texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-fonts-recommended texlive-fonts-extra

# Install mermaid-filter for pandoc: https://github.com/raghur/mermaid-filter
RUN apt-get install --yes npm
RUN npm install --global mermaid-filter

# FIXME(TF): sucks as hell ... who did this crap?!
# Install pandoc-include: https://hackage.haskell.org/package/pandoc-include
#RUN apt-get install --yes cabal-install
#RUN cabal update
#RUN cabal install pandoc-include
COPY crapinclude /usr/local/bin/

# Install eisvogel template
COPY template/eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

VOLUME ["/notes"]

WORKDIR /notes

CMD cat index.md | crapinclude | pandoc -o output.pdf --from markdown --template eisvogel --listings --filter mermaid-filter
