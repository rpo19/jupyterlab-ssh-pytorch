# Set the default version if none is provided
VERSION ?= latest

# The release target
release:
	tar -C compose -czf jupyterlab-ssh-pytorch-compose$(VERSION).tar.gz \
		docker-compose.yml \
		env-sample.txt \
		DockerfileRootPwd

# Help target for guidance
help:
	@echo "Usage:"
	@echo "  make release VERSION=<version>"
	@echo "    - Create a tarball with the specified version (default: 'latest')"
	@echo "  make help"
	@echo "    - Show this help message"

