NAME := martencz
VERSION := $(or $(VERSION),$(VERSION),1.0.0)
PLATFORM := $(shell uname -s)
BUILD_ARGS := $(BUILD_ARGS)
MAJOR := $(word 1,$(subst ., ,$(VERSION)))
MINOR := $(word 2,$(subst ., ,$(VERSION)))
MAJOR_MINOR_PATCH := $(word 1,$(subst -, ,$(VERSION)))

all: programming

build: all

ci: build test

base:
	cd ./Base && docker build $(BUILD_ARGS) -t $(NAME)/sphinx-doc:$(VERSION) .

programming: base
	cd ./Programming && docker build $(BUILD_ARGS) -t $(NAME)/hub:$(VERSION) .

tag_latest:
	docker tag $(NAME)/sphinx-doc:$(VERSION) $(NAME)/sphinx-doc:latest

release_latest:
	docker push $(NAME)/sphinx-doc:latest

tag_major_minor:
	docker tag $(NAME)/sphinx-doc:$(VERSION) $(NAME)/base:$(MAJOR)
	docker tag $(NAME)/sphinx-doc:$(VERSION) $(NAME)/base:$(MAJOR).$(MINOR)

release: tag_major_minor
	@if ! docker images $(NAME)/sphinx-doc | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/base version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)/sphinx-doc:$(VERSION)
	docker push $(NAME)/sphinx-doc:$(MAJOR)
	docker push $(NAME)/sphinx-doc:$(MAJOR).$(MINOR)
	docker push $(NAME)/sphinx-doc:$(MAJOR_MINOR_PATCH)

test:
	./test.sh
	./sa-test.sh
	./test.sh debug
	./sa-test.sh debug

.PHONY: \
	all \
	base \
	build \
	ci \
	programming \
	release \
	tag_latest \
	test
