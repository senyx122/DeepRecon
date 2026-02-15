#!/usr/bin/env bash
# sample-config.sh
# Sample configuration for DeepRecon
# Usage:
#   source ./sample-config.sh
#   deeprecon example.com
#
# Or run one-off:
#   OUT_BASE="$HOME/ReconResults" THREADS=200 ./DeepRecon example.com

#######################################
# Basic settings
#######################################

# Base output folder (relative or absolute)
# Default: DeepRecon_Results (if left empty)
OUT_BASE="${OUT_BASE:-DeepRecon_Results}"

# Default timeout applied to tools listed in TIMEOUT_TOOLS (if -l used)
# Format: "10m", "30s", etc. If you prefer minutes you can use a number (e.g. 10 -> interpreted as 10m by the script).
TIMEOUT_DURATION="${TIMEOUT_DURATION:-10m}"

# Number of threads for httpx and other multi-threaded tools
THREADS="${THREADS:-50}"

# Temporary working dir (optional) - script will create OUT_BASE/<target>/...
TMP_DIR="${TMP_DIR:-/tmp/deeprecon_tmp}"

#######################################
# Tool selection / control
#######################################
# List of tools to attempt to install / check by the script.
# Keep in sync with the script's REQUIRED_TOOLS array.
REQUIRED_TOOLS=(
  subfinder
  assetfinder
  findomain
  httpx
  katana
  waybackurls
  gau
  jsecret
  curl
  md5sum
)

# Tools to apply timeout to by default when the -l option is used.
# Example: TIMEOUT_TOOLS=(gau katana)
TIMEOUT_TOOLS=(
  gau
  katana
)

#######################################
# Networking / httpx tuning
#######################################

# httpx status codes to keep as "live"
HTTPX_STATUS_CODES="${HTTPX_STATUS_CODES:-200,301,302}"

# httpx maximum timeouts (per request) - useful for slow targets
HTTPX_TIMEOUT="${HTTPX_TIMEOUT:-10s}"

# httpx other flags (example). You can add more flags here if desired.
# Keep as a single string; it will be appended to httpx invocation in the script.
HTTPX_EXTRA_FLAGS="${HTTPX_EXTRA_FLAGS:--silent -no-color}"

#######################################
# JS extraction tuning
#######################################

# Max JS filesize to download (in bytes) when extracting endpoints (default: 5MB)
JS_MAX_FILESIZE="${JS_MAX_FILESIZE:-5242880}"

# curl connect timeout & max-time for JS downloads
CURL_CONNECT_TIMEOUT="${CURL_CONNECT_TIMEOUT:-10}"
CURL_MAX_TIME="${CURL_MAX_TIME:-60}"

#######################################
# Output formatting / naming
#######################################

# Safe filename behavior: use md5 or sha1 fallback (script handles it)
# Optionally set a prefix for all outputs (useful if sharing machine)
OUT_PREFIX="${OUT_PREFIX:-}"

# Example: change default OUT_BASE to a path on your Desktop
# OUT_BASE="${HOME}/Desktop/ReconResults"

#######################################
# Helper functions (optional)
#######################################

# Print active config (useful for debugging)
print_deeprecon_config() {
  cat <<-EOF
  DeepRecon configuration (effective):
    OUT_BASE          = ${OUT_BASE}
    TIMEOUT_DURATION  = ${TIMEOUT_DURATION}
    THREADS           = ${THREADS}
    TMP_DIR           = ${TMP_DIR}
    TIMEOUT_TOOLS     = ${TIMEOUT_TOOLS[*]:-none}
    REQUIRED_TOOLS    = ${REQUIRED_TOOLS[*]}
    HTTPX_STATUS_CODES= ${HTTPX_STATUS_CODES}
    HTTPX_TIMEOUT     = ${HTTPX_TIMEOUT}
    HTTPX_EXTRA_FLAGS = ${HTTPX_EXTRA_FLAGS}
    JS_MAX_FILESIZE   = ${JS_MAX_FILESIZE}
EOF
}

#######################################
# Auto-apply: Uncomment if you want the file to export variables automatically when executed.
# If you prefer to only source it, leave commented.
#######################################

# Export important variables so DeepRecon (if started in a new shell) can pick them up.
# export OUT_BASE TIMEOUT_DURATION THREADS TMP_DIR JS_MAX_FILESIZE CURL_CONNECT_TIMEOUT CURL_MAX_TIME HTTPX_TIMEOUT HTTPX_EXTRA_FLAGS HTTPX_STATUS_CODES OUT_PREFIX

# End of sample-config.sh
