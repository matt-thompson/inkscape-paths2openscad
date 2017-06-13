MAKE = /usr/bin/make
DEST=/usr/share/inkscape/extensions

NAME = $(notdir $(CURDIR))

PYTHON_VERSION = 2.7.8
VIRTUALENV_VERSION = 1.11.6

.PHONY: all
all: test

.PHONY: test
test: virtualenv
	. virtualenv/bin/activate && \
		pip install --requirement python-test-requirements.txt && \
		$(MAKE) METHOD=git python-pep8

.PHONY: clean
clean: clean-build clean-download clean-virtualenv clean-dist

.PHONY: clean-dist
clean-dist:
	$(RM) -rf distribute/$(NAME)
	$(RM) -rf distribute/deb/files

.PHONY: clean-build
clean-build:
	$(RM) -r build

.PHONY: clean-download
clean-download:
	$(RM) -r download

.PHONY: clean-virtualenv
clean-virtualenv:
	$(RM) virtualenv
	$(RM) -r virtualenv-*/


.PHONY: dist
dist:
	cd distribute; sh ./distribute.sh
	@echo "Now upload to https://github.com/fablabnbg/inkscape-paths2openscad/releases/"

#install is used by dist.
install:
	mkdir -p $(DEST)
	install -m 755 -t $(DEST) *.py
	install -m 644 -t $(DEST) *.inx


include make-includes/python.mk
include make-includes/variables.mk
