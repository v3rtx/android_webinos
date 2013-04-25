#
# Cookbook Name:: pzh-server
# Recipe:: default
#
# Copyright 2012, webinos
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

execute "install wget" do
  user "root"
  command "apt-get install wget"
end

directory "/opt/Webinos-Platform" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

execute "download android SDK" do
  cwd "/opt/Webinos-Platform"
  command "wget http://dl.google.com/android/adt/adt-bundle-linux-x86-20130219.zip"
  timeout 12000
  retries 3
end

execute "install unzip" do
  user "root"
  command "apt-get install unzip"
end

execute "download android SDK" do
  cwd "/opt/Webinos-Platform"
  command "unzip adt-bundle-linux-x86-20130219.zip"
end