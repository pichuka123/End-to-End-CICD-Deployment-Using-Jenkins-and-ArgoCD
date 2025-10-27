pipeline {
  agent any

  /*tools {
    maven 'maven3'
  }
  --- not requored for python applications */ 

  triggers {
		githubPush()
	}

  stages {

    stage('Checkout') {
      steps {
        echo 'Cloning GIT HUB Repo'
        git branch: 'main',
        url: 'https://github.com/pichuka123/End-to-End-CICD-Deployment-Using-Jenkins-and-ArgoCD.git'
      }
    }
  

    /*stage('SonarQube Scan') {
      steps {
        echo 'Scanning project'
        // List directory contents for debugging purposes
        sh 'ls -ltr'
        // Run SonarQube scan with specified SonarQube server and login token
        sh ''' mvn sonar:sonar \\
        -Dsonar.host.url=http://100.26.227.191:9000 \\
        -Dsonar.login=squ_19733ad4e43d54992ef61923b91447e2d17a3062'''
        }
      }*/

    stage('Docker Access Test') {
      steps {
        sh 'docker ps'
      }
    }

    stage('Build Docker Image') {
      steps {
        // Tag the image with the current build number
        sh 'docker build -t princecharu/flask-application:${BUILD_NUMBER} -f Dockerfile .'
      }
    }


    stage('Scan Docker Image using Trivy') { 
            steps { 
                echo 'scanning Image' 
                sh 'trivy image princecharu/flask-application:${BUILD_NUMBER}' 
            } 
        }

    stage('Push Image to DockerHub') {
      steps {

        script {
          // Use Dockerhub credentials to access Docker Hub
          withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhub')]) {
          sh 'docker login -u princecharu -p ${dockerhub}'
          }
          // Push the Docker image to Docker Hub
          sh 'docker push princecharu/flask-application:${BUILD_NUMBER}'
        }
      }
    }

      stage('Update Deployment File with Build Number here') {

        environment {
        GIT_REPO_NAME = "End-to-End-CICD-Deployment-Using-Jenkins-and-ArgoCD"
        GIT_USER_NAME = "pichuka123"
        }

        steps {
        withCredentials([string(credentialsId: 'githubtoken', variable: 'githubtoken')]) {
        sh '''
        # Configure git user
        git config user.email "prince.charu7@gmail.com"
        git config user.name "pichuka123"
        
        # Replace the tag in the deployment YAML file with the current build number
        sed -i "s/flask-application:.*/flask-application:${BUILD_NUMBER}/g" deploymentfiles/deployment.yml
        
        #Stage all changes
        git add .
        
        # Commit changes with a message containing the build number
        git commit -m "Updating deployment image to version ${BUILD_NUMBER}"
        
        #Push changes to the main branch of the GitHub repository
        git push https://${githubtoken}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main '''
      }
     }
   }
 }
}

