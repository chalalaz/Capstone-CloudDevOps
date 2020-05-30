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
    stage('Deploy container') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh 'kubectl apply -f ./src/green-controller.yml'
        }
      }
    }
    stage('redirect to green') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh 'kubectl apply -f ./src/green-service.yml'
        }
      }
    }
  }
}
