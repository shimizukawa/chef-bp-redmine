#
# Cookbook Name:: bp-redmine
# Recipe:: default
#
# Copyright 2013, Takayuki SHIMIZUKAWA
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

include_recipe "rvm-redmine"
include_recipe "rvm-redmine::apache"

cookbook_file "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/config/environments/production.rb" do
  action :create
  source "environments/production.rb"
  mode "0664"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  notifies :restart, "service[redmine]"
end

cookbook_file "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/config/environments/development.rb" do
  action :create
  source "environments/development.rb"
  mode "0664"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  notifies :restart, "service[redmine]"
end

remote_directory "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/public/themes/custom_docutils_style" do
  source "custom_docutils_style"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  files_owner node.rvm_redmine.user
  files_group node.rvm_redmine.group
end
