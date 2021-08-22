# trivy-tekton-example  

Steps:  

- Install Tekton Pipelines  

- Apply Required Tasks
  
    1 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml```  

    2 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/pylint/0.2/pylint.yaml```

