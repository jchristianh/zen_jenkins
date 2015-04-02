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
cookbook_file "/etc/yum.repos.d/jenkins.repo" do
  source "jenkins.repo"
end


execute "import-jenkins-key" do
  command "rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  not_if "rpm -qa gpg-pubkey*|grep gpg-pubkey-d50582e6-4a3feef6"
end


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


# Create Ruby Syntax Check Script:
directory "/opt/bin" do
  action :create
  recursive true
end

cookbook_file "/opt/bin/ruby_syntax_check.pl" do
  source "ruby_syntax_check.pl"
end
