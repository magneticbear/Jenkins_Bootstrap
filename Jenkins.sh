#!/bin/bash

echo "Installing Xcode Command Line Tools"
hdiutil mount -noverify xcode_cli.dmg
echo $1 | sudo -S installer -package "/Volumes/Command Line Tools (Mountain Lion)/Command Line Tools (Mountain Lion).mpkg" -target /
umount "/Volumes/Command Line Tools (Mountain Lion)"

echo "Installing Xcode 4.6"
hdiutil mount -noverify xcode.dmg
echo $1 | sudo -S cp -R "/Volumes/Xcode/Xcode.app" /Applications
umount "/Volumes/Xcode"

echo $1 | sudo -S /usr/sbin/DevToolsSecurity -enable
echo $1 | /usr/sbin/dseditgroup -o edit -t group -a staff _developer

expect "accept_xcode_license.exp" $1

echo "Installing Homebrew"
expect "accept_homebrew.exp" $1 "go.rb"

echo "Installing JDK"
hdiutil mount -noverify jdk-7u15-macosx-x64.dmg
echo $1 | sudo -S installer -package "/Volumes/JDK 7 Update 15/JDK 7 Update 15.pkg" -target /
umount "/Volumes/JDK 7 Update 15"
echo "finished installing the JDK"

echo "Installing git"
brew install git

echo "Installing Eclipse 4.2.1"

tar -zxvf eclipse-SDK-4.2.1-macosx-cocoa-x86_64.tar
mv Eclipse /Applications/Eclipse

echo "Installing oh my zsh"
echo $1 | sudo -S sh install.sh
echo $1 | sudo -S chsh -s /bin/zsh

echo "Downloading Latest Version of Jenkins"
cd ~/Downloads
curl -L -O http://mirrors.jenkins-ci.org/osx/latest
mv latest jenkins.pkg
echo "Installing Jenkins"
echo $1 | sudo -S  installer -pkg jenkins.pkg -target /

echo $1 | sudo -S gem update --system
echo "Installing cocoapods"
echo $1 | sudo -S gem install cocoapods
pod setup

echo "Downloading Jenkins CLI"
curl -L -O http://localhost:8080/jnlpJars/jenkins-cli.jar

echo "Installing node"
brew install node

echo "Installing Jenkins Plugins"
echo "Installing xcode Plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin https://updates.jenkins-ci.org/latest/xcode-plugin.hpi

echo "Installing git oauth plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/github-oauth.hpi

echo "Installing build timeout plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/build-timeout.hpi -restart