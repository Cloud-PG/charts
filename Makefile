CHART_NAME ?= spark
RELEASE ?= stable
GH_PAGES ?= https://cloud-pg.github.io/charts
COMMIT_MSG ?= "Doc update"

CURRENT_BRANCH = "spark_fix_PG" 

.PHONY: build-helm

all: help

help:
	@echo "Available commands:\n"
	@echo "- build-helm			: "

build-helm:
	helm package ${RELEASE}/${CHART_NAME}
	helm repo index ./ --url ${GH_PAGES}
	mv ./index.yaml /tmp/
	mv ./${CHART_NAME}*.tgz /tmp/
	git checkout gh-pages
	cp /tmp/${CHART_NAME}*.tgz .
	cp /tmp/index.yaml .
	git add index.yaml *.tgz
	git commit -m ${COMMIT_MSG}
	git push origin gh-pages
	git checkout ${CURRENT_BRANCH}
    
