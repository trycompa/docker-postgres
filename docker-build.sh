
#!/usr/bin/env bash
set -eou pipefail
ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" &> /dev/null && pwd )"

cd "$ROOT"

versions=("17" "18")

for version in "${versions[@]}"; do
  # linux/amd64
  docker buildx build \
    --platform linux/amd64 \
    -f "Dockerfile$version.postgres" \
    -t "postgres:$version-linux-amd64" \
    .

  # linux/amd64
  docker buildx build \
    --platform linux/arm64 \
    -f "Dockerfile$version.postgres" \
    -t "postgres:$version-linux-arm64" \
    .

  docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -f "Dockerfile$version.postgres" \
    -t "postgres:$version" \
    .
done