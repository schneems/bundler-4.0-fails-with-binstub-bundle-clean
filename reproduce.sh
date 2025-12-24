#!/bin/bash
set -e

echo "=== WITH bin/bundle binstub ==="
docker build -q -t bundler-issue-with-binstub -f Dockerfile . >/dev/null
docker run --rm bundler-issue-with-binstub

echo ""
echo "=== WITHOUT bin/bundle binstub ==="
docker build -q -t bundler-issue-no-binstub -f Dockerfile.no-binstub . >/dev/null
docker run --rm bundler-issue-no-binstub
