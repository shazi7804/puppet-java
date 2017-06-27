class java::install inherits java {
  if $jdk_type == 'oraclejdk' {
    include java::install::oracle_jdk
  }
  elsif $jdk_type == 'openjdk' {
    include java::install::open_jdk
  }
  else {
    fail ("unsupported jdk type ${jdk_type}")
  }
}