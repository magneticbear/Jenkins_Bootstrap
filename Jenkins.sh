#!/bin/bash

# Xcode

echo "Installing Xcode Command Line Tools"
hdiutil mount -noverify xcode_cli.dmg
echo $1 | sudo -S installer -package "/Volumes/Command Line Tools (Mountain Lion)/Command Line Tools (Mountain Lion).mpkg" -target /
umount "/Volumes/Command Line Tools (Mountain Lion)"

echo "Installing Xcode"
hdiutil mount -noverify xcode.dmg
echo $1 | sudo -S cp -R "/Volumes/Xcode/Xcode.app" /Applications
umount "/Volumes/Xcode"

echo "Enabling Mac Developer Mode"
echo $1 | sudo -S /usr/sbin/DevToolsSecurity -enable
echo $1 | /usr/sbin/dseditgroup -o edit -t group -a staff _developer

expect "accept_xcode_license.exp" $1

# Homebrew, git, cocoapods, node

echo "Installing Homebrew"
curl -O https://raw.github.com/mxcl/homebrew/go
expect "accept_homebrew.exp" $1 "go"

echo "Installing git"
brew install git

echo $1 | sudo -S gem update --system
echo "Installing cocoapods"
echo $1 | sudo -S gem install cocoapods
pod setup

echo "Installing node"
brew install node

# Eclipse

echo "Installing Eclipse"
tar -zxf eclipse.tar
mv Eclipse /Applications/Eclipse

# Java

echo "Installing JDK"
hdiutil mount -noverify jdk.dmg
echo $1 | sudo -S installer -package "/Volumes/JDK 7 Update 15/JDK 7 Update 15.pkg" -target /
umount "/Volumes/JDK 7 Update 15"

echo "Installing Java 6"
hdiutil mount -noverify jre6.dmg
echo $1 | sudo -S installer -package "/Volumes/Java for OS X 2013-001/JavaForOSX.pkg" -target /
umount "/Volumes/Java for OS X 2013-001"

echo "Installing Java 7"
hdiutil mount -noverify jre7.dmg
echo $1 | sudo -S installer -package "/Volumes/Java 7 Update 15/Java 7 Update 15.pkg" -target /
umount "/Volumes/Java 7 Update 15"

# Jenkins + Tools

echo "Downloading Latest Version of Jenkins"
cd ~/Downloads
curl -L -o jenkins.pkg http://mirrors.jenkins-ci.org/osx/latest
echo "Installing Jenkins"
echo $1 | sudo -S  installer -pkg jenkins.pkg -target /

echo "Downloading Jenkins CLI"
curl -L -O http://localhost:8080/jnlpJars/jenkins-cli.jar

echo "Installing Jenkins Plugins"
echo "Installing xcode Plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin https://updates.jenkins-ci.org/latest/xcode-plugin.hpi

echo "Installing git oauth plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/github-oauth.hpi

echo "Installing build timeout plugin"
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin http://updates.jenkins-ci.org/latest/build-timeout.hpi -restart