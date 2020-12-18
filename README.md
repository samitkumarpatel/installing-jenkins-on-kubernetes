### Jenkins on k8s

With various method we can install Jenkins on k8s.
 
- [helm](https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins)
- Write Your Own Menifast
- Use k8s Operators
- by using terrform provider

#### About the folder structure

```
├── Jenkinsfile
├── README.md
├── jenkins-image
│   ├── Dockerfile
│   ├── README.md
│   └── plugins.txt
├── k8s-manifest
│   ├── config-map.yaml
│   ├── deployment.yaml
│   ├── persistance
│   │   ├── docker-desktop.yaml
│   │   └── pvc.yaml
│   ├── rbac.yaml
│   └── service.yaml
└── terraform
    ├── aks
    │   ├── jcac.yml
    │   ├── main.tf
    │   ├── provider.tf
    │   └── terraform.tf
    ├── docker-desktop
    │   ├── jcac.yml
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── terraform.tf
    │   ├── terraform.tfstate
    │   └── terraform.tfstate.backup
    └── modules
        ├── aks
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        └── jenkins
            ├── main.tf
            ├── rbac.tf
            └── variable.tf
```

- `jenkins-image` :  
- `k8s-manifest` : 
- `terraform`: This contains all the terraform stacks and module HCL script.
```
└── terraform
    ├── aks
    │   ├── jcac.yml
    │   ├── main.tf
    │   ├── provider.tf
    │   └── terraform.tf
    ├── docker-desktop
    │   ├── jcac.yml
    │   ├── main.tf
    │   ├── provider.tf
    │   ├── terraform.tf
    │   ├── terraform.tfstate
    │   └── terraform.tfstate.backup
    └── modules
        ├── aks
        │   ├── main.tf
        │   ├── output.tf
        │   └── variable.tf
        └── jenkins
            ├── main.tf
            ├── rbac.tf
            └── variable.tf
```
