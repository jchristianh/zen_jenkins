#
# Cookbook Name:: zen_jenkins
# Recipe:: default
#
# Copyright (C) 2015 Chris Hammer <chris@thezengarden.net>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/gpl-2.0.txt>.


# Install Jenkins Repo/GPG Key First:
include_recipe "zen_jenkins::repo"


# Install Packages:
pkg_list = [
  'ruby','ruby-devel','rubygems-devel','zlib','zlib-devel',
  'git','patch','java-1.7.0-openjdk','jenkins'
]

pkg_list.each do |pkg|
  package pkg do
    action :install
  end
end


# Enable/Start Jenkins
service "jenkins" do
  action [:enable, :start]
end
