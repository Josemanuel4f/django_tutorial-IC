pipeline {
    environment {
        IMAGEN = "josemanuel4fernandez/django_python"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("Desarrollo") {
            agent {
                docker { image "python:3"
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/Josemanuel4f/django_tutorial-IC'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'cd django_tutorial && pip install -r requirements.txt'
                    }
                }
                stage('Test')
                {
                    steps {
                        sh 'cd django_tutorial && python3 manage.py test'
                    }
                }

            }
        }
        stage("Construccion") {
            agent any
            stages {
                stage('CloneAnfitrion') {
                    steps {
                        git branch:'main',url:'https://github.com/Josemanuel4f/django_tutorial-IC'
                    }
                }
                stage('BuildImage') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('UploadImage') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('RemoveImage') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
                stage ('SSH') {
    steps{
        sshagent(credentials : ['SSH_JOSEMA']) {
            sh 'ssh -o StrictHostKeyChecking=no josema@race.overcat.es wget https://raw.githubusercontent.com/Josemanuel4f/django_tutorial/master/docker-compose.yaml -O docker-compose.yaml'
            sh 'ssh -o StrictHostKeyChecking=no josema@race.overcat.es docker compose up -d --force-recreate'
        }
    }
}
            }
        }           
    }
    post {
        always {
            mail to: 'josemanuel4fernandez@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
