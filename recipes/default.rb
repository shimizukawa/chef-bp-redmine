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
include_recipe "rvm::gem_package"


#rvm_redmine_plugin "https://github.com/alminium/redmine_redcarpet_formatter.git" do
#  rvm_name     node.rvm_redmine.rvm_name
#  rvm_home     node.rvm_redmine.user_home
#  redmone_home "#{node.rvm_redmine.install_prefix}/#{node.rvm_redmine.name}"
#  user         node.rvm_redmine.user
#end

