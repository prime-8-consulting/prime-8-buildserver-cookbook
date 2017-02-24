# Encoding: UTF-8
#

name             'prime-8-buildserver'
maintainer       'prime 8 consulting'
maintainer_email 'ellenm@prime8consulting.com'
license          'apache2'
description      'Installs/Configures prime-8-buildserver'
long_description 'Installs/Configures prime-8-buildserver'
version          '0.1.0'

supports 'rhel', '= 7.3'
supports 'ubuntu', '= 16.04'

depends 'jenkins'
depends 'sbp_packer'
depends 'terraform'
depends 'consul'
depends 'nodejs'
depends 'ruby_rbenv'
depends 'apt'
