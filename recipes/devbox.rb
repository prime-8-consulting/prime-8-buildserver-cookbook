# chef recipe to build dev environment vm
# build out the filesystem for storing our own
# data on the buildserver. There's repermissioning after
# write on some of the dirs.
cloud8_dirs = [
  '/home/prime8/.cloud8',
  '/home/prime8/.cloud8/creds',
  '/home/prime8/.cloud8/backups',
  '/home/prime8/.cloud8/terraform-tmp'
]

cloud8_dirs.each do |d|
  directory d do
    owner 'prime8'
    group 'prime8'
    mode '0755'
  end
end

# this the filesystem where we do
# development. It's set up semantically
# in the pattern of the metarepository
cloud8_devdirs = [
  '/home/prime8/prime-8-dev',
  '/home/prime8/prime-8-dev/dev',
  '/home/prime8/prime-8-dev/ops'
]

cloud8_devdirs.each do |d|
  directory d do
    owner 'prime8'
    group 'prime8'
    mode '0755'
  end
end
