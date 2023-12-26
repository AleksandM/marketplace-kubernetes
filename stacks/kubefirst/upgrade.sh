#!/bin/sh

set -e

################################################################################
# repo
################################################################################
helm repo add kubefirst https://charts.kubefirst.com
helm repo update > /dev/null

################################################################################
# chart
################################################################################
STACK="kubefirst"
CHART="kubefirst/kubefirst"
NAMESPACE="kubefirst"

if [ -z "${MP_KUBERNETES}" ]; then
    # use local version of values.yml
    ROOT_DIR=$(git rev-parse --show-toplevel)
    values="$ROOT_DIR/stacks/kubefirst/values.yml"
else
    # use github hosted master version of values.yml
    values="https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/kubefirst/values.yml"
fi

helm upgrade "$STACK" "$CHART" \
--namespace "$NAMESPACE" \
--values "$values" \
