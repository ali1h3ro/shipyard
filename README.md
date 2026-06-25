#  Shipyard

> A lightweight self-hosted deployment platform for VPS-hosted applications.

Shipyard automates the repetitive parts of deploying applications to your own server. It creates projects, manages release-based deployments, generates Nginx configurations, keeps deployment history, and integrates seamlessly with GitHub Actions.

Whether you're hosting a personal portfolio, APIs, SaaS products, or internal tools, Shipyard provides a simple and consistent deployment workflow without relying on external platforms.

---

# Why Shipyard?

Deploying projects to a VPS often involves manually creating directories, writing Nginx configurations, uploading files, updating symlinks, and managing releases.

Shipyard turns that process into a single command.

Instead of:

- Creating project directories
- Writing Nginx configuration
- Enabling sites
- Uploading build artifacts
- Updating symlinks
- Remembering deployment commands

You simply run:

bash shipyard create portfolio --type static --domain example.com 

or deploy a new release with:

bash shipyard deploy portfolio /tmp/portfolio.tar.gz <release-id> 

---

# Features

- Release-based deployments
- Atomic symlink switching
- Rollback support
- Automatic Nginx configuration generation
- Multiple project types
  - Static
  - Laravel
  - Node
- Project configuration management
- Deployment status
- Health checks
- Deployment logs
- GitHub Actions friendly
- Modular architecture

---

# Architecture

Developer      │      ▼ Git Push      │      ▼ GitHub Actions      │      ▼ Build Artifact      │      ▼ Shipyard      │      ▼ Release Directory      │   ▼ Atomic Symlink Switch      │      ▼ Nginx      │      ▼ Production

Each deployment creates a new immutable release directory.

/var/www/sites/portfolio  ├── current -> releases/8fa2d19 ├── releases │   ├── 4ab8321 │   ├── 6e019ba │   └── 8fa2d19 └── shared

Deployments become atomic by updating the current symlink rather than replacing files in place.

---

# Installation

Clone the repository:

bash git clone https://github.com/<your-username>/shipyard.git cd shipyard 

Install Shipyard:

bash sudo ./install.sh 

Verify your installation:

bash shipyard doctor 

---

# Commands

## Create a project

bash shipyard create portfolio \     --type static \     --domain example.com 

Supported project types:

- static
- laravel
- node

---

## Deploy a release

bash shipyard deploy portfolio \     /tmp/portfolio.tar.gz \     394bfe1004a96cf518b1832c7253a65978ad9914 

---

## Check project status

bash shipyard status portfolio 

---

## Roll back

bash shipyard rollback portfolio 

---

## Regenerate Nginx configuration

bash shipyard nginx portfolio 

---

## List projects

bash shipyard list 

---

## Verify installation

bash shipyard doctor 

---

# Project Types

Configurable project types with extensible deployment templates

| Type | Description |
|------|-------------|
| Static | Static websites (Astro, Vite, React build output, etc.) |
| Laravel | Laravel applications (foundation for future deployment hooks) |
| Node | Node.js applications (foundation for future deployment hooks) |

Additional project types will be added in future releases.

---

# GitHub Actions

Shipyard is designed to work with GitHub Actions.

A typical workflow:

1. Build the application.
2. Archive the build output.
3. Upload the artifact to the VPS.
4. Execute:

bash shipyard deploy <project> /tmp/artifact.tar.gz <release-id> 

---

# Roadmap

Upcoming features include:

- HTTPS / Let's Encrypt integration
- Domain management
- Deployment hooks
- Laravel deployment pipeline
- Node.js service management
- Docker deployments
- Remote deployment monitoring
- Plugin support

---

# Contributing

Issues, feature requests, and pull requests are welcome.

If you find a bug or have an idea that improves Shipyard, feel free to open an issue or submit a pull request.

---

# License

This project is released under the MIT License.
