#!/bin/bash
# Build mdreader: embed marked.min.js as base64, compile with swiftc.
set -euo pipefail
cd "$(dirname "$0")"

echo "let markedJSBase64 = \"$(base64 -i marked.min.js | tr -d '\n')\"" > MarkedJS.swift
swiftc -O main.swift MarkedJS.swift -o mdreader
echo "Built ./mdreader"
