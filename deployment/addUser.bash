#!/bin/bash -ueo
apt-get -y -qq update && apt-get -y -qq upgrade
apt-get install -y -qq sudo git curl vim wget htop openssh-server

user=pool
echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

adduser --group $user
adduser \
   --shell /bin/bash \
   --gecos 'User for managing pool' \
   --ingroup $user \
   --disabled-password \
   --home /home/$user \
   $user

usermod -aG sudo $user
groups $user

pushd /home/$user/
#increasing history
sed -i "s/HISTSIZE=1000/HISTSIZE=50000/g" .bashrc
sed -i "s/HISTFILESIZE=2000/HISTFILESIZE=50000/g" .bashrc

sed -i "s/HISTSIZE=1000/HISTSIZE=50000/g" /root/.bashrc
sed -i "s/HISTFILESIZE=2000/HISTFILESIZE=50000/g" /root/.bashrc

echo copy public ssh key from your pc to the server
echo ssh-copy-id -i ~/.ssh/id_rsa.pub $user@hostname