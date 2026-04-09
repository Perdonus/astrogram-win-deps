#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <prepare-root> [output-dir]" >&2
  exit 1
fi

PREPARE_ROOT="$(realpath "$1")"
OUT_DIR="${2:-$PWD/out}"
mkdir -p "$OUT_DIR"

LIBS_DIR="$PREPARE_ROOT/Libraries/win64"
THIRDPARTY_DIR="$PREPARE_ROOT/ThirdParty"
REPO_ROOT="$(cd "$PREPARE_ROOT/tgd" 2>/dev/null && pwd || true)"

if [[ -z "$REPO_ROOT" ]]; then
  echo "warning: expected sibling repo at <prepare-root>/tgd; sources bundle will need manual assembly" >&2
fi

if [[ ! -d "$LIBS_DIR" ]]; then
  echo "missing $LIBS_DIR" >&2
  exit 1
fi
if [[ ! -d "$THIRDPARTY_DIR" ]]; then
  echo "missing $THIRDPARTY_DIR" >&2
  exit 1
fi

tar --zstd -cf "$OUT_DIR/astrogram-win-libs.tar.zst" -C "$PREPARE_ROOT/Libraries" win64

tar --zstd -cf "$OUT_DIR/astrogram-win-thirdparty.tar.zst" -C "$PREPARE_ROOT" ThirdParty

if [[ -n "$REPO_ROOT" ]]; then
  tar --zstd -cf "$OUT_DIR/astrogram-win-sources.tar.zst" \
    -C "$REPO_ROOT" \
    cmake \
    Telegram/codegen \
    Telegram/lib_base \
    Telegram/lib_crl \
    Telegram/lib_lottie \
    Telegram/lib_qr \
    Telegram/lib_rpl \
    Telegram/lib_spellcheck \
    Telegram/lib_storage \
    Telegram/lib_tl \
    Telegram/lib_ui \
    Telegram/lib_webrtc \
    Telegram/lib_webview \
    Telegram/ThirdParty
fi

echo "packed to $OUT_DIR"
