# trivy-tekton-example
Repo shows a sample of a Tekton Pipeline using Trivy to scan output image and infrastructure as Code Components. Pipline will build sample Python Code, Create a temporary Docker Registry(Simulate Staging Env), Push Image to Docker Registry, Scan the Image and Push it to a Production Repo.

Pre-requisites:

- Kubernetes Cluster(Tested with Kubernetes 1.21)

- Install Tekton Piplines[https://github.com/tektoncd/pipeline/blob/main/docs/install.md]

- Optional: Install Tekton Dashboard[https://github.com/tektoncd/dashboard]  

- Optional: An image that has skopeo and htpasswd(I have provided quay.io/mooyeg/python3).If you have yours kindly change the parameter in the PipelineRun

- Storage is required for this repo, the pvc manifest's in this playbook assume a default storageclass for dynamic PV creation. If there is no dynamic storageclass, kindly create PV's for the PVC.

Steps:

- Apply Tasks Required from TektonHub

  1 `kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml -n tekton-pipelines`

  2 `kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/pylint/0.2/pylint.yaml -n tekton-pipelines`

  3 `kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kaniko/0.4/kaniko.yaml -n tekton-pipelines`

  4 `kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kubernetes-actions/0.2/kubernetes-actions.yaml -n tekton-pipelines`

  5 `kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildah/0.2/buildah.yaml -n tekton-pipelines`

- Clone this Repo and Apply the Local Tasks Required
  
  1 `git clone https://github.com/MoOyeg/trivy-tekton-example /tmp/trivy-tekton-example`

  2 `cd /tmp/trivy-tekon-example`

  3 `kubectl apply -f ./cicd/tasks -n tekton-pipelines`

- Create Pipeline PVC and make sure it binds
  1 `kubectl apply -f ./cicd/pipeline-pvc.yaml -n tekton-pipelines`

- Create Pipeline and PipelineRuns, There are different PipelineRuns to show different use cases
  pipelinerun-pass-light.yaml: Shows running Trivy running a scan where the pipeline is always allowed to pass and uses a non-comprehensive(--light) report to speed up running.
