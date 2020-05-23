pipeline {
  agent any
  stages {
    stage('Linting') {
      steps {
        sh 'echo "Linting check"'
      }
    }
    stage('Build image') {
      steps {
        sh 'echo "Build image"'
      }
    }
    stage('Push image') {
      steps {
        sh 'echo "Push image"'
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
