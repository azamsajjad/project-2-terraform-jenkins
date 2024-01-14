#! /bin/bash
cd /home/ubuntu
yes | sudo apt update
yes | sudo apt install python3 python3-pip
git clone https://github.com/azamsajjad/project-2-terraform-jenkins.git
sleep 20
cd project-2-terraform-jenkins
cd 3-python-mysql-setup
pip3 install -r requirements.txt
echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30