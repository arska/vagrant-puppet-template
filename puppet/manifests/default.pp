Exec {
  path => '/usr/bin:/usr/sbin:/bin:/sbin',
}

File { 
  owner => 'root',
  group => $osfamily ? {
    /(Solar|Darwin|FreeBSD|OpenBSD)/ => 'wheel',
    default => 'root',
  },
}

hiera_include('classes')
