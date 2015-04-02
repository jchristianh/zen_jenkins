#
# Cookbook Name:: zen_jenkins
# Recipe:: repo
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


cookbook_file "/etc/yum.repos.d" do
  source "jenkins.repo"
end


execute "import-jenkins-key" do
  command "rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key"
  not_if "rpm -qa gpg-pubkey*|grep gpg-pubkey-d50582e6-4a3feef6"
end
