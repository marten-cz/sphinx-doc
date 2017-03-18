# sphinx-doc

## Docker images

This is repository of base sphinx-doc docker image. There are two docker images
one is base image with only basic packages and second is for programming related
documentation. It contains additional packages for documenting APIs, blueprints
etc.

### Docker Hub

Download the image from Docker hub like this:

    $ docker pull martencz/sphinx-doc

or

    $ docker pull martencz/sphinx-doc-programming

### Extending

If you need additional packages and tools, you can create your own container.
Create Dockerfile with similar content

    FROM martencz/sphinx-doc:latest

    RUN pip install sphinx-intl

    CMD ["/bin/bash"]

    WORKDIR /doc

Then build the image"

    $ docker build -t my-sphinx-doc .

## Starting with sphinx-doc

If you want to start to write new documentation, you can let sphinx create
a skeleton by running:

    $ docker run --rm -it -v .:/doc martencz/sphinx-doc sphinx-quickstart

It will generate directory structure and Makefile to build the documentation.
To use docker with make, just change `SPHINXBUILD` in Makefile to:

    SPHINXBUILD = docker run --rm -v .:/doc martencz/sphinx-doc sphinx-build
