#
# Cookbook:: cidare_sysadmins
# Recipe:: default
#
# Copyright:: 2020, CIDARE Ops
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

username = node['cidare_sysadmins']['default_user']
home_dir = ::File.join('/home', username)

user username do
  home home_dir
  shell '/bin/bash'
  manage_home true
  action :create
end

directory ::File.join(home_dir, '.ssh') do
  owner username
  group username
  action :create
  mode 0o700
end

template ::File.join(home_dir, '.ssh', 'authorized_keys') do
  source 'authorized_keys.erb'
  owner username
  group username
  mode 0o644
  action :create
end

sudo_conf_d = '/etc/sudoers.d'
file ::File.join(sudo_conf_d, username) do
  content "#{username} ALL=(ALL) NOPASSWD: ALL"
  owner 'root'
  group 'root'
  mode 0o440
  action :create
end
