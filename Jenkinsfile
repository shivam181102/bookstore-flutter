pipeline {
    agent any

    environment {
        FLUTTER_HOME = '/opt/flutter'
        PATH = "${FLUTTER_HOME}/bin:${env.PATH}"
    }

    stages {
    stage('Flutter Setup') {
        steps {
            sh '''
                if [ ! -d "$HOME/flutter" ]; then
                    git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
                fi
                export PATH="$HOME/flutter/bin:$PATH"
                flutter config --enable-web
                flutter --version
            '''
        }
    }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Flutter Setup') {
            steps {
                sh 'flutter --version'
                sh 'flutter config --enable-web'
                sh 'flutter doctor -v'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'flutter pub get'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'flutter test'
            }
        }

        stage('Build Web') {
            steps {
                sh 'flutter build web --release'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/web/**', fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Flutter web build succeeded!'
        }
        failure {
            echo 'Build failed. Check the logs above.'
        }
        always {
            cleanWs()
        }
    }
}