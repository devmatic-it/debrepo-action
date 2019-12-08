# Container image that runs your code
FROM debian:stable-slim

RUN apt-get update -y -qq > /dev/null; apt-get install -y -qq --no-install-recommends git reprepro wget ca-certificates > /dev/null

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
