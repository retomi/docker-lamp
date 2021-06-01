# INSTALL Ubuntu
Intall docker on Ubuntu 20.04 server

```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install docker-ce
sudo apt install docker-compose
sudo usermod -aG docker $USER

mkdir data
sudo chmod o+w data
```

Enable shared folder
```bash
cd docker-lamp
./bin/start.sh
```
