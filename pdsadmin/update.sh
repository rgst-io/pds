#!/usr/bin/env bash
set -euo pipefail

PDS_DATADIR="/pds"
COMPOSE_FILE="${PDS_DATADIR}/compose.yaml"
COMPOSE_URL="https://raw.githubusercontent.com/rgst-io/pds/main/compose.yaml"

COMPOSE_TEMP_FILE="${COMPOSE_FILE}.tmp"

echo "* Downloading PDS compose file"
curl \
  --silent \
  --show-error \
  --fail \
  --output "${COMPOSE_TEMP_FILE}" \
  "${COMPOSE_URL}"

if cmp --quiet "${COMPOSE_FILE}" "${COMPOSE_TEMP_FILE}"; then
  echo "PDS is already up to date"
  rm --force "${COMPOSE_TEMP_FILE}"
  exit 0
fi

echo "* Updating PDS"
mv "${COMPOSE_TEMP_FILE}" "${COMPOSE_FILE}"
pushd "$PDS_DATADIR" >/dev/null
docker compose pull

if gh auth status &>/dev/null; then
  echo "* Verifying image attestation"
  gh attestation verify oci://ghcr.io/rgst-io/pds \
    --owner rgst-io --deny-self-hosted-runners
fi
popd >/dev/null

echo "* Restarting PDS"
systemctl restart pds

cat <<MESSAGE
PDS has been updated
---------------------
Check systemd logs: journalctl --unit pds
Check container logs: docker logs pds

MESSAGE
