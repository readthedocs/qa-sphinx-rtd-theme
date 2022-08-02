
all: clean install build serve

clean:
	rm -rf builds/
	rm -rf .tox/

install:
	tox --notest

build:
	./build.sh

serve:
	python -m http.server --directory builds/ 8081
