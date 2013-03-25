#
# Cookbook Name:: bp-redmine
# Recipe:: restructuredtext
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

include_recipe "bp-redmine"
include_recipe "python"      #need for reST
include_recipe "rvm::gem_package"


#for redmine_restructuredtext_formatter.
#That plugin have Gemfiles and contain requirement "gem 'RbST'"
#but that not have version specification.
#It cause 'bundler install' (version 1.2.1) taking long hours to
#construct index.
#details are:
# * http://stackoverflow.com/questions/6368505/bundle-update-stuck-at-fetching-source-index-for-http-rubygems-org
# * http://robots.thoughtbot.com/post/2729333530/fetching-source-index-for-http-rubygems-org
rvm_gem 'RbST' do
  ruby_string node.rvm_redmine.rvm_name
  version '0.1.3'
end

rvm_redmine_plugin "https://github.com/alminium/redmine_restructuredtext_formatter.git" do
  rvm_name     node.rvm_redmine.rvm_name
  redmine_home "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}"
  user         node.rvm_redmine.user
end

python_virtualenv "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/venv" do
  interpreter "python2.7"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  action :create
end

remote_directory "#{Chef::Config[:file_cache_path]}/blockdiag_redmine_support"
remote_directory "#{Chef::Config[:file_cache_path]}/rst2parts_ext"

python_pip "#{Chef::Config[:file_cache_path]}/blockdiag_redmine_support" do
  user node.rvm_redmine.user
  group node.rvm_redmine.group
  virtualenv "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/venv"
end

python_pip "#{Chef::Config[:file_cache_path]}/rst2parts_ext" do
  user node.rvm_redmine.user
  group node.rvm_redmine.group
  virtualenv "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/venv"
end

remote_directory "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins/redmine_restructuredtext_formatter/lib/rst2parts" do
  source "rst2parts"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  files_owner node.rvm_redmine.user
  files_group node.rvm_redmine.group
end

template "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/vendor/plugins/redmine_restructuredtext_formatter/lib/rbst.rb" do
  source "rbst.rb.erb"
  mode "0644"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  variables({
    :python_interpreter => "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/venv/bin/python",
  })
end

cookbook_file "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/config/initializers/99-wiki-cache-patches.rb" do
  action :create
  mode "0664"
  owner node.rvm_redmine.user
  group node.rvm_redmine.group
  notifies :restart, "service[redmine]"
end
