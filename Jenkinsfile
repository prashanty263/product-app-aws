pipeline {
    agent any

    environment {
        DOTNET_CLI_TELEMETRY_OPTOUT = '1'
        DOTNET_SKIP_FIRST_TIME_EXPERIENCE = '1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/prashanty263/product-app-aws.git'
            }
        }

        stage('Restore') {
            steps {
                bat 'dotnet restore'   // Windows
                // sh 'dotnet restore' // Linux
            }
        }

        stage('Build') {
            steps {
                bat 'dotnet build --configuration Release'
                // sh 'dotnet build --configuration Release'
            }
        }

        stage('Test') {
            steps {
                bat 'dotnet test --no-build'
                // sh 'dotnet test --no-build'
            }
        }

        stage('Publish') {
            steps {
                bat 'dotnet publish -c Release -o publish'
                // sh 'dotnet publish -c Release -o publish'
            }
        }
    }

    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
