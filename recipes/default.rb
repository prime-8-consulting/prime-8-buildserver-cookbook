# Encoding: UTF-8
#
# Cookbook Name:: prime-8-buildserver
# Recipe:: default
#
# Copyright 2016 prime 8 consulting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


include_recipe 'sbp_packer'
include_recipe 'terraform'
include_recipe 'nodejs'
include_recipe 'consul'
include_recipe 'jenkins::master'
include_recipe 'mongodb3'
include_recipe 'apt::cacher-ng'
include_recipe 'apt::cacher-client'
include_recipe 'ruby_build'
include_recipe 'ruby_rbenv::system'

# ruby dependencies
package ['libssl-dev', 'libreadline-dev', 'zlib1g-dev']

# build out cloud8 filesystem
directory '/var/lib/jenkins/.cloud8' do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end

directory '/var/lib/jenkins/.cloud8/creds' do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end

directory '/var/lib/jenkins/.cloud8/backups' do
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end

# the rbenv cookbook was failing a user install for jenkins
# since jenkins was not at /home/jenkins TODO figure out how
# to set the user_installs home dir attribute for a more responsible
# install process, this is working all by path
rbenv_ruby "2.3.1"
rbenv_global "2.3.1"

gems = [
  'bundler',
  'thor',
  'highline',
  'rainbow',
  'aws-sdk',
  'inifile',
  'chef-berks',
  'ruby-graphviz',
  'mongo'
]

gems.each do |g|
  rbenv_gem g
end

file '/var/lib/jenkins/.bashrc' do
  content "export PATH=/usr/local/rbenv/bin:/usr/local/rbenv/versions/2.3.1/bin:$PATH"
  owner 'jenkins'
  group 'jenkins'
  mode '755'
end
