#!/bin/bash
TIMEOUT_MINUTES='-30'

rc=$(sudo docker ps -q)
for container in $rc
do
  image=$(sudo docker inspect --format='{{'' .Config.Image}}' $container)
  # skip if ECS agent container
  if [[ "$image" == *"amazon/amazon-ecs-agent"* ]]
    then
      echo "Skipping ECS Agent"
    else
      # compare current datetime with container start time
      now=$(date +"%Y-%m-%dT%H:%M:%S."%s)
      rt=$(sudo docker inspect --format='{{'' .State.StartedAt}}' $container)
      nowf=$(date +%s -d $now)
      rtf=$(date +%s -d $rt)
      diff=$(( ($rtf - $nowf) / 60))
      if [[ $diff -le $TIMEOUT_MINUTES ]]
        then
          echo "Killing expired container: ($container) Running For: $diff minutes"
          sudo docker kill $container
        else
          echo "Container $container has been running for $diff minutes"
      fi
  fi
done
