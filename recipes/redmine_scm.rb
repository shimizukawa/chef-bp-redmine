#
# Cookbook Name:: bp-redmine
# Recipe:: redmine_scm
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

node.bp_redmine.scm.each do |scm, values|
  directory values['repos_path'] do
    owner node.rvm_redmine.user
    group node.rvm_redmine.group
    mode '0755'
    recursive true
  end
end

template "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/config/scm.yml" do
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  mode "0644"
  variables(node.bp_redmine.scm)
  notifies :restart, resources(:service => "redmine")
end

remote_file "#{Chef::Config[:file_cache_path]}/redmine_scm-0.4.2.tar.bz2" do
  source 'http://projects.andriylesyuk.com/attachments/download/388/redmine_scm-0.4.2.tar.bz2'
  not_if "test -d #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins/redmine_scm"
end

execute "tar jxf redmine_scm-0.4.2.tar.bz2" do
  cwd Chef::Config[:file_cache_path]
  not_if "test -d #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins/redmine_scm"
end

bash "install redmine_scm to plugins" do
  code "cp -R #{Chef::Config[:file_cache_path]}/redmine_scm #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins"
  not_if "test -d #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins/redmine_scm"
  notifies :run,     resources(:rvm_shell => "rvm_redmine db:migrate_plugins"), :immediately
  notifies :restart, resources(:service => "redmine")
end

