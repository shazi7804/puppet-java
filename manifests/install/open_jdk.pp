class java::install::open_jdk inherits java {
  case $facts['osfamily'] {
    'Debian': {
      include apt
      apt::ppa { 'ppa:openjdk-r/ppa':
        notify => Exec['apt_update'],
      }
      case $java::jdk_version {
        '7' : {
          $package_name = 'openjdk-7-jre'
          $java_home    = '/usr/lib/jvm/java-7-openjdk-amd64'
        }
        '8' : {
          $package_name = 'openjdk-8-jre'
          $java_home    = '/usr/lib/jvm/java-8-openjdk-amd64'
        }
        default : {
          fail ("unsupported platform openjdk 1.${java::jdk_version} version at ${facts['osfamily']}")
        }
      }
    }
    'Redhat': {
      case $java::jdk_version {
        '7' : {
          $package_name = 'java-1.7.0-openjdk'
          $java_home    = '/usr/lib/jvm/jre-1.7.0-openjdk.x86_64'
        }
        '8' : {
          $package_name = 'java-1.8.0-openjdk'
          $java_home    = '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64'
        }
        default : {
          fail ("unsupported platform openjdk 1.${java::jdk_version} version at ${$facts['osfamily']}")
        }
      }
    }
    default : {
      fail ("unsupported platform ${facts['osfamily']}")
    }
  }

  augeas { 'java-home-environment':
    lens    => 'Shellvars.lns',
    incl    => '/etc/environment',
    changes => "set JAVA_HOME ${java_home}",
  }

  package { $package_name:
    ensure => installed,
  }
}