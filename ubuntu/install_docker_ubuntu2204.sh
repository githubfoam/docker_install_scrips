#!/bin/bash

#https://docs.docker.com/engine/install/ubuntu/
#Uninstall old versions
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

#Set up the repository
sudo apt-get update <F4>y
sudo apt-get install ca-certificates curl gnupg -y

#Add Docker’s official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#set up the repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Install Docker Engine, containerd, and Docker Compose
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#Verify that the Docker Engine installation is successful by running the hello-world image
sudo docker run hello-world

# Check if the docker group exists
if grep -q "^docker:" /etc/group; then
    echo "Docker group already exists."
else
    echo "Creating docker group..."
    sudo groupadd docker
fi

# Add the current user to the docker group
sudo usermod -aG docker $USER

echo "User $USER has been added to the docker group."
echo "Please log out and log back in for the changes to take effect."