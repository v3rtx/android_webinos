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

execute "install curl" do
  user "root"
  command "apt-get install -y curl"
end

directory "/opt/Webinos-Platform" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

execute "download android SDK" do
  cwd "/opt/Webinos-Platform"
  command "curl -o android_sdk.zip http://dl.google.com/android/adt/adt-bundle-linux-x86-20130219.zip"
  timeout 12000
  retries 3
end

execute "install unzip" do
  user "root"
  command "apt-get install -y unzip"
end

execute "unpack android SDK" do
  cwd "/opt/Webinos-Platform"
  command "unzip android_sdk.zip"
end

directory "/opt/Webinos-Platform/anode" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

git "Checkout Code" do
  repository "git://github.com/paddybyers/anode.git"
  #reference "master" # or "HEAD" or "TAG_for_1.0" or (subversion) "1234"
  action :sync
  destination "/opt/Webinos-Platform/anode"
  retries 3
  user "vagrant"
  group "vagrant"
end

execute "Change android-sdk folder mode" do
  user "root"
  command "chown -R vagrant  /opt/Webinos-Platform/"
end

execute "Change android-sdk folder mode" do
  #user "root"
  command "chmod -R 0755  /opt/Webinos-Platform/"
end

execute "Build webinos-android" do
  user "vagrant"
  group "vagrant"
  cwd "/opt/Webinos-Platform/webinos/platform/android"
  command "ant"
  #retries 3
  #environment 'HOME' => '/home/vagrant'
  environment 'ANDROID_HOME' 	=> '/opt/Webinos-Platform/adt-bundle-linux-x86-20130219/sdk',
	      'ANODE_ROOT'	=> '/opt/Webinos-Platform/anode/'
end

