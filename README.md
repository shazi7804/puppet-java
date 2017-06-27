# java
[![Build Status](https://travis-ci.org/shazi7804/puppet-java.svg?branch=master)](https://travis-ci.org/shazi7804/puppet-java)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with java](#setup)
    * [What java affects](#what java-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with java](#beginning-with java)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
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
