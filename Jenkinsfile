pipeline {
  agent any
  environment {
    blue = "chalalaz/blue"
    green = "chalalaz/green"
    registryCredential = 'dockerhub'
	}
  stages {
    stage('Linting') {
      steps {
         sh 'tidy -q -e source/blue/*.html'
         sh 'tidy -q -e source/green/*.html'
      }
    }
    stage('Build image') {
      steps {
        script {
          blueImage = docker.build("${blue}:$BUILD_NUMBER", "./source/blue/")
          greenImage = docker.build("${green}:$BUILD_NUMBER", "./source/green/")
        }
      }
    }
    stage('Push image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            blueImage.push()
            blueImage.push("latest")
            greenImage.push()
            greenImage.push("latest")
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $blue:$BUILD_NUMBER"
        sh "docker rmi $blue:latest"
        sh "docker rmi $green:$BUILD_NUMBER"
        sh "docker rmi $green:latest"
      }
    }
    stage('Deploy green controller') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh "aws eks --region ap-southeast-1 update-kubeconfig --name EKS-Capstone"
          sh "kubectl apply -f ./aws/aws-auth-cm.yaml"
          sh "kubectl apply -f ./aws/k8s-script/green-controller.yml"
          sh "kubectl get pods"
          sh "kubectl describe pod green"
        }
      }
    }
    stage('Wait user approve for green deployment') {
      steps {
        input "Ready to deploy blue controller?"
      }
    }
    stage('Deploy green service') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh "kubectl apply -f ./aws/k8s-script/green-service.yml"
          sh "kubectl get service"
          sh "kubectl describe service bluegreenlb"
        }
      }
    }
    stage('Deploy blue controller') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh "kubectl apply -f ./aws/k8s-script/blue-controller.yml"
          sh "kubectl get pods"
          sh "kubectl describe pod blue"
        }
      }
    }
    stage('Wait user approve for blue deployment') {
      steps {
        input "Ready to deploy blue service?"
      }
    }
    stage('Deploy blue service') {
      steps {
        withAWS(credentials: 'eks-admin', region: 'ap-southeast-1') {
          sh "kubectl apply -f ./aws/k8s-script/blue-service.yml"
          sh "kubectl describe service bluegreenlb"
        }
      }
    }
  }
}
