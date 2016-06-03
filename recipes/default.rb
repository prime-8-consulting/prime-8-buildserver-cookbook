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
# Unle ss required by applicable law or agreed to in writing, software
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

jenkins_plugin 'simple-themes-plugin'
jenkins_plugin 'git'
jenkins_plugin 'thin-backup'

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

directory '/var/lib/jenkins/.cloud8/repos' do 
  owner 'jenkins'
  group 'jenkins'
  mode '0755'
end 

tiers = ['ops', 'dev', 'stage', 'rc', 'prod']

tiers.each do |t|
  directory "/var/lib/jenkins/.cloud8/repos/#{t}" do 
    owner 'jenkins'
    group 'jenkins'
    mode '0775'
  end
end


