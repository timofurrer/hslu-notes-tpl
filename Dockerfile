FROM ubuntu:artful
MAINTAINER Timo Furrer <tuxtimo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade --yes

RUN apt-get install --yes pandoc texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-fonts-recommended texlive-fonts-extra

COPY template/eisvogel.tex /usr/share/pandoc/data/templates/eisvogel.latex

VOLUME ["/notes"]

WORKDIR /notes

ENTRYPOINT ["pandoc", "-o", "output.pdf", "--from", "markdown", "--template", "eisvogel", "--listings"]
CMD []
