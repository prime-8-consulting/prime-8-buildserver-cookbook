# chef recipe to build dev environment vm
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
    owner 'prime8'
    group 'prime8'
    mode '0755'
  end
end
