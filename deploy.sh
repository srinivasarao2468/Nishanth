#!/bin/sh -e

#Usage: CONTAINER_VERSION=docker_container_version [create|update]

# register task-definition
sed <td-tomcat.template -e "s,@VERSION@,$CONTAINER_VERSION,g">TASKDEF.json
aws ecs register-task-definition --region us-west-2 --cli-input-json file://TASKDEF.json > REGISTERED_TASKDEF.json
TASKDEFINITION_ARN=$( < REGISTERED_TASKDEF.json jq .taskDefinition.taskDefinitionArn )

# create or update service
sed "s,@@TASKDEFINITION_ARN@@,$TASKDEFINITION_ARN," <service-create-tomcat.json >SERVICEDEF.json
aws ecs create-service --cli-input-json file://SERVICEDEF.json | tee SERVICE.json
