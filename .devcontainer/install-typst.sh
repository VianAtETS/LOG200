#!/bin/sh
# Installe le CLI Typst dans /usr/local/bin. Appelé par postCreateCommand.
# Garder la version identique à TYPST_VERSION dans .github/workflows/pages.yml:
# l'export HTML change d'une version à l'autre.
set -eu

TYPST_VERSION="0.15.1"

case "$(uname -m)" in
  x86_64) arch=x86_64 ;;
  aarch64 | arm64) arch=aarch64 ;;
  *) echo "Architecture non supportée: $(uname -m)" >&2; exit 1 ;;
esac

if command -v typst >/dev/null 2>&1 && typst --version | grep -q "$TYPST_VERSION"; then
  echo "typst $TYPST_VERSION déjà installé"
  exit 0
fi

dir="typst-${arch}-unknown-linux-musl"
curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/${dir}.tar.xz" \
  | sudo tar -xJ --strip-components=1 -C /usr/local/bin "${dir}/typst"
typst --version
