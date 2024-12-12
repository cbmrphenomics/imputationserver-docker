.PHONY: build test

build:
	podman build -t phenomics/imputationserver:v1.6.8 .

test: build
	bash tests/test_runner.sh

default: build
