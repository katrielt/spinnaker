#!/bin/bash

# Find the repository root
COMMIT_SHA=$(git rev-parse --short HEAD)
REPO_ROOT=$(git rev-parse --show-toplevel)

if [ -z "$REPO_ROOT" ]; then
  echo "Error: Could not find repository root."
  exit 1
fi

cd "$REPO_ROOT"

gcloud builds submit . --config=clouddriver/cloudbuild-ubuntu.yaml --project=waze-ci --substitutions=COMMIT_SHA="${COMMIT_SHA}"

echo "Image built and pushed to: europe-west1-docker.pkg.dev/waze-ci/waze-spinnaker-images/clouddriver:2025.3.1-${COMMIT_SHA}"