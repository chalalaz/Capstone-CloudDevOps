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
          sh "aws eks --region ap-southeast-1 update-kubeconfig --name EKS-Capstone"
          sh "kubectl apply -f ./aws/aws-auth-cm.yaml"
          sh "kubectl apply -f ./src/green-controller.yml"
          sh "kubectl apply -f ./src/green-service.yml"
          URL_GREEN = sh "kubectl get service bluegreenlb --output=jsonpath='{.status.loadBalancer.ingress[0]['hostname','ip']}'"
        }
      }
    }
    stage('Green deployment Testing') {
      steps {
        script {
          try {
            new URL("$URL_GREEN:8000").getText()
            return true
          } catch (Exception e) {
            return false
          }
        }
      }
    }
  }
}
