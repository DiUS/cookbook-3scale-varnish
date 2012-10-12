#
# Cookbook Name:: 3scale_varnish
# Recipe:: 3scale_varnish_module
#
# Copyright 2012 SpringSense Pty Ltd.
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

include_recipe "build-essential"
include_recipe "varnish::apt_repo"
include_recipe "varnish::default"
include_recipe "3scale_varnish::varnish_apt_source"

package "libtool"

git "/usr/local/src/libvmod-3scale" do
  repository    "git://github.com/3scale/libvmod-3scale.git"
  action        :sync
  group         'admin'
  revision      node[:libvmod_3scale][:revision]
end

execute "cd /usr/local/src/libvmod-3scale && ./autogen.sh" do
  creates   "/usr/local/src/libvmod-3scale/configure"
end

execute "cd /usr/local/src/libvmod-3scale && ./configure VARNISHSRC=../varnish-3.0.0 VMODDIR=/usr/lib/varnish/vmods" do
  creates   "/usr/local/src/libvmod-3scale/Makefile"
end

execute "cd /usr/local/src/libvmod-3scale && make" do
  creates   "/usr/local/src/libvmod-3scale/src/libvmod_threescale.la"
end

execute "cd /usr/local/src/libvmod-3scale && make install" do
  creates   "/usr/lib/varnish/vmods/libvmod_threescale.la"

  notifies  :restart, resources(:service => "varnish"), :delayed
end
