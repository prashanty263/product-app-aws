pipeline {
    agent any

    environment {
        IIS_SITE = "DotNetApp"
        DEPLOY_PATH = "C:\\inetpub\\DotNetApp"
    }

    stages {

        stage('Checkout') {
            steps {
                git url: 'https://github.com/prashanty263/product-app-aws.git', branch: 'main'
            }
        }

        stage('Restore') {
            steps {
                bat 'dotnet restore'
            }
        }

        stage('Build') {
            steps {
                bat 'dotnet build -c Release'
            }
        }

        stage('Publish') {
            steps {
                bat 'dotnet publish -c Release -o publish'
            }
        }

        stage('Deploy to IIS') {
            steps {
                bat """
                powershell -Command "
                Import-Module WebAdministration;
                Stop-WebSite '${IIS_SITE}';
                Remove-Item '${DEPLOY_PATH}\\*' -Recurse -Force;
                Copy-Item 'publish\\*' '${DEPLOY_PATH}' -Recurse;
                Start-WebSite '${IIS_SITE}'
                "
                """
            }
        }
    }

    post {
        success {
            echo 'Deployment to IIS successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
