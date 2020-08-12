FROM vhmdevelopment/postman:v0.01

ENV DEBIAN_FRONTEND noninteractive

# Install curl and nodjs, npm is part of node
RUN apt-get update && apt-get install -y curl apt-transport-https debconf-utils; \
  apt-get --assume-yes install --no-install-recommends apt-utils; \
  apt-get --assume-yes install libssl-dev; \
  apt-get --assume-yes install build-essential; \
  apt-get --assume-yes install wget; \
  apt-get --assume-yes install curl; \
  wget https://deb.nodesource.com/setup_8.x; \
  /bin/bash setup_8.x; \
  apt-get --assume-yes install nodejs;

RUN echo "integration testing, repository_url: ${repository_url}"
# Set newman version
ENV NEWMAN_VERSION 4.5.2
RUN npm install -g newman@${NEWMAN_VERSION};


# Set workdir to /etc/newman

# In case you mount your collections directory to a different location, you will need to give absolute paths to any
# collection, environment files you want to pass to newman, and if you want newman reports to be saved to your disk.
# Or you can change the workdir by using the -w or --workdir flag

WORKDIR /etc/newman

COPY verity.postman_collection.json /etc/newman
COPY Verity.postman_environment.json /etc/newman
COPY entrypoint.sh /etc/newman
RUN chmod +x /etc/newman/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]


