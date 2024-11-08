pipeline {
    agent any
    
    stages {
        stage("Code") {
            steps {
                git url: "https://github.com/pabhi18/FoodPlaza-Jenkins.git", branch: "main"
            }
        }
        
        stage("Build") {
            steps {
                sh "docker build -t pabhi4881/jenkins-cicd:latest ."
            }
        }
        
        stage("Push to Repository") {
            steps {
                withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                    sh """
                        docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}
                        docker push pabhi4881/jenkins-cicd:latest
                    """
                }
            }
        }
    }
    
    post {
        always {
            sh "docker logout"
        }
    }
}