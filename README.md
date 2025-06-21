# SSH Server

[![GitHub release](https://img.shields.io/github/release/sgaunet/alpine-sshd.svg)](https://github.com/sgaunet/helm-alpine-sshd/releases/latest)
[![CI Status](https://github.com/sgaunet/alpine-sshd/actions/workflows/publish.yml/badge.svg)](https://github.com/sgaunet/alpine-sshd/actions/workflows/publish.yml)
[![CI Status](https://github.com/sgaunet/alpine-sshd/actions/workflows/release.yml/badge.svg)](https://github.com/sgaunet/alpine-sshd/actions/workflows/release.yml)
[![License](https://img.shields.io/github/license/sgaunet/alpine-sshd.svg)](LICENSE)

This is a simple alpine based SSHD server

  * A user is dedicated for SSH connection (named sshuser)
  * The /data directory is dedicated to transfer files (The way I use it)
  * Every files older than 5min will be deleted
  * Listening on port 22
  * Authentication can be done by SSH keys or password
  
You can use it inside kubernetes.

## Security features:

* The user root's password is un-assigned. 
* The container expects a ENV variable named "AUTHORIZED_KEYS" containing your SSH public key in it. If this ENV var is found empty, this container does not start. This prevents it becoming an open-(ssh)-relay. 

So simply pass your ssh public key as env var AUTHORIZED_KEYS to the container at run time, and you are good to go. You can actually pass multiple SSH public keys by putting them in one file, and then letting the entire file load as a string in this ENV variable. For example:

```
AUTHORIZED_KEYS="$(cat .ssh/my_many_ssh_public_keys_in_one_file.txt)"
```

# Deployment

In the deploy folder, there are:

* a docker folder with a docker-compose file to launch it
* a k8s folder with the manifests
* [helm chart available here](https://github.com/sgaunet/helm-alpine-sshd)

# Development

This project is using :

* [task for development](https://taskfile.dev/#/)
* docker
* [venom for tests](https://github.com/ovh/venom)

# Docker images

The github actions is producing two docker images:

* ghcr.io/sgaunet/alpine-sshd:latest (replace latest with the last tag)

## Project Status

🟨 **Maintenance Mode**: This project is in maintenance mode.

While we are committed to keeping the project's dependencies up-to-date and secure, please note the following:

- New features are unlikely to be added
- Bug fixes will be addressed, but not necessarily promptly
- Security updates will be prioritized

## Issues and Bug Reports

We still encourage you to use our issue tracker for:

- 🐛 Reporting critical bugs
- 🔒 Reporting security vulnerabilities
- 🔍 Asking questions about the project

Please check existing issues before creating a new one to avoid duplicates.

## Contributions

🤝 Limited contributions are still welcome.

While we're not actively developing new features, we appreciate contributions that:

- Fix bugs
- Update dependencies
- Improve documentation
- Enhance performance or security

If you're interested in contributing, please read our [CONTRIBUTING.md](CONTRIBUTING.md) guide for more information on how to get started.

## Support

As this project is in maintenance mode, support may be limited. We appreciate your understanding and patience.

Thank you for your interest in our project!