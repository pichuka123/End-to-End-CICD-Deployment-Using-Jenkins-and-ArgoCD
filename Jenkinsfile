pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-creds')  // from Jenkins 'Credentials' Configuration
  }
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/pichuka123/jenkinsautomations.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t flask-application .'
      }
    }
    stage('Tag & Push') {
      steps {
        sh '''
        docker tag flask-application princecharu/flask-application:latest
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push princecharu/flask-application:latest
        '''
        /*
        docker run -d -p 5000:5000 princecharu/flask-app - this can be kept in steps, but,
        this step -> docker run -d -p 5000:5000 princecharu/flask-app here is optional, 
        just to check app is runnig or not using EC2DNS:5000, for checking purpose, 
        we are keeping this here to check anyway.
        and
        docker run -d -p 80:5000 princecharu/flask-app 
        here is optional, it is to run the app with 80 port without updating inboud port 5000 at Security Group 
        of EC2 Instance
        */ 
      }
    }
  }
}

//in case of SSH
//checkout([$class: 'GitSCM',
//          branches: [[name: '*/main']],
//          userRemoteConfigs: [[
//            url: 'git@github.com:pichuka123/flask-devops-app.git',
//            credentialsId: 'github-ssh'
//          ]]
//])
