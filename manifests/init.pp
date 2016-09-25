#
# = Class: postgrey
#
class postgrey (
  $options   = [ '--unix=/var/spool/postfix/postgrey/socket', '--delay=60' ],
  $whitelist = [],
) {

  File {
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Service['postgrey'],
  }

  package { 'postgrey':
    ensure  => present,
  }

  service { 'postgrey':
    ensure  => running,
    enable  => true,
    require => Package['postgrey'],
  }

  file { '/etc/sysconfig/postgrey':
    content => template('postgrey/postgrey.erb'),
  }

  file { '/etc/postfix/postgrey_whitelist_clients.local':
    content => template('postgrey/whitelist.erb'),
  }

}
