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

include_recipe "varnish::apt_repo"
include_recipe "varnish::default"
include_recipe "3scale_varnish::varnish_apt_source"

git "/usr/local/src/libvmod-3scale" do
  repository    "git://github.com/3scale/libvmod-3scale.git"
  action        :sync
  group         'admin'
  revision      node[:libvmod_3scale][:revision] # "e6bcbbddf9703ca4477826d8a39fef37998ecb04"
end
