#!/usr/bin/env bash
set -euo pipefail

# Deployment via rsync over SSH.
# Required env vars:
#   DEPLOY_HOST (e.g. example.com)
#   DEPLOY_USER (e.g. deploy)
#   DEPLOY_PATH (e.g. /var/www/html/klubradio)
# Optional:
#   DEPLOY_PORT (default: 22)
#   FLUTTER_BUILD_ARGS (default: "--release")
#
# Example:
#   DEPLOY_HOST=example.com DEPLOY_USER=deploy DEPLOY_PATH=/var/www/app ./scripts/deploy_web.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

: "${DEPLOY_HOST:?DEPLOY_HOST is required}"
: "${DEPLOY_USER:?DEPLOY_USER is required}"
: "${DEPLOY_PATH:?DEPLOY_PATH is required}"

DEPLOY_PORT="${DEPLOY_PORT:-22}"
FLUTTER_BUILD_ARGS="${FLUTTER_BUILD_ARGS:---release}"

echo "Building web (${FLUTTER_BUILD_ARGS})..."
flutter build web ${FLUTTER_BUILD_ARGS}

echo "Deploying build/web to ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH} (port ${DEPLOY_PORT})..."
rsync -avz --delete \
  -e "ssh -p ${DEPLOY_PORT}" \
  "${ROOT_DIR}/build/web/" \
  "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/"

echo "Done."

