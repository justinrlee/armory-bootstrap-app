# Bootstrapping an application

This project can be used to bootstrap your application and
distributed as a Debian package.  The build file is based on [Gradle Linux Packaging
Plugin](https://github.com/nebula-plugins/gradle-ospackage-plugin), which includes support for building RPM packages too.

Included is a Jenkinsfile to push to bintray. Take a look at `./bin/push.sh` to set your repository.


### Notable files & directories

`./bin/build.sh` - The build script that will create the Debian package using `./gradlew`

`./bin/push.sh` - The script used to push to your artifact repository, includes an example to push to bintray and deb-s3.

`./build/distributions/` - Contains Debian that is ready for distribution or
installation. You'll want to want upload this to your central repository such as
Artifactory

`./build.gradle` - Describes how the Debian package will be created. Applications files will be copied as stated in `./build.gradle`.

`./deb-config/` - All the files and scripts that will be packaged up as part of
the Debian process

`./deb-config/scripts` - Post/Pre install/un-install scripts to further customize your Debian installation

There are many examples in the [Nebula Plugins](https://github.com/nebula-plugins/gradle-ospackage-plugin/wiki/Usage-Example) repository demonstrating how to extend this example.
