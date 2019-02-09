node{
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
    sh "eval $(aws ecr get-login --no-include-email --region us-west-2)"
    sh "docker build -t docker-registry ."
    sh "docker tag docker-registry:latest 410829681883.dkr.ecr.us-west-2.amazonaws.com/docker-registry:latest"
    sh "docker push 410829681883.dkr.ecr.us-west-2.amazonaws.com/docker-registry:latest"
    }
}
