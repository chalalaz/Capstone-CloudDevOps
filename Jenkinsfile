pipeline {
  agent any
  environment {
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
        }
      }
    }
    stage('Push image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            dockerImage.push("latest")
            sh 'docker rmi '
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
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
