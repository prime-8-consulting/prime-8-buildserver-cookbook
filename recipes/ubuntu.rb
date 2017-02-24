# this represents the diff of the devbox and the buildserver
# for building any image, use the default in the runlist first.
# the intent is to have a devbox which is similarly configured
# to the buildserver but without jenkins installed

include_recipe 'apt::cacher-ng'
include_recipe 'apt::cacher-client'
