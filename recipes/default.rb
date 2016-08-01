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
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

# ruby dependencies
package ['libssl-dev', 'libreadline-dev', 'zlib1g-dev', 'ruby-bundler']

# we're installing mongo3 with scripts because
# the cookbook doesn't yet support ubuntu 16.04
directory '/data' do
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/data/db' do
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file '/home/ubuntu/mongo3install.sh' do
  source 'mongo3install.sh'
  owner 'root'
  group 'root'
  mode '755'
end

# systemd is ubuntu's new init system, and the cause
# of our grief with the cookbooks. We'll drop our own config
cookbook_file '/etc/systemd/system/mongodb.service' do
  source 'mongodb.service'
  owner 'root'
  group 'root'
  mode '755'
end

bash 'install mongodb3' do
  cwd '/home/ubuntu'
  code 'bash mongo3install.sh'
end

bash 'enable mongo in systemd' do
  user 'root'
  group 'root'
  code 'systemctl enable mongodb'
end

# support for plugins with jenkins 2.0 is pending in the
# issues page of this cookbook on github
# jenkins_plugin 'simple-theme-plugin'
# jenkins_plugin 'git'
# jenkins_plugin 'thinBackup'
# jenkins_plugin 'parameterized-trigger'

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


# install a sensible ruby version with rbenv, which
# manages ruby envs for best control

rbenv_ruby '2.3.1'
rbenv_gem 'bundler' do
  ruby_version '2.3.1'
end
