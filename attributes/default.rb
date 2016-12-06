default['packer']['version'] = '0.12.0'
default['packer']['url_base'] = "https://releases.hashicorp.com/packer/#{node['packer']['version']}"
default['packer']['raw_checksums']['version'] = <<-EOF
9fe5561a2be482989dd518d7e9616c2dcfe5111e749489ceadde5bbdf9e6b1b8  packer_0.12.0_darwin_386.zip
e3f25ad619f35e10a4195c971d78f29abceb16877bbf2bd75182140373d02bd3  packer_0.12.0_darwin_amd64.zip
f5cf377c17c2513622034d2e602d820f5fed31d807edf2c424f4891612579d0c  packer_0.12.0_darwin_arm.zip
58bd298378fe811f2fdb0eb71f8d509dc58f997da32c135a04574133b05ee009  packer_0.12.0_freebsd_386.zip
6b8a587e7f2a4a0dd26a7d523e474b0b30259b9683f2677cecec837eeab5ff0b  packer_0.12.0_freebsd_amd64.zip
5a2a90741725993751ca5da9dbf29898f2196d005852dc1da72985d3c48be77f  packer_0.12.0_freebsd_arm.zip
1b63006e1799f530755910d48b0858d80f3e6300b245511f1bc8a082108b92b3  packer_0.12.0_linux_386.zip
ce6362d527ba697e40b8c90a98d2034b7749e2357fa238b08536aed44f037073  packer_0.12.0_linux_amd64.zip
cd6482ad0b3c80d386989e73a7927248558fb627b53bbfd2f490d7a473a81d17  packer_0.12.0_linux_arm.zip
99fb287ce60ddd27bcdda11c87cceab3fcfc6921290bb2ee279bf3646df2f23f  packer_0.12.0_openbsd_386.zip
8a48bb7865b22a219c6d0085e20d170cb0f852580732bf45016da43be4fd8131  packer_0.12.0_openbsd_amd64.zip
1b346c6f381e21e92a589dfcc0eafc7c2b87f10cdfc524e3c7128dd0a64a9763  packer_0.12.0_windows_386.zip
4d1f9733b3cafc9e0ab2b1e9957dc2621a57f209a78d51ac5f5312cbcbb4e300  packer_0.12.0_windows_amd64.zip
EOF

node.default['packer']['checksums'] = Hash[
    node['packer']['raw_checksums']['version'].split("\n").collect { |s| s.split.reverse }
]
filename = "packer_#{node['packer']['version']}_#{node['os']}_#{node['packer']['arch']}.zip"
default['packer']['checksum'] = node['packer']['checksums'][filename]
default['packer']['zipfile'] = filename
# there's a goofy script workaround in packer for the bad deb package in jenkins
default['jenkins']['master']['repository'] = "http://pkg.jenkins-ci.org/debian-stable"
# using daften's branch we can do an automated setup of jenkins 2.0
# but first we have to disable the setup wizard. This isn't terribly dangerous
# since our buildserver is completely private
default['jenkins']['master']['jvm_options'] = '-Djenkins.install.runSetupWizard=false'
