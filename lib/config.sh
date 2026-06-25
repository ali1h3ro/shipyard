#!/usr/bin/env bash

CONFIG_DIR="/etc/deploy-sites"

load_project_config() {
  local project="$1"
  local config_file="$CONFIG_DIR/$project.conf"

  if [ ! -f "$config_file" ]; then
    echo "Config not found: $config_file"
    exit 1
  fi

  source "$config_file"

  if [ -z "${PROJECT_NAME:-}" ] || [ -z "${PROJECT_DIR:-}" ]; then
    echo "Invalid config: PROJECT_NAME and PROJECT_DIR are required"
    exit 1
  fi
}
