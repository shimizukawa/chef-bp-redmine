#
# Cookbook Name:: bp-redmine
# Recipe:: cron
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

remote_file "#{Chef::Config[:file_cache_path]}/lockrun.c" do
  source 'http://www.unixwiz.net/tools/lockrun.c'
  not_if "test -f #{node.bp_redmine.lockrun_path}"
end

execute "gcc lockrun.c -o lockrun" do
  cwd Chef::Config[:file_cache_path]
  not_if "test -f #{node.bp_redmine.lockrun_path}"
end

execute "cp lockrun /usr/local/bin/lockrun" do
  cwd Chef::Config[:file_cache_path]
  not_if "test -f #{node.bp_redmine.lockrun_path}"
end

file node['bp_redmine']['lockrun_path'] do
  mode '0755'
  owner 'root'
  group 'root'
end

cron "redmine_repository_fetch_changesets" do
  command "#{node.bp_redmine.lockrun_path} --lockfile=/var/run/fetch_changesets.lock -- bash -c 'source /usr/local/rvm/scripts/rvm && rvm use #{node.rvm_redmine.rvm_name} && ruby #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/script/runner Repository.fetch_changesets -e production >> #{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}/log/fetch_changesets.log 2>&1'"
  minute '*/10'
  user 'root'
end
