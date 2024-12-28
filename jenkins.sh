echo "#################################################################"
echo "Installing Openjdk 21"
echo "#################################################################"
apt update

apt install openjdk-21-jdk -y
echo "#################################################################"
echo "Jdk Installation is done"
echo "#################################################################"

echo "#################################################################"
echo "Installing Jenkins"
echo "#################################################################"



sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key



echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
	https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
	/etc/apt/sources.list.d/jenkins.list > /dev/null



sudo apt-get update



sudo apt-get install jenkins

echo "#################################################################"
echo "Jenkins Installation is Done ..."
echo "#################################################################"


