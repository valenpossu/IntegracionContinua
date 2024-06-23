pipeline {
    agent any

    environment {
        DOCKER_GROUP_ID = "${env.DOCKER_GROUP_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build app1') {
            steps {
                script {
                    // Verificar los permisos del usuario jenkins y el grupo docker
                    sh 'id jenkins'
                    sh 'ls -l /var/run/docker.sock'
                }
                // Comandos para construir app1
                sh 'docker build -t app1 ./app1'
            }
        }
        stage('Build app2') {
            steps {
                // Comandos para construir app2
                sh 'docker build -t app2 ./app2'
            }
        }
    }
}