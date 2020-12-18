module "aks" {
    source = "../modules/aks"
    resource_group_name = "aks001"
    location = "West Europe"

    acr_name = "acr01azwe001"
    cluster_name = "aks001"
    dns_prefix = "aks001"
    node_pool_name = "akspool001"
    agent_count = 1
    ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDKSth57ZOX4DsOCcbuMNVEky18e+XOJAgDDIGzR3IzhhC+hbmNlG17Vgx4fFaLfFYHRNKHJe+EiYrGSHPVIZKFJYKdYEd9me+ntgeFZwufIOVoNcNgtc6wjIe69cz+4lvLCp8aC5NZWBKNMoCHvt8J51505hW8mvWe1YpPNxjOBLMlL/JckLqDm3yZ7es9OB2XkI7xD+CPUwBJRnP/G6CKSLlOL9vn7Bz7dJjPa0QR9BQr655NsZtoqMD+w7QQN58XW7FBMN09GPY6kOtJHj5GTlJ79FoAGMIMJeB1pd4rp6tFcXOka8rVy3TEXns/V4JGvLkUf5cQAlbbMWOKdifMjNy8A/RRdwOwhvHsf7gxQeksTuMKW4jsLvKt98yL8nvd8OG+wjfwYRk9e8kLcFGIQC7VkLIfb822gatysJsyiSHluZLMvPl9SjfKCfSSfjI5Ync1Fh8rEHqW0Ts8ySofenF458ERcD0ZRh9ce5kBUsrFia4K+ZxWso8MknqU4gk= k8s@local"
    #This has to be set as ENV variable in your automation
    ARM_CLIENT_SECRET = "" 
}

module "jenkins" {
    source = "../modules/jenkins"
    name = "jenkins"
    namespace = "jenkins"
    jcac_config = file("${path.module}/jcac.yml")
}