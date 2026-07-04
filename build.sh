#!/bin/bash
# Build mdreader: embed marked.min.js as base64, compile with swiftc.
set -euo pipefail
cd "$(dirname "$0")"

echo "let markedJSBase64 = \"$(base64 -i marked.min.js | tr -d '\n')\"" > MarkedJS.swift
swiftc -O main.swift MarkedJS.swift -o mdreader

# Assemble app bundle (needed to be a Finder-openable default handler for .md)
rm -rf mdreader.app
mkdir -p mdreader.app/Contents/MacOS
cp mdreader mdreader.app/Contents/MacOS/
cp Info.plist mdreader.app/Contents/
codesign --force --sign - mdreader.app
echo "Built ./mdreader and ./mdreader.app"
