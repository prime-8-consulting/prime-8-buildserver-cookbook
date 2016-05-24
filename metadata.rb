# Encoding: UTF-8
#

name             'prime-8-buildserver'
maintainer       'prime 8 consulting'
maintainer_email 'ellenm@prime8consulting.com'
license          'apache2'
description      'Installs/Configures prime-8-buildserver'
long_description 'Installs/Configures prime-8-buildserver'
version          '0.0.2'

depends 'jenkins'
depends 'sbp_packer'
depends 'terraform'
depends 'consul'
depends 'nodejs'
