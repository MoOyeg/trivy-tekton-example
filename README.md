# trivy-tekton-example  

Steps:  

- Install Tekton Pipelines  

- Apply Required Tasks
  
    1 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.4/git-clone.yaml -n tekton-pipelines```  

    2 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/pylint/0.2/pylint.yaml -n tekton-pipelines```

    3 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kaniko/0.4/kaniko.yaml -n tekton-pipelines```

    4 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kubernetes-actions/0.2/kubernetes-actions.yaml -n tekton-pipelines```

    5 ```kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/buildah/0.2/buildah.yaml -n tekton-pipelines```

- Build Local Registry  
  
    1 ```openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout ./tls.key -out ./tls.crt -subj "/CN=docker-registry"```

    2 ```kubectl create secret tls certs-secret --cert=./tls.crt --key=./tls.key -n tekton-pipelines```

    3 ```docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > ./htpasswd```  

    4 ```kubectl create secret generic auth-secret --from-file=./htpasswd -n tekton-pipelines```

