# this represents the diff of the devbox and the buildserver
# for building any image, use the default in the runlist first.
# the intent is to have a devbox which is similarly configured
# to the buildserver but without jenkins installed
include_recipe 'jenkins::master'
include_recipe 'apt::cacher-ng'
include_recipe 'apt::cacher-client'

# build out the filesystem for storing our own
# data on the buildserver. There's repermissioning after
# write on some of the dirs.
cloud8_dirs = [
  '/var/lib/jenkins/.cloud8',
  '/var/lib/jenkins/.cloud8/creds',
  '/var/lib/jenkins/.cloud8/backups',
  '/var/lib/jenkins/.cloud8/terraform-tmp'
]

cloud8_dirs.each do |d|
  directory d do
    owner 'jenkins'
    group 'jenkins'
    mode '0755'
  end
end


file '/var/lib/jenkins/.bashrc' do
  content "export PATH=/usr/local/rbenv/bin:/usr/local/rbenv/versions/2.3.1/bin:$PATH"
  owner 'jenkins'
  group 'jenkins'
  mode '755'
end

jenkins_plugin 'thinBackup'
