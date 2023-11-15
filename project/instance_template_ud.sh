#!/bin/bash
custom_user_1="${custom_user_1}"
default_user_1="${default_user_1}"
jenkins_image="${jenkins_image}"
hostname_1="${hostname_1}"
by_user="sudo -u $custom_user_1"

usermod -l $custom_user_1 -m -d /home/$custom_user_1 $default_user_1 && \
logpath="/home/$custom_user_1/userdata.log"
echo "\
1. custom user created" >> $logpath && \

groupmod -n $custom_user_1 $default_user_1
echo "\
2. custom user group renamed" >> $logpath && \

passwd -d $custom_user_1 && \
echo "\
3. user password disabled" >> $logpath && \

groupadd wheel && \
echo "\
4. wheel group created" >> $logpath && \

apt update && \
echo "\
5. repo updated" >> $logpath && \

apt upgrade -y && \
echo "\
6. repo upgraded" >> $logpath && \

apt install -y docker.io micro docker-compose && \
echo "\
7. docker installed" >> $logpath && \

usermod -aG wheel,sudo,docker $custom_user_1 && \
echo "\
8. user added to groups" >> $logpath && \

docker network create jenkins-network && \
echo "\
9. docker network created" >> $logpath && \

$by_user docker run -d \
  --restart=always \
  -p 8080:8080 \
  --name jenkins \
  --network jenkins-network \
  -v jenkins_home:/var/jenkins_home \
  -e TZ=Asia/Yerevan \
  $jenkins_image && \

echo "\
10. Jenkins configuration save script is created" >> $logpath && \

hostnamectl set-hostname $hostname_1
