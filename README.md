# java
[![Build Status](https://travis-ci.org/shazi7804/puppet-java.svg?branch=master)](https://travis-ci.org/shazi7804/puppet-java)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with java](#setup)
    * [Beginning with java](#beginning-with java)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Development - Guide for contributing to the module](#development)

## Description

The aws agent module installs, configures, and manages the java service across a range of operating systems and distributions.

## Setup

### Beginning with java

`include '::java'` is enough to get you up and running.

## Usage

All parameters for the ntp module are contained within the main `::java` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install and enable java

```puppet
include '::java'
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

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)
