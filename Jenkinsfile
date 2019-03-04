node{
    def repo_url = "410829681883.dkr.ecr.us-west-2.amazonaws.com/ecr_docker_repository"
    stage('SCM Checkout'){
    checkout(scm)
    }
    def mvnHome = tool name: 'M3', type: 'maven'
    stage('Test'){
         sh "${mvnHome}/bin/mvn test"
    }
    stage('Package'){
         sh "${mvnHome}/bin/mvn package"
    }
    stage('Build'){
    sh "\$(aws ecr get-login --no-include-email --region us-west-2)"
    sh "docker build -t docker-registry ."
    sh "docker tag docker-registry:latest {repo_url}:latest"
    sh "docker push {repo_url}:latest"
    }
}
