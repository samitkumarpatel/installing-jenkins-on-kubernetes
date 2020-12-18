module "jenkins" {
    source = "../modules/jenkins"
    name = "jenkins"
    namespace = "jenkins"
    jcac_config = file("${path.module}/jcac.yml")
}