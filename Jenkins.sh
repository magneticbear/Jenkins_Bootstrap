#!/bin/bash
 cd ~/downloads
hdiutil mount -noverify xcode_cli.dmg
echo "Installing Xcode Command Line Tools"
echo $1 | sudo -S installer -verbose -package "/Volumes/Command Line Tools (Mountain Lion)/Command Line Tools (Mountain Lion).mpkg" -target /
umount "/Volumes/Command Line Tools (Mountain Lion)"
echo "Finished installing Xcode Command Line Tools"
 cd ~/downloads
hdiutil mount -noverify xcode.dmg
echo "Installing Xcode 4.6"
echo $1 | sudo -S cp -R "/Volumes/Xcode/Xcode.app" /Applications
umount "/Volumes/Xcode"
echo "Finished installing Xcode 4.6"
 
echo $1 | sudo -S /usr/sbin/DevToolsSecurity -enable
echo $1 | /usr/sbin/dseditgroup -o edit -t group -a staff _developer
 
expect "accept_xcode_license.exp"
 
echo "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
echo -ne "\n"
echo $1
 
echo "Installing git"
brew install git
 
echo "Installing cocoapods"
gem install cocoapods
 
 
echo "Installing oh my zsh"
echo $1 | sudo -S curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
 
echo "Installing Eclipse 4.2.1"
cd ~/Downloads
tar -zxvf eclipse-SDK-4.2.1-macosx-cocoa-x86_64.tar
mv Eclipse /Applications/Eclipse
 
echo "Installing node"
brew install node 
 
echo "Installing JRE 7"
cd ~/downloads
hdiutil mount -noverify jre-7u13-macosx-x64.dmg
echo $1 | sudo -S installer -verbose -package "/Volumes/Java 7 Update 13/Java 7 update 13.pkg" -target /
umount "/Volumes/Java 7 Update 13"
 
 
echo "Downloading Latest Version of Jenkins"
cd ~/Downloads
curl -L -O http://mirrors.jenkins-ci.org/osx/latest jenkins.pkg
mv latest jenkins.pkg
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