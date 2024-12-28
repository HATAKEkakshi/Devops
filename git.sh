echo "################################################################"
echo "Starting Git Push Script"
echo "################################################################"
echo "Entering Ansible Branch"
git checkout Ansible
git add .
git commit -m "Done"
git push origin Ansible
echo "################################################################"
echo "Entering Linux Branch"
git checkout Linux
git add .
git commit -m "Done"
git push origin Linux
echo "################################################################"
echo "Entering Vagrant Branch"
git checkout vagrant
git add .
git commit -m "Done"
git push origin vagrant
echo "################################################################"
echo "Entering Terraform Branch"
git checkout Terraform
git add .
git commit -m "Done"
git push origin Terraform
echo "################################################################"
echo "Entering Docker Branch"
git checkout Docker
git add .
git commit -m "Done"
git push origin Docker
echo "################################################################"
echo "Entering Git Branch"
git checkout git
git add .
git commit -m "Done"
git push origin git
echo "################################################################"
echo "Entering Python Branch"
git checkout python
git add .
git commit -m "Done"
git push origin python
echo "################################################################"
echo "Entering Bashscripts Branch"
git checkout Bashscripts
git add .
git commit -m "Done"
git push origin Bashscripts
echo "################################################################"
echo "Entering Jenkins Branch"
git checkout Jenkins
git add .
git commit -m "Done"
git push origin Jenkins
echo "################################################################"
echo "Entering maven Branch"
git checkout maven
git add .
git commit -m "Done"
git push origin maven
echo "################################################################"
