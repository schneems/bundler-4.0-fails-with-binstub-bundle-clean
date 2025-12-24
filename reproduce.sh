#!/bin/bash
set -e

docker build --platform linux/amd64 -t bundler-issue-with-binstub -f Dockerfile .
# Search for bundler-*.gemspec
# docker run --rm --platform linux/amd64 bundler-issue-with-binstub find / -name "bundler-*.gemspec"
docker run --rm --platform linux/amd64 bundler-issue-with-binstub
