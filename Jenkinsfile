pipeline{
    agent any
    tools{
        maven 'maven'
        jdk 'JDK11'        
    }
    stages{
        stage('Code Compile'){
            steps{                
                sh """
                    echo "compile code"
                    mvn compile
                    echo "code compile complete"
                """                
                }
            }                    
        stage('Run Tests'){            
            steps{
                sh """
                    echo "test code"
                    mvn test
                    echo "tests complete"
                """                
            }
        }
        stage('Packaging'){
            steps{
                catchError (buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                sh """
                    echo "package code"
                    mvn clean package
                    echo "code packaging complete"
                """
                }
            }
        }
        stage('Build and Push Docker Image'){
            steps{
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'jenkins-dockerhub'){                            
                        def dockerImage = docker.build("htres736/spring-petclinic-capstone:${env.BUILD_ID}")
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy'){
            steps{
                sh 'docker run --name spring-petclinic -d -p 80:80 htres736/spring-petclinic-capstone:latest'
            }
        }
    }
    post{
        always{
            junit 'target/surefire-reports/**/*.xml'
        }
    }
}