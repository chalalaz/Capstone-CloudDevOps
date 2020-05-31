pipeline {
  agent any
  environment {
    registry = "chalalaz/capstone"
    registryCredential = 'dockerhub'
    GREENURL = ''
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
        }
        def GREENURL = withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh "kubectl get service bluegreenlb --output=jsonpath=\"{.status.loadBalancer.ingress[0]['hostname','ip']}\""
      }
    }
    stage('Green deployment Testing') {
      steps {
        script {
          try {
            new URL("http://a3d5d8c14a28b11ea8875025489a51de-866573044.ap-southeast-1.elb.amazonaws.com:8001").getText()
            echo ${GREENURL}
            return true
          } catch (Exception e) {
            return false
          }
        }
      }
    }
  }
}
