#!/bin/bash

set -eo pipefail

if ! kubectl -n "${NAMESPACE}" get deployment resource-locker-operator; then
  echo "No resource locker operator deployment found, exiting..."
  exit 0
fi

chart_version=$(kubectl -n "${NAMESPACE}" get deployment resource-locker-operator \
  -ojsonpath='{.metadata.labels.helm\.sh/chart}')

if [ "${chart_version}" != "resource-locker-operator-${NEW_VERSION}" ]; then
  echo "Deleting resource locker operator deployment..."
  kubectl -n "${NAMESPACE}" delete --wait=true --cascade=foreground deployment resource-locker-operator
else
  echo "No chart version change, exiting..."
fi
exit 0
