#!/bin/zsh

# use sudo to check processes not owned by the current user
port_process() {
    if [ "$(which lsof)" ]; then
        lsof -i TCP:"$1" | grep LISTEN
    else
        netstat -aon | grep "LISTENING" | grep ":$1"
    fi
}

http(){
    curl "http://httpcode.info/$1";
}

connect_prod_db_func() {
  aws sso login --profile claimable-prod

  if [ $? -eq 0 ]; then
    aws ssm start-session \
      --target $(aws ec2 describe-instances --filters 'Name=tag:Name,Values=SSM Access to RDS' 'Name=instance-state-name,Values=running' --query 'Reservations[0].Instances[0].InstanceId' --output text --profile claimable-prod) \
      --document-name AWS-StartPortForwardingSessionToRemoteHost \
      --parameters '{"host":["apistack-auroraserverlessv2cluster9dd8efb9-pl02mdrqfci4.cluster-ce8ovqj8uhpe.us-east-1.rds.amazonaws.com"],"portNumber":["5432"], "localPortNumber":["5435"]}' \
      --profile claimable-prod
  else
    echo "SSO login failed. Please try again."
  fi
}

alias connect-prod-db='connect_prod_db_func'


connect_dev_db_func() {
  aws sso login --profile claimable

  if [ $? -eq 0 ]; then
    aws ssm start-session \
      --target $(aws ec2 describe-instances --filters 'Name=tag:Name,Values=SSM Access to RDS' 'Name=instance-state-name,Values=running' --query 'Reservations[0].Instances[0].InstanceId' --output text --profile claimable) \
      --document-name AWS-StartPortForwardingSessionToRemoteHost \
      --parameters '{"host":["apistack-auroraserverlessv2cluster9dd8efb9-rbup6h3kpn4o.cluster-czotrhfoq78d.us-east-1.rds.amazonaws.com"],"portNumber":["5432"], "localPortNumber":["5434"]}' \
      --profile claimable
  else
    echo "SSO login failed. Please try again."
  fi
}

alias connect-dev-db='connect_dev_db_func'
