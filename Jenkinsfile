pipeline {
  agent any
  environment {
        DOCKER_IMAGE_NAME = "chalalaz/capstone"
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
          app = docker.build(DOCKER_IMAGE_NAME)
          app.inside {
            sh 'echo Hello, Nginx!'
          }
        }
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
