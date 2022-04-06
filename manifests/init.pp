# Class: st
# ===========================
#
# Compile and install the st terminal emulator.
#
# Parameters
# ----------
#
# * `version`
# Specifies the version of `st` to be compiled.
# This is used by git to check out the desired
# reference prior to compilation. So, this value
# can be any valid git reference
# (e.g. tag, SHA, branch).
#
# Default: '0.6'
#
# * `prefix`
# The root location for the build artifacts to
# be installed.
#
# Default: '/usr/local'
#
# * `source_root`
# The root location for the st git repo to
# cloned into.
#
# Default: '/opt/puppet_staging/sources'
#
# * `git_manage`
# Should the module install git for you?
#
# Default: true
#
# * `dev_packages`
# List of required packages to perform compilation.
#
# Default: $st::params::dev_packages
#
#
# Examples
# --------
#
# @example
#    class { 'st':
#      version => '0.4.1',
#      prefix  => '/opt/mysoftware',
#    }
#
# Authors
# -------
#
# John Duarte <john@yeliad.us>
#
# Copyright
# ---------
#
# Copyright 2015 John Duarte, unless otherwise noted.
#
class st (
  $version = '0.6',
  $prefix = '/usr/local',
  $source_root = '/opt/puppet_staging/sources',
  $git_manage = true,
  $dev_packages = $st::params::dev_packages,
) inherits st::params {

  contain 'git'
  ensure_packages($dev_packages)

  # Pull down repo for st
  vcsrepo { 'st':
    ensure   => 'present',
    path     => "${source_root}/st",
    provider => 'git',
    source   => 'https://git.suckless.org/st',
    revision => $version,
    require  =>  Class['git'],
  }

  file { "${prefix}/share/st":
    ensure => absent,
    force  => true,
    before => Exec['install st'],
  }

  # TODO
  # apply solarized patches
  # https://st.suckless.org/patches/solarized/

  exec { 'install st':
    cwd         => "${source_root}/st",
    command     => '/usr/bin/make clean install',
    environment => "PREFIX=${prefix}",
    creates     => "${prefix}/bin/st",
    subscribe   => Vcsrepo['st'],
  }
}
