#!/bin/bash

#Script will attemmpt to install
# Tekton-Pipelines
# Tekton-Dashboard
# Tekton-Tasks Required

ERROR_COUNT=3
TEKTON_DASHBOARD_VERSION=v0.19.0
TEKTON_NAMESPACE=tekton-pipelines
TEKTON_DIRECTORY=/tmp/trivy-tekton-example
DEPLOYMENT_NAMESPACE=trivy-demo
CODE_REPO=https://github.com/MoOyeg/trivy-tekton-example

error_out() {
   echo "Failed because of $1"
   exit 1
}

echo -e "Installing Tekton Pipelines \n"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

echo "Confirm Tekton Pipelines Namespaces is available"
loop_count=0
while [[ $(kubectl get namespace ${TEKTON_NAMESPACE} -o name) != "namespace/${TEKTON_NAMESPACE}" ]]
  do
    echo "Sleeping because namepace ${TEKTON_NAMESPACE} not yet available"
    if [[ ${loop_count} -eq ${ERROR_COUNT} ]]
    then
      error_out "${TEKTON_NAMESPACE} did not become available"
    fi
    ((loop_count++))
  done

echo -e "Installing Tekton Dashboard \n"
kubectl apply -f https://github.com/tektoncd/dashboard/releases/download/${TEKTON_DASHBOARD_VERSION}/tekton-dashboard-release.yaml

echo -e "Installing Tekton Tasks \n"
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml -n $TEKTON_NAMESPACE

kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/pylint/0.2/pylint.yaml -n $TEKTON_NAMESPACE

kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kaniko/0.4/kaniko.yaml -n $TEKTON_NAMESPACE

kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kubernetes-actions/0.2/kubernetes-actions.yaml -n $TEKTON_NAMESPACE

echo -e "Clone Repo and Build Tasks and Pipeline \n"

git clone ${CODE_REPO} ${TEKTON_DIRECTORY} && \
kubectl apply -f ${TEKTON_DIRECTORY}/cicd/tasks -n ${TEKTON_NAMESPACE} && \
kubectl create namespace ${DEPLOYMENT_NAMESPACE} && \
kubectl create clusterrolebinding pipelines-default-admin --clusterrole=cluster-admin --serviceaccout=tekton-pipelines:default -n ${DEPLOYMENT_NAMESPACE}

