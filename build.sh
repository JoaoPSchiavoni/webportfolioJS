#!/bin/bash
set -euo pipefail

# Baixa o Flutter SDK na versão estável quando o cache ainda não existe.
if [ ! -d flutter ]; then
  git clone --depth 1 https://github.com/flutter/flutter.git -b stable
fi
export PATH="$PATH:$(pwd)/flutter/bin"

# Compila o projeto para web
flutter build web --release
