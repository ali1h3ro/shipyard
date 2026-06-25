# Shipyard

Shipyard is a small self-hosted deployment platform for VPS-based projects.

It provides release-based deployments, atomic symlink switching, rollback support, Nginx generation, project configuration, and GitHub Actions-friendly deployment workflows.

## Features

- Static site deployments
- Release folders
- Atomic `current` symlink switching
- Rollbacks
- Project status
- Deployment logs
- Nginx config generation
- Health checks with `shipyard doctor`
- GitHub Actions deployment support

## Installation

```bash
git clone https://github.com/ali1h3ro/shipyard.git
cd shipyard
sudo ./install.sh
