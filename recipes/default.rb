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
include_recipe 'ruby_rbenv::ruby_build'
include_recipe 'ruby_rbenv::user'

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


# install a sensible ruby version with rbenv, which
# manages ruby envs for best control
# bash 'install ruby for jenkins' do
#   user 'jenkins'
#   code <<-EOH
#     git clone https://github.com/rbenv/rbenv.git /var/lib/jenkins/.rbenv
#     echo 'export PATH="/var/lib/jenkins/.rbenv/bin:/var/lib/jenkins/.rbenv/shims:$PATH"' >> /var/lib/jenkins/.bashrc
#     echo 'eval "$(rbenv init -)"' >> /var/lib/jenkins/.bashrc
#     source /var/lib/jenkins/.bashrc
#     git clone https://github.com/rbenv/ruby-build.git /var/lib/jenkins/.rbenv/plugins/ruby-build
#     rbenv install 2.3.1
#     rbenv global 2.3.1
#     gem install bundler
#     EOH
#   not_if { ::Dir.exists?("/var/lib/jenkins/.rbenv") }
# end

# set the global ruby, must source bashrc each time

# use bundler to install all the gems

# make known_hosts and add github
