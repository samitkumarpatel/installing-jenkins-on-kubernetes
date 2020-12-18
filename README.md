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

- `jenkins-image` :  This folder contain a Dockerfile to build a customise Jenkins image of your choice 
```
docker build -t samitkumarpatel/jenkins:lts -f image/Dockerfile .
docker login -u samitkumarpatel -p $DOCKER_REGISTRY_PASSWORD
docker push samitkumarpatel/jenkins:lts
```
- `k8s-manifest` : This folder contain , k8s api inputs to create Deployment, Service, RBAC, which will help Jenkins to run and create dynamic slave when a build demand it.

```
kubectl create namespace jenkins
kubectl apply -f k8s-manifest/ -n jenkins
```

- `terraform`: This folder contains the terraform stacks and module script to provision k8s cluster and Jenkins wiith 0 manual configation effort.
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

To invoke this with a automation tool
```
cd terraform/aks
terraform init && terraform validate
terraform plan
terraform apply --auto-approved
```