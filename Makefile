# Set the default version if none is provided
VERSION ?= latest

# The release target
release:
	tar -C docker -czf jupyterlab-ssh-pytorch-docker-$(VERSION).tar.gz \
		create.sh \
		env-sample.txt

# Docker build target
docker:
	sudo docker build -t rpozzi/jupyterlab-ssh-pytorch:$(VERSION) -f Dockerfile .

# Docker push target
push:
	sudo docker push rpozzi/jupyterlab-ssh-pytorch:$(VERSION)

# Help target for guidance
help:
	@echo "Usage:"
	@echo "  make release VERSION=<version>"
	@echo "    - Create a tarball with the specified version (default: 'latest')"
	@echo "  make docker VERSION=<version>"
	@echo "    - Build the Docker image with the specified version (default: 'latest')"
	@echo "  make push VERSION=<version>"
	@echo "    - Push the Docker image to the repository with the specified version (default: 'latest')"
	@echo "  make help"
	@echo "    - Show this help message"
