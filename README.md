# Jenkins BootStrap

## About

A shell script that creates an environment suitable for an OSX Jenkins Continuous Integration Server

## Features

* installs Java JDK 7
* installs xcode and xcode CLI tools
* installs homebrew
* installs cocoapods
* installs git
* installs "oh my zsh"
* installs eclipse
* installs node
* installs Jenkins with GithubOauth, Xcode, and build timeout plugins
* updates rubyGems to the latest possible version

## Requirements

* OSX Mountain Lion
* Xcode 4.6 dmg (named as xcode.dmg)
* Xcode CLI tools dmg (named as xcode_cli.dmg)
* Eclipse 4.2.1 tarball, 64-bit version
* Java JDK 7 Update 15
* An Active Internet Connection

## Directions

1. clone Jenkins_Bootstrap into a new repo.
2. Ensure Xcode, Xcode CLI, Eclipse Tarball, and Java JDK are in the same folder as Jenkins.sh
3. run the script with your admin password as a parameter. Eg: sh Jenkins.sh <password>
4. Sit back, grab yourself a coffee, and wait for everything to install

## License

Jenkins BootStrap for OSX is releaseder under the [MIT License](http://opensource.org/licenses/MIT).
