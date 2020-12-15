def imageNameAndTag
pipeline {
    agent none;
    stages {
        stage('Prepare Jenkins Image') {
            agent { docker 'docker:dind' }
            steps {
               imageNameAndTag = sh returnStdout: true,script:"""
                    timestampDateAndTime=$(date +"%Y-%m-%d-%T")
                    echo "samitkumarpatel/jenkins:$timestampDateAndTime"
                """
                sh """
                    docker build -t $imageNameAndTag -f jenkins-customise-image/Dockerfile .
                    docker push $imageNameAndTag
                """
            }
        }
        stage('provision k8s cluster') {
            agent { docker 'terraform:latest' }
            steps {
                sh """
                    # TODO be in the folder of terraform/stacks/k8s-cluster 
                    terraform init
                    terraform plan
                    terraform apply
                """
            } 
        }
        stage('provision Jenkins') {
            agent { docker 'terraform:latest' }
            steps {
                sh """
                    # TODO be in the folder of terraform/stacks/jenkins
                    terraform init
                    terraform plan
                    terraform apply
                """
            } 
        }

    }
}