#!/usr/bin/env bash
# Smoke check script for mini-vector-space-core
echo "mini-vector-space-core check..."
lake build 2>&1
if [ $? -eq 0 ]; then echo "BUILD OK"; else echo "BUILD FAILED"; fi
