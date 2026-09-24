#!/bin/bash
# Baixa o Flutter SDK na versão estável
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Compila o projeto para web
flutter build web