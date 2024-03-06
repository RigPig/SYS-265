#secure-ssh.sh
#author Kevin
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#remoes root ability to ssh in
sudo useradd -m -d /home/$1 -s /bin/bash $1
sudo mkdir /home/$1/.ssh
sudo cp /SYS-265/linux/public-keys/id_rsa.pub /home/$1/.ssh/authorized_keys
sudo chmod 700 /home/$1/.ssh
sudo chmod 600 /home/$1/.ssh/authorized_keys 
sudo chown -R $1:$1 /home/$1/.ssh
sudo sed -i.bak -re 's/^(\#)(PermitRootLogin)([[:space:]]+)(.*)/\2\3\4/' /etc/ssh/sshd_config
sudo sed -i.bak -re 's/^(PermitRootLogin)([[:space:]]+)yes/\1\2no/' /etc/ssh/sshd_config

sudo sed -i.bak '/^#AuthorizedKeysFile/s/.*/AuthorizedKeysFile \/home\/'$1'\/.ssh\/authorized_keys/' /etc/ssh/sshd.config
