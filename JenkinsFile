def COLOR_MAP = [
    'SUCCESS' :'good',
    'FAILURE' : 'danger',
]
pipeline{
    agent any
    tools{
        maven "MAVEN3.9"
        jdk   "JDK17"
    }
    environment{
        registryCredential='ecr:us-east-1:awscreds'
        imageName='992382731968.dkr.ecr.us-east-1.amazonaws.com/vprofileappimage'
        vprofileRegistry='https://992382731968.dkr.ecr.us-east-1.amazonaws.com'
        cluster='vprofileapp'
        service='vprofileappsvc'
    }
    stages{
        stage('Fetch code') {
            steps{
                git branch: 'docker', url : 'https://github.com/hkhcoder/vprofile-project.git'
            }
        }

        stage('Unit Test') {
            steps{
                sh 'mvn test'
            }
        }   

        stage('Build') {
            steps{
                sh 'mvn install -DskipTests'
            }
            post{
                success{
                    echo "Archiving artifact"
                    archiveArtifacts artifacts:'**/*.war'
                }
            }
        }
        stage('Checkstyle Analysis') {
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        } 
          stage("Sonar Code Anaylsis") {
            environment {
                scannerHome=tool 'sonar6.2'
            }
            steps {
              withSonarQubeEnv('sonarserver') {
                sh """
                    ${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml
                """
              }
            }
        }
            stage("Quality Gate") {
                steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
              }
            }
          }
        stage('Build App Image') {
        steps {
       
             script {
                  dockerImage = docker.build( imageName + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
             }
     }
    
    }

    stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
     }
    stage('Deploy to ecs') {
          steps {
        withAWS(credentials: 'awscreds', region: 'us-east-1') {
          sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
        }
      }
     }
     stage('Remove Container Image'){
        steps{
            sh 'docker rmi -f $(docker images -a -q)'
        }
     }

    }
    post {
        always{
            echo 'Slack Notifications.'
            slackSend channel: '#devopscicd',
            color:COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:*Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at :${env.BUILD_URL}"
        }
    }
}
