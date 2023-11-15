#!/bin/bash
custom_user_2="${custom_user_2}"
default_user_2="${default_user_2}"
hostname_2="${hostname_2}"
by_user="sudo -u $custom_user_2"

usermod -l $custom_user_2 -m -d /home/$custom_user_2 $default_user_2 && \
logpath="/home/$custom_user_2/userdata.log"
echo "\
1. custom user created" >> $logpath && \

passwd -d $custom_user_2 && \
echo "\
2. user password disabled" >> $logpath && \

groupadd wheel && \
echo "\
3. wheel group created" >> $logpath && \

# useradd -d /var/lib/jenkins jenkins
# mkdir /var/lib/jenkins/.ssh
# touch /var/lib/jenkins/.ssh/authorized_keys

# chown -R jenkins /var/lib/jenkins/.ssh
# chmod 600 /var/lib/jenkins/.ssh/authorized_keys
# chmod 700 /var/lib/jenkins/.ssh

chown -R $custom_user_2 /home/$custom_user_2/userdata.log

chown -R $custom_user_2:$custom_user_2 /home/$custom_user_2/.ssh
$by_user chmod 600 /home/$custom_user_2/.ssh/authorized_keys
by_user chmod 700 /home/$custom_user_2/.ssh

apt update && \
echo "\
4. repo updated" >> $logpath && \

apt upgrade -y && \
echo "\
5. repo upgraded" >> $logpath && \

apt install -y docker.io docker-compose micro fontconfig openjdk-17-jre openjdk-11-jre && \
echo "\
6. Install \
    fontconfig \
    docker.io \
    docker-compose \
    micro \
    fontconfig \
    openjdk-17-jre \
    openjdk-11-jre" >> $logpath && \

usermod -aG wheel,sudo,docker $custom_user_2 && \
echo "\
7. user added to groups" >> $logpath && \

hostnamectl set-hostname $hostname_2

