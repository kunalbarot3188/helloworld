// Final successful file


def COLOR_MAP = [
    'FAILURE' : 'danger',
    'SUCCESS' : 'good'
]
pipeline{
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    stages {
        stage('clean workspace'){
            steps{
                cleanWs()
            }
        }
        stage('Checkout from Git'){
            steps{
                git branch: 'main', url: 'https://github.com/kunalbarot3188/helloworld.git'
            }
        }
        stage("Sonarqube Analysis "){
            steps{
                withSonarQubeEnv('sonar-server') {
                    sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=node \
                    -Dsonar.projectKey=node '''
                }
            }
        }
        stage("quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
                }
            } 
        }
        stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
        stage("Docker Build & Push"){
            steps{
                script{
                   withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
                       sh "docker build -t nodeapp ."
                       sh "docker tag nodeapp kunalbarot3188/nodejs-image:v1 "
                       sh "docker push kunalbarot3188/nodejs-image:v1 "
                    }
                }
            }
        }
        stage('Deploy to container'){
            steps{
                sh 'docker run -d --name nodeapp -p 3000:3000 kunalbarot3188/nodejs-image:v1'
            }
        }
        stage('Deploy to kubernets'){
            steps{
                withAWS(credentials: 'aws-key', region: 'us-east-1') {
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                    sh 'kubectl apply -f deployment.yml -n nodejs --validate=false'
                    }
                }
            }   
        }
    }
    }
}





// // kunalbarot3188 file

// def COLOR_MAP = [
//     'FAILURE' : 'danger',
//     'SUCCESS' : 'good'
// ]
// pipeline{
//     agent any
//     tools{
//         jdk 'jdk17'
//         nodejs 'node16'
//     }
//     environment {
//         SCANNER_HOME=tool 'sonar-scanner'
//     }
//     stages {
//         stage('clean workspace'){
//             steps{
//                 cleanWs()
//             }
//         }
//         stage('Checkout from Git'){
//             steps{
//                 git branch: 'main', url: 'https://github.com/kunalbarot3188/youtube-clone-app.git'
//             }
//         }
//         stage("Sonarqube Analysis "){
//             steps{
//                 withSonarQubeEnv('sonar-server') {
//                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=youtube \
//                     -Dsonar.projectKey=youtube '''
//                 }
//             }
//         }
//         stage("quality gate"){
//            steps {
//                 script {
//                     waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
//                 }
//             } 
//         }
//         stage('Install Dependencies') {
//             steps {
//                 sh "npm install"
//             }
//         }
//         stage('TRIVY FS SCAN') {
//             steps {
//                 sh "trivy fs . > trivyfs.txt"
//             }
//         }
//         stage("Docker Build & Push"){
//             steps{
//                 script{
//                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
//                        sh "docker build --build-arg REACT_APP_RAPID_API_KEY='e59f2e1d75msh17b80ac6e1413ebp1b9ad8jsn68ea7e015677' -t youtube-clone ."
//                        sh "docker tag youtube-clone kunalbarot3188/youtube-clone-app:v1 "
//                        sh "docker push kunalbarot3188/youtube-clone-app:v1 "
//                     }
//                 }
//             }
//         }
//         stage("TRIVY"){
//             steps{
//                 sh "trivy image kunalbarot3188/youtube-clone-app:v1 > trivyimage.txt" 
//             }
//         }
//         stage('Deploy to container'){
//             steps{
//                 sh 'docker run -d --name youtube-clone -p 3000:3000 kunalbarot3188/youtube-clone-app:v1'
//             }
//         }
//         stage('Deploy to kubernets'){
//             steps{
//                 withAWS(credentials: 'aws-key', region: 'us-east-1') {
//                 script{
//                     withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
//                     sh 'kubectl apply -f deployment.yml --validate=false'
//                     }
//                 }
//             }   
//         }
//     }
//     }
//     post {
//     always {
//         echo 'Slack Notifications'
//         slackSend (
//             channel: '#youtube-clone-app', 
//             color: COLOR_MAP[currentBuild.currentResult],
//             message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} \n build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
//         )
//     }
// }
// }



// // Original file

// def COLOR_MAP = [
//     'FAILURE' : 'danger',
//     'SUCCESS' : 'good'
// ]
// pipeline{
//     agent any
//     tools{
//         jdk 'jdk17'
//         nodejs 'node16'
//     }
//     environment {
//         SCANNER_HOME=tool 'sonar-scanner'
//     }
//     stages {
//         stage('clean workspace'){
//             steps{
//                 cleanWs()
//             }
//         }
//         stage('Checkout from Git'){
//             steps{
//                 git branch: 'main', url: 'https://github.com/kunalbarot3188/youtube-clone-app.git'
//             }
//         }
//         stage("Sonarqube Analysis "){
//             steps{
//                 withSonarQubeEnv('sonar-server') {
//                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=youtube \
//                     -Dsonar.projectKey=youtube '''
//                 }
//             }
//         }
//         stage("quality gate"){
//            steps {
//                 script {
//                     waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
//                 }
//             } 
//         }
//         stage('Install Dependencies') {
//             steps {
//                 sh "npm install"
//             }
//         }
//         stage('OWASP FS SCAN') {
//             steps {
//                 dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
//                 dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
//             }
//         }
//         stage('TRIVY FS SCAN') {
//             steps {
//                 sh "trivy fs . > trivyfs.txt"
//             }
//         }
//         stage("Docker Build & Push"){
//             steps{
//                 script{
//                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker'){   
//                        sh "docker build --build-arg REACT_APP_RAPID_API_KEY='e59f2e1d75msh17b80ac6e1413ebp1b9ad8jsn68ea7e015677' -t youtube-clone ."
//                        sh "docker tag youtube-clone kunalbarot3188/youtube-clone-app:v1 "
//                        sh "docker push kunalbarot3188/youtube-clone-app:v1 "
//                     }
//                 }
//             }
//         }
//         stage("TRIVY"){
//             steps{
//                 sh "trivy image kunalbarot3188/youtube-clone-app:v1 > trivyimage.txt" 
//             }
//         }
//         stage('Deploy to container'){
//             steps{
//                 sh 'docker run -d --name youtube1 -p 3000:3000 kunalbarot3188/youtube-clone-app:v1'
//             }
//         }
//         stage('Deploy to kubernets'){
//             steps{
//                 withAWS(credentials: 'aws-key', region: 'us-east-1') {
//                     script{
//                         withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
//                         sh 'kubectl apply -f deployment.yml'
//                         }
//                     }    
//                 }   
//             }
//         }
//     }
//     post {
//     always {
//         echo 'Slack Notifications'
//         slackSend (
//             channel: '#jenkins', 
//             color: COLOR_MAP[currentBuild.currentResult],
//             message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} \n build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
//         )
//     }
// }
// }

