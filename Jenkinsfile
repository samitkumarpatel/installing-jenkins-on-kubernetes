def imageNameAndTag
pipeline {
    agent none;
    stages {
        stage('Prepare Jenkins Image') {
            agent { docker 'docker:dind' }
            environment {
                DOCKER_REGISTRY = credentials('docker-io')
            }
            steps {
               imageNameAndTag = sh returnStdout: true,script:"""
                    echo "samitkumarpatel/jenkins:lts"
                """
                sh """
                    docker build -t $imageNameAndTag -f jenkins-image/Dockerfile .
                    docker login -u $DOCKER_REGISTRY_USR -p $DOCKER_REGISTRY_PSW 
                    docker push $imageNameAndTag
                """
            }
        }
        //TODO
        stage('provision k8s cluster') {
            agent { docker 'terraform:latest' }
            steps {
                sh """
                    cd terraform/aks
                    export ARM_SUBSCRIPTION_ID="ADD_IT"
                    export ARM_CLIENT_ID="ADD_IT"
                    export ARM_CLIENT_SECRET="GET_IT_FROM_JENKINS_CREDENTIALS"
                    export ARM_TENANT_ID="ADD_IT"
                    terraform init && terraform validate
                    terraform plan
                    terraform apply --auto-approved
                """
            } 
        }
    }
}