# Class: postgrey
#
class postgrey (
  $options = [ '--unix=/var/spool/postfix/postgrey/socket', '--delay=60' ],
) {
  package { 'postgrey':
    ensure  => present,
  }

  service { 'postgrey':
    ensure  => running,
    enable  => true,
    require => Package['postgrey'],
  }

  file { '/etc/sysconfig/postgrey':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('postgrey/postgrey.erb'),
    notify  => Service['postgrey'],
  }
}
