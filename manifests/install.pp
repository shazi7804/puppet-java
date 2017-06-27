class java::install inherits java {
  if $java::jdk_type == 'oraclejdk' {
    include java::install::oracle_jdk
  }
  elsif $java::jdk_type == 'openjdk' {
    include java::install::open_jdk
  }
  else {
    fail ("unsupported jdk type ${java::jdk_type}")
  }
}