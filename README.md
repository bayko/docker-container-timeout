# docker-container-timeout

This script will forcibly terminate any long-running docker containers on a host which have exceeded a pre-defined time limit.

- Execute on your docker host or an ECS container instance
- Schedule as a cron job to cleanup containers or tasks which have hung
- ECS agent containers are excluded automatically
