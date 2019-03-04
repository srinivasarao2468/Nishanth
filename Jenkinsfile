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
    sh "docker build -t ecr_docker_repository ."
    sh "docker tag ecr_docker_repository:latest ${repo_url}:latest"
    sh "docker push ${repo_url}:latest"
    }

    stage('deploy'){
    sh "chmod 700 td-tomcat.template"
    sh "chmod 700 service-update-tomcat.json"
    sh "chmod 700 service-create-tomcat.json"
    sh "chmod 700 deploy.sh"
    sh "./deploy.sh CONTAINER_VERSION=${repo_url}:latest create"
    //sh "./deploy.sh CONTAINER_VERSION=${repo_url}:latest create"
    }
}
