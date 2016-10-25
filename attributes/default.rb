default['packer']['version'] = '0.10.1'
default['packer']['url_base'] = "https://releases.hashicorp.com/packer/#{node['packer']['version']}"
default['packer']['raw_checksums']['version'] = <<-EOF
7974c24313230dfe6a13a81332c3a2f5119d4c589ca3b7ead6decf4895486c71  packer_0.10.1_darwin_386.zip
fac621bf1fb43f0cbbe52481c8dfda2948895ad52e022e46f00bc75c07a4f181  packer_0.10.1_darwin_amd64.zip
951012ddd2564cfe1cf901b8486a36896f89d4c4e75b3ed85d6f9b49c06ac14e  packer_0.10.1_freebsd_386.zip
170459ee7a1b2360f49a07ecffbadffe5407826f9514af10a25c3f19e1721e43  packer_0.10.1_freebsd_amd64.zip
3360dad292c16d2893f6138edd33d6f8eba00f1985330ad797f80670b3032e2e  packer_0.10.1_freebsd_arm.zip
9146b94115684a9725b2c1b5e5fbc412f30caaca136dbad4028423d6d6d3b6e4  packer_0.10.1_linux_386.zip
7d51fc5db19d02bbf32278a8116830fae33a3f9bd4440a58d23ad7c863e92e28  packer_0.10.1_linux_amd64.zip
1e110fb8ade48f959e426cf07603240fdc050d19ee8097e824459bf5e0638461  packer_0.10.1_linux_arm.zip
b5a25296056ac6511a370e7357b3723de313bfc8ffcb8bd850d6ba8d77b8493e  packer_0.10.1_openbsd_386.zip
255251a5dd93bba3c286b22b95ee9df63a1270c5c57c355263d0bebf692513da  packer_0.10.1_openbsd_amd64.zip
9c3c3483a8b6dd6d116747bfcccbf6f530ffab9bb46b47d9a49bdcb92c145914  packer_0.10.1_windows_386.zip
623013056dc662f29817dce6bd31e6fb669883a35ea9311951bbcea4eb9c59f7  packer_0.10.1_windows_amd64.zip
EOF

node.default['packer']['checksums'] = Hash[
    node['packer']['raw_checksums']['version'].split("\n").collect { |s| s.split.reverse }
]
filename = "packer_#{node['packer']['version']}_#{node['os']}_#{node['packer']['arch']}.zip"
default['packer']['checksum'] = node['packer']['checksums'][filename]
default['packer']['zipfile'] = filename
# there's a goofy script workaround in packer for the bad deb package in jenkins
default['jenkins']['master']['repository'] = "http://pkg.jenkins-ci.org/debian-stable"
default['ruby_rbenv']['user_installs'] = [
  { 'user' => 'jenkins',
    'rubies' => ['2.3.1'],
    'global' => '2.3.1',
    'gems' => {}
  }
]
