# java
[![Build Status](https://travis-ci.org/shazi7804/puppet-java.svg?branch=master)](https://travis-ci.org/shazi7804/puppet-java)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with java](#setup)
    * [Beginning with java](#beginning-with-java)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The java module installs, configures, and manages the java service across a range of operating systems and distributions.

## Setup

### Beginning with java

`include '::java'` is enough to get you up and running.

## Usage

All parameters for the ntp module are contained within the main `::java` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install and enable java

```puppet
include '::java'
```

### Configuring JDK version
support OpenJDK 7/8/9, OracleJDK 8/9 default version 1.8

```puppet
class { '::java':
  jdk_version => '8',
}
```


### Configuring JDK type (default OpenJDK)

```puppet
class { '::java':
  jdk_type => 'oraclejdk',
}
```

### Use Proxy (only Oracle JDK)

```puppet
class { '::java':
  jdk_type   => 'oraclejdk',
  http_proxy => 'http://proxy.com:3128',
}
```

## Reference

### Classes

#### Public classes

* java: Main class, includes all other classes.

#### Private classes

* java::install: Handles the packages.
* java::config: Handles the config.

## Limitations

This module cannot guarantee installation of Java versions that are not available on  platform repositories.

This module only manages a singular installation of Java, meaning it is not possible to manage e.g. OpenJDK 7 and Oracle Java 8 in parallel on the same system.

Oracle Java packages are not included in Debian 7 and Ubuntu 12.04/14.04 repositories. To install Java on those systems, you'll need to package Oracle JDK/JRE, and then the module can install the package. For more information on how to package Oracle JDK/JRE, see the [Debian wiki](http://wiki.debian.org/JavaPackage).

This module is officially [supported](https://forge.puppetlabs.com/supported) for the following Java versions and platforms:

OpenJDK is supported on:

* Red Hat Enterprise Linux (RHEL) 5, 6, 7
* CentOS 5, 6, 7
* Debian 6, 7
* Ubuntu 12.04, 14.04, 16.04

Sun Java is supported on:

* Debian 6

Oracle Java is supported on:

* CentOS 6

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)
