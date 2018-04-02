.PHONY: all build build-img update-eisvogel clean-build publish

all: build

build: build-img
	docker run --rm -v $(PWD)/example:/notes timofurrer/hslu-notes

build-img:
	docker build . -t timofurrer/hslu-notes

update-eisvogel:
	wget https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex -O template/eisvogel.tex

clean-build:
	docker build --no-cache . -t timofurrer/hslu-notes

publish: build-img
	docker push timofurrer/hslu-notes
