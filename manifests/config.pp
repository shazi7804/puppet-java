class java::config {
  file { '/tmp/test':
    ensure => file,
    owner  => root,
    group  => root,
  }
}