# Jenkins BootStrap

## About

A shell script that creates an environment suitable for an OSX Jenkins Continuous Integration Server

## Features

* installs xcode and xcode CLI tools
* installs homebrew
* installs cocoapods
* installs git
* installs "oh my zsh" script
* installs eclipse
* installs node
* installs Jenkins with GithubOauth, Xcode, and build timeout plugins

## Requirements

* Xcode 4.6 dmg
* Xcode CLI tools dmg
* Eclipse tarball
* A java runtime environment installed and running

## Directions

1. ensure the needed files (xcode + eclipse) are in your downloads folder
2. run the script with your admin password as a parameter. Eg: sh Jenkins.sh <password>
3. Follow the instructions as they pop up. Everything is mostly automated, but the occasional command needs extra validation in the form of your password.

## License

Jenkins BootStrap for OSX is releaseder under the [MIT License](http://opensource.org/licenses/MIT).