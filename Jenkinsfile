pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "kannandolmites/nginx-frontend" // Replace with your Docker image name
        DOCKER_TAG = "latest" // Update if you want a specific version tag
        KUBE_DEPLOY_FILE = "deployment-and-service.yml" // Kubernetes manifest file
    }
    stages {
        stage('Checkout') {
            steps {               
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kannancloud001/CICD.git']])
            }
        }
        stage('Build and Push Docker Image') {
            steps {               
                sh  'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
                sh   'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                sh  'docker push ${DOCKER_IMAGE}:${DOCKER_TAG}'
                
            }
        }
        stage('Deploy to Kubernetes') {
            steps {                
                sh  'kubectl apply -f ${KUBE_DEPLOY_FILE}'
                
            }
        }
    }
    
}
