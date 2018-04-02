all: build

build: build-img
	docker run --rm -v $(PWD):/notes timofurrer/hslu-notes

build-img:
	docker build . -t timofurrer/hslu-notes

update-eisvogel:
	wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O template/eisvogel.tex


clean-build:
	docker build --no-cache . -t timofurrer/hslu-notes
