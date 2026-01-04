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

# Load local deployment config if present (never commit secrets).
if [[ -f "${ROOT_DIR}/.env.deploy" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "${ROOT_DIR}/.env.deploy"
  set +a
elif [[ -f "${ROOT_DIR}/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "${ROOT_DIR}/.env"
  set +a
fi

: "${DEPLOY_HOST:?DEPLOY_HOST is required}"
: "${DEPLOY_USER:?DEPLOY_USER is required}"
: "${DEPLOY_PATH:?DEPLOY_PATH is required}"

DEPLOY_PORT="${DEPLOY_PORT:-22}"
FLUTTER_BUILD_ARGS="${FLUTTER_BUILD_ARGS:---release}"
DEPLOY_METHOD="${DEPLOY_METHOD:-rsync}"

echo "Building web (${FLUTTER_BUILD_ARGS})..."
flutter build web ${FLUTTER_BUILD_ARGS} --base-href /web/

WEBROOT_DIR="${ROOT_DIR}/webroot"

if [[ "${DEPLOY_METHOD}" == "sftp" ]]; then
  : "${DEPLOY_PASSWORD:?DEPLOY_PASSWORD is required for DEPLOY_METHOD=sftp}"
  if ! command -v lftp >/dev/null 2>&1; then
    echo "Missing 'lftp' (required for SFTP deployment). Install it and retry." >&2
    exit 1
  fi

  echo "Deploying build/web to sftp://${DEPLOY_USER}@${DEPLOY_HOST}${DEPLOY_PATH} (port ${DEPLOY_PORT})..."
  lftp -u "${DEPLOY_USER},${DEPLOY_PASSWORD}" "sftp://${DEPLOY_HOST}:${DEPLOY_PORT}" <<LFTP
set sftp:auto-confirm yes
set net:max-retries 2
set net:timeout 20
mirror -R --delete --verbose "${ROOT_DIR}/build/web" "${DEPLOY_PATH}"
quit
LFTP

  if [[ -d "${WEBROOT_DIR}" ]]; then
    echo "Deploying webroot files to sftp://${DEPLOY_USER}@${DEPLOY_HOST}${DEPLOY_PATH} ..."
    lftp -u "${DEPLOY_USER},${DEPLOY_PASSWORD}" "sftp://${DEPLOY_HOST}:${DEPLOY_PORT}" <<LFTP
set sftp:auto-confirm yes
set net:max-retries 2
set net:timeout 20
# Do not use --delete here: the hosting root also contains the deployed /web app folder.
mirror -R --only-newer --verbose "${WEBROOT_DIR}" "${DEPLOY_PATH%/}"
quit
LFTP
  fi
else
  echo "Deploying build/web to ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH} (port ${DEPLOY_PORT})..."
  rsync -avz --delete \
    -e "ssh -p ${DEPLOY_PORT}" \
    "${ROOT_DIR}/build/web/" \
    "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH}/"

  if [[ -d "${WEBROOT_DIR}" ]]; then
    echo "Deploying webroot files to ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH} (port ${DEPLOY_PORT})..."
    # Do not use --delete here: the hosting root also contains the deployed /web app folder.
    rsync -avz \
      -e "ssh -p ${DEPLOY_PORT}" \
      "${WEBROOT_DIR}/" \
      "${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_PATH%/}/"
  fi
fi

echo "Done."
