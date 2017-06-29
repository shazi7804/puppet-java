class java::install::oracle_jdk inherits java {
  case $facts['os']['family'] {
    'Debian': {
      case $java::jdk_version {
        '7' : {
          $package_name = 'oracle-java7-installer'
          $java_home    = '/usr/lib/jvm/java-7-oracle'
        }
        '8' : {
          $package_name = 'oracle-java8-installer'
          $java_home    = '/usr/lib/jvm/java-8-oracle'
        }
        default : {
          fail ("unsupported platform oracle_jdk 1.${java::jdk_version} version at ${$facts['osfamily']}")
        }
      }

      include apt
      apt::ppa { $java::oracle_ppa:
        notify => Exec['apt_update']
      }
      -> Exec {
        'set-licence-selected':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
          unless  => "/usr/bin/dpkg -l | grep ${package_name}";
        'set-licence-seen':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections',
          unless  => "/usr/bin/dpkg -l | grep ${package_name}";
      }
      -> Package { $package_name:
        ensure  => present,
      }
    }
    'Redhat': {
      case $java::jdk_version {
        '8' : {
          $oraclejdk_download_url = 'http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163'
          $package_name = 'jdk1.8.0_131'
          $package_rpm  = 'jdk-8u131-linux-x64.rpm'
          $java_home    = '/usr/java/default'
        }
        default : {
          fail ("unsupported platform oracle_jdk 1.${java::jdk_version} version at ${$facts['os']['family']}")
        }
      }

      if $java::http_proxy {
        exec { 'download_oraclejdk':
          command => "/usr/bin/curl -x ${java::http_proxy} -L -H '${java::oraclejdk_verify_cookie}' --connect-timeout ${java::proxy_download_timeout} -o ${java::oraclejdk_rpm} -O ${oraclejdk_download_url}/${package_rpm}",
          unless  => "/bin/rpm -qa | grep ${package_name}",
          notify  => Exec['install_oraclejdk'],
        }
      }
      else {
        exec { 'download_oraclejdk':
          command => "/usr/bin/curl -L -H '${java::oraclejdk_verify_cookie}' -o ${java::oraclejdk_rpm} --connect-timeout ${java::proxy_download_timeout} -O ${oraclejdk_download_url}/${package_rpm}",
          unless  => "/bin/rpm -qa | grep ${package_name}",
          notify  => Exec['install_oraclejdk'],
        }
      }

      exec { 'install_oraclejdk':
        command     => "/bin/rpm -ivh ${java::oraclejdk_rpm}",
        subscribe   => Exec['download_oraclejdk'],
        refreshonly => true
      }

    }
    default : {
      fail ("unsupported platform ${$facts['osfamily']}")
    }
  }

  augeas { 'java-home-environment':
    lens    => 'Shellvars.lns',
    incl    => '/etc/environment',
    changes => "set JAVA_HOME ${java_home}",
  }
}


