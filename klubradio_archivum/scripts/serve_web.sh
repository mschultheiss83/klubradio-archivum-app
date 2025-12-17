#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WEB_DIR="${ROOT_DIR}/build/web"

if [[ ! -d "${WEB_DIR}" ]]; then
  echo "Missing ${WEB_DIR}. Build it first: flutter build web --release" >&2
  exit 1
fi

PORT="${PORT:-8080}"
cd "${WEB_DIR}"
echo "Serving ${WEB_DIR} on http://127.0.0.1:${PORT}"
python3 -m http.server "${PORT}"

