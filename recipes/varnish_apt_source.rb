# Cookbook Name:: 3scale_varnish
# Recipe:: varnish_apt_source
# Author:: Tal Rotbart <tal@springsense.com>
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

package 'libpcre3-dev'
package 'python-docutils'

execute "cd /usr/local/src && apt-get source varnish" do
end

execute "cd /usr/local/src/varnish-3.0.0 && ./autogen.sh" do
  creates "/usr/local/src/varnish-3.0.0/configure"
end

execute "cd /usr/local/src/varnish-3.0.0 && ./configure" do
  creates "/usr/local/src/varnish-3.0.0/Makefile"
end

execute "cd /usr/local/src/varnish-3.0.0 && make" do
  creates "/usr/local/src/varnish-3.0.0/bin/varnishd"
end

execute "cd /usr/local/src/varnish-3.0.0/lib/libvmod_std && make install" do
  creates "/usr/local/lib/varnish/vmods/libvmod_std.a"
end

link "/usr/lib/varnish/vmods" do
  to "/usr/local/lib/varnish/vmods"
end
