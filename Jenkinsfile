pipeline {
  agent any
  environment {
    DOCKER_IMAGE_NAME = "chalalaz/capstone"
    registry = "chalalaz/capstone"
    registryCredential = 'dockerhub'
	}
  stages {
    stage('Linting') {
      steps {
         sh 'tidy -q -e *.html'
      }
    }
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          dockerImage.inside {
            sh 'echo Hello, Nginx!'
          }
        }
      }
    }
    stage('Push image') {
      steps {
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('set current kubectl context') {
      steps {
        sh 'echo "set current kube"'
      }
    }
    stage('Deploy container') {
      steps {
        sh 'echo "Deploy container"'
      }
    }
  }
}
