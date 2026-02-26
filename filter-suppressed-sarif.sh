#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./filter-suppressed-sarif.sh input.sarif output.sarif
#
# Removes SARIF results that are suppressed in-source (e.g., via #checkov:skip=...),
# identified by presence of: result.suppressions[].kind == "inSource"

IN="${1:-}"
OUT="${2:-}"

if [[ -z "${IN}" || -z "${OUT}" ]]; then
  echo "Usage: $0 <input.sarif> <output.sarif>" >&2
  exit 2
fi

if [[ ! -f "${IN}" ]]; then
  echo "Error: input file not found: ${IN}" >&2
  exit 2
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required but not installed." >&2
  echo "Install: sudo apt-get update && sudo apt-get install -y jq" >&2
  exit 2
fi

# Filter:
# Keep results that DO NOT have any suppressions with kind == "inSource"
# (If suppressions is missing/null/empty -> keep)
jq '
  .runs |= map(
    .results = (
      (.results // [])
      | map(
          select(
            (
              (.suppressions // [])
              | map(.kind == "inSource")
              | any
            ) | not
          )
        )
    )
  )
' "${IN}" > "${OUT}"

echo "Wrote filtered SARIF to: ${OUT}"